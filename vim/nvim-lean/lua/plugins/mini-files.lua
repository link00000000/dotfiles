return {
  "echasnovski/mini.files",
  version = "*",
  keys = {
    { "<Leader>f", function () require("mini.files").open() end, desc = "Open mini file picker" },
  },
  config = function ()
    require("mini.files").setup {
      mappings = {
        syncronize = "<CR>",
      }
    }
  end
}
