return {
  "nvim-treesitter/nvim-treesitter",
  version = "*",
  dependencies = { "nushell/tree-sitter-nu" },
  config = function ()
    require("nvim-treesitter.configs").setup {}
  
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      command = "TSEnable highlight",
    })
  end,
}
