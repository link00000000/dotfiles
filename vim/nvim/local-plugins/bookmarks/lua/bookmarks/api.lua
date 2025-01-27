local M = {}

---@class Bookmark
---@field id integer
---@field file string
---@field line integer

---@type Bookmark[]
M.bookmarks = {}

---@alias OnBookmarkAddEvent fun(bookmark: Bookmark)
---@alias OnBookmarkRemoveEvent fun(bookmark: Bookmark)
---@alias OnBookmarkUpdateEvent fun(old: Bookmark, new: Bookmark)

---@type { on_add: table<string, OnBookmarkAddEvent>, on_remove: table<string, OnBookmarkRemoveEvent>, on_update: table<string, OnBookmarkUpdateEvent> }
M.events = {
  on_add = {},
  on_remove = {},
  on_update = {},
}

---@param file string
---@param line integer
---@return Bookmark created_bookmark
M.create_bookmark = function (file, line)
  ---@type Bookmark
  local bookmark = { id = M.generate_bookmark_id(), file = file, line = line }

  table.insert(M.bookmarks, bookmark)

  for _, e in pairs(M.events.on_add) do
    e(bookmark)
  end

  return bookmark
end

---@param bookmark_id integer Id of the bookmark to remove
M.remove_bookmark = function (bookmark_id)
  local lists = require("utils.lists")

  local idx = lists.find_first_index_predicate(M.bookmarks, function (b) return b.id == bookmark_id end)
  if idx == lists.NO_INDEX then
    error("failed to remove bookmark. a bookmark with the id " .. bookmark_id .. " does not exist")
    return
  end

  for _, e in pairs(M.events.on_remove) do
    e(M.bookmarks[idx])
  end

  table.remove(M.bookmarks, idx)
end

---@param bookmark Bookmark
M.update_bookmark = function (bookmark)
  local lists = require("utils.lists")

  local idx = lists.find_first_index_predicate(M.bookmarks, function (item) return item.id == bookmark.id end)
  if idx == lists.NO_INDEX then
    error("failed to update bookmark. a bookmark with the id " .. bookmark.id .. " does not exist")
    return
  end

  local old_bookmark = M.bookmarks[idx]
  M.bookmarks[idx] = bookmark

  for _, e in pairs(M.events.on_update) do
    e(old_bookmark, bookmark)
  end
end

---@param file string
---@param line integer
---@return Bookmark? found_bookmark The bookmark for the file and line specified. If bookmark is not found, returns nil
M.find_bookmark = function (file, line)
  local lists = require("utils.lists")
  return lists.find_first_predicate(M.bookmarks, function (bookmark) return bookmark.file == file and bookmark.line == line end)
end

---@param bufnr integer
---@param bookmark Bookmark
---@return boolean success
M.place_sign = function (bufnr, bookmark)
  if M.find_sign(bufnr, bookmark) then
    return false
  end

  return vim.fn.sign_place(bookmark.id, require("bookmarks").SIGN_GROUP, require("bookmarks").SIGN_NAME, bookmark.file, { lnum = bookmark.line }) ~= -1
end

---@param bufnr integer
---@param bookmark Bookmark
---@return boolean success
M.remove_sign = function (bufnr, bookmark)
  if M.find_sign(bufnr, bookmark) == nil then
    return false
  end

  return vim.fn.sign_unplace(require("bookmarks").SIGN_GROUP, { buffer = bufnr, id = bookmark.id }) == 0
end

---@param bufnr integer
---@param bookmark Bookmark
---@return vim.fn.sign?
M.find_sign = function (bufnr, bookmark)
  return vim.fn.sign_getplaced(bufnr, { group = require("bookmarks").SIGN_GROUP, id = bookmark.id })[1].signs[1]
end

---@param bufnr integer
---@return vim.fn.sign[]
M.find_all_signs_for_buffer = function (bufnr)
  return vim.fn.sign_getplaced(bufnr, { group = require("bookmarks").SIGN_GROUP })[1].signs
end

---@param winnr integer 0 means the current window
---@param tabnr integer 0 means the current tab
---@return Bookmark[]
M.read_bookmarks_from_disk = function (winnr, tabnr)
  local filename = M.get_data_filename(winnr, tabnr)
  if vim.fn.filereadable(filename) == 0 then
    return {}
  end

  local file, err = io.open(filename, "r")
  if file then
    local file_content = file:read("*all")
    file:close()
    return vim.json.decode(file_content)
  else
    error("failed to open file \"" .. filename .. "\" for reading: " .. err)
    return {}
  end
end

---@param winnr integer 0 means the current window
---@param tabnr integer 0 means the current tab
---@param bookmarks Bookmark[]
M.write_bookmarks_to_disk = function (winnr, tabnr, bookmarks)
  local files = require("utils.files")

  local filename = M.get_data_filename(winnr, tabnr)
  if not vim.fn.filereadable(filename) then
    files.create_file(filename, true)
  else
    error("vim.fn.filereadable(filename) true")
  end

  local file, err = io.open(filename, "w")
  if file then
    local file_content = vim.json.encode(bookmarks)
    file:write(file_content)
    file:close()
  else
    error("failed to open file \"" .. filename .. "\" for writing: " .. err)
  end
end

---@param winnr integer 0 means the current window
---@param tabnr integer 0 means the current tab
---@return string filename
M.get_data_filename = function (winnr, tabnr)
  local config = require("bookmarks").config
  local filename_config = config.data_filename

  if type(filename_config) == "string" then
    return filename_config
  end

  return filename_config(winnr, tabnr)
end

---@return integer
M.generate_bookmark_id = function ()
  local config = require("bookmarks").config
  local lists = require("utils.lists")

  for i = 1, config.max_bookmark_id, 1 do
    if lists.contains_predicate(M.bookmarks, function (bookmark) return bookmark.id == i end) == false then
      return i
    end
  end

  error("failed to generate new id for bookmark. try increasing max_bookmark_id.")
end

return M
