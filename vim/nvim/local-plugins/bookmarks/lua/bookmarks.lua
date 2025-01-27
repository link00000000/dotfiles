local M = {}

M.SIGN_GROUP = "BookmarksPlugin"
M.SIGN_NAME = "BookmarksPlugin_Bookmark"
M.HIGHLIGHT_TEXT = "BookmarksPlugin_Text"

---@class BookmarksPluginOptionsConfig
---@field sign { text: string? }?
---@field data_filename (string|fun(winnr: integer, tabnr: integer): string)?
---@field max_bookmark_id integer?
---@field register_user_commands boolean?
---@field register_autocmds boolean?
---@field register_sign boolean?
---@field register_highlight boolean?

---@class BookmarksPluginOptions
---@field data_filename (string|fun(winnr: integer, tabnr: integer): string)
---@field max_bookmark_id integer
---@field register_user_commands boolean
---@field register_autocmds boolean
---@field register_sign boolean
---@field register_highlight boolean

---@type BookmarksPluginOptions
local default_opts = {
  sign = {
    text = "B"
  },
  data_filename = vim.fn.stdpath("data") .. "/bookmarks/" .. vim.fn.sha256(vim.fn.getcwd()) .. ".json",
  max_bookmark_id = 0xffff,
  register_user_commands = true,
  register_autocmds = true,
  register_sign = true,
  register_highlight = true
}

---@param opts BookmarksPluginOptionsConfig?
M.setup = function (opts)
  M.config = vim.tbl_deep_extend("force", default_opts, opts or {})

  if M.config.max_bookmark_id <= 0 then
    error("invalid value for max_bookmark_id. value must be a positive integer")
    return
  end

  if M.config.register_autocmds then
    M.register_user_commands()
  end

  if M.config.register_autocmds then
    M.register_autocmds()
  end

  if M.config.register_sign then
    M.register_sign()
  end

  if M.config.register_highlight then
    M.register_highlight()
  end
end

M.register_user_commands = function ()
  vim.api.nvim_create_user_command("BookmarksShowUI", function () require("bookmarks.ui").show() end, { desc = "Show bookmarks", force = true })
  vim.api.nvim_create_user_command("BookmarksHideUI", function () require("bookmarks.ui").hide() end, { desc = "Hide bookmarks", force = true })
  vim.api.nvim_create_user_command("BookmarksToggleUI", function () require("bookmarks.ui").toggle() end, { desc = "Hide bookmarks", force = true })

  --- Command format: BookmarksAddAt /absolute/file/path line_number
  vim.api.nvim_create_user_command("BookmarksAddAt", function (command)
    local api = require("bookmarks.api")

    if #command.fargs ~= 2 then
      error("command BookmarksToggleAt requires exactly 2 argument")
    end

    local file = command.fargs[1]
    local line = tonumber(command.fargs[2])

    if line == nil then
      error("line argument must be a number")
    end
    line = math.floor(line)

    local bookmark = api.find_bookmark(file, line)
    if bookmark == nil then
      api.create_bookmark(file, line)
    end
  end, { nargs = "*", desc = "Add a bookmark for the file and line specified", force = true })

  vim.api.nvim_create_user_command("BookmarksAddCursor", function (command)
    local api = require("bookmarks.api")

    local file = vim.api.nvim_buf_get_name(0)
    local line = command.line2
    local bookmark = api.find_bookmark(file, line)

    if bookmark == nil then
      api.create_bookmark(file, line)
    end
  end, { range = true, desc = "Add a bookmark at current cursor position", force = true })

  --- Command format: BookmarksRemoveAt /absolute/file/path line_number
  vim.api.nvim_create_user_command("BookmarksRemoveAt", function (command)
    local api = require("bookmarks.api")

    if #command.fargs ~= 2 then
      error("command BookmarksToggleAt requires exactly 2 argument")
    end

    local file = command.fargs[1]
    local line = tonumber(command.fargs[2])

    if line == nil then
      error("line argument must be a number")
    end
    line = math.floor(line)

    local bookmark = api.find_bookmark(file, line)
    if bookmark ~= nil then
      api.remove_bookmark(bookmark.id)
    end
  end, { nargs = "*", desc = "Remove a bookmark for the file and line specified", force = true })

  vim.api.nvim_create_user_command("BookmarksRemoveCursor", function (command)
    local api = require("bookmarks.api")

    local file = vim.api.nvim_buf_get_name(0)
    local line = command.line2
    local bookmark = api.find_bookmark(file, line)

    if bookmark ~= nil then
      api.remove_bookmark(bookmark.id)
    end

  end, { range = true, desc = "Remove a bookmark from the current cursor position", force = true })

  --- Command format: BookmarksToggleAt /absolute/file/path line_number
  vim.api.nvim_create_user_command("BookmarksToggleAt", function (command)
    local api = require("bookmarks.api")

    if #command.fargs ~= 2 then
      error("command BookmarksToggleAt requires exactly 2 argument")
    end

    local file = command.fargs[1]
    local line = tonumber(command.fargs[2])

    if line == nil then
      error("line argument must be a number")
    end
    line = math.floor(line)

    local bookmark = api.find_bookmark(file, line)
    if bookmark == nil then
      api.create_bookmark(file, line)
    else
      api.remove_bookmark(bookmark.id)
    end
  end, { nargs = "*", desc = "Toggle a bookmark for the file and line specified", force = true })

  vim.api.nvim_create_user_command("BookmarksToggleCursor", function (command)
    local api = require("bookmarks.api")

    local file = vim.api.nvim_buf_get_name(0)
    local line = command.line2
    local bookmark = api.find_bookmark(file, line)

    if bookmark == nil then
      api.create_bookmark(file, line)
    else
      api.remove_bookmark(bookmark.id)
    end
  end, { range = true, desc = "Toggle a bookmark for the current cursor position", force = true })
end

M.register_autocmds = function ()
  local augroup = vim.api.nvim_create_augroup("BookmarksPluginSigns", { clear = true })

  vim.api.nvim_create_autocmd({ "BufAdd" }, {
    group = augroup,
    callback = function ()
      local api = require("bookmarks.api")
      local lists = require("utils.lists")

      local bookmarks = lists.filter(api.bookmarks, function (bookmark) return vim.api.nvim_buf_get_name(0) == bookmark.file end)
      for _, bookmark in ipairs(bookmarks) do
        local sign = api.find_sign(0, bookmark)
        if sign ~= nil then
          api.place_sign(0, bookmark)
        end
      end

      api.events.on_add.bookmarks_plugins_signs_bufadd = function (bookmark)
        local sign = api.find_sign(0, bookmark)
        if sign == nil then
          api.place_sign(0, bookmark)
        end
      end

      api.events.on_remove.bookmarks_plugins_signs_bufadd = function (bookmark)
        local sign = api.find_sign(0, bookmark)
        if sign ~= nil then
          api.remove_sign(0, bookmark)
        end
      end
    end
  })

  vim.api.nvim_create_autocmd({ "BufDelete" }, {
    group = augroup,
    callback = function ()
      local api = require("bookmarks.api")

      api.events.on_add.bookmarks_plugins_signs_bufadd = nil
      api.events.on_remove.bookmarks_plugins_signs_bufadd = nil
    end
  })

  vim.api.nvim_create_autocmd({ "BufWrite" }, {
    group = augroup,
    callback = function ()
      local api = require("bookmarks.api")

      for _, sign in ipairs(api.find_all_signs_for_buffer(0)) do
        local file = vim.api.nvim_buf_get_name(0)
        api.update_bookmark({ id = sign.id, file = file, line = sign.lnum })
      end

      api.write_bookmarks_to_disk(0, 0, api.bookmarks)
    end
  })

  vim.api.nvim_create_autocmd({ "CursorHold" }, {
    group = augroup,
    callback = function ()
      local api = require("bookmarks.api")

      for _, sign in ipairs(api.find_all_signs_for_buffer(0)) do
        local file = vim.api.nvim_buf_get_name(0)
        api.update_bookmark({ id = sign.id, file = file, line = sign.lnum })
      end
    end
  })
end

---@return boolean success
M.register_sign = function ()
  return vim.fn.sign_define(M.SIGN_NAME, { text = M.config.sign.text, texthl = M.HIGHLIGHT_TEXT }) == 0
end

M.register_highlight = function ()
  vim.cmd("highlight link " .. M.HIGHLIGHT_TEXT .. " ErrorMsg") -- TODO: highlights
end

return M
