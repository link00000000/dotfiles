local M = {}

---Finds all buffers matching the predicate
---@param predicate fun(integer)
---@return integer[] found_bufnrs List of bufnrs of buffers that match the predicate. If not buffers are found, returns an empty list.
M.find_buffers_by_predicate = function (predicate)
  ---@type integer[]
  return require("utils.lists").find_all_predicate(vim.api.nvim_list_bufs(), predicate)
end

---Finds the buffer that has the filename specified
---@param filename any
---@return integer|nil found_bufnr Bufnr of the buffer with the filename specified. Returns nil if not found.
M.find_buffer_by_filename = function (filename)
  return require("utils.lists").find_first_predicate(
    vim.api.nvim_list_bufs(),
    function (bufnr) return vim.api.nvim_buf_get_name(bufnr) == filename end
  )
end

return M
