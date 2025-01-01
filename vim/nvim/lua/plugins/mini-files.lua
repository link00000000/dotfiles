return {
  "echasnovski/mini.files",
  version = "*",
  keys = {
    { "<Leader>fe", function () require("mini.files").open(vim.api.nvim_buf_get_name(0)) end, desc = "Open mini file picker" },
  },
  config = function ()
    require("mini.files").setup {}
  end
}
