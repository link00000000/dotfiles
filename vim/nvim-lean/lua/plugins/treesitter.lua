return {
  "nvim-treesitter/nvim-treesitter",
  config = function ()
    require("nvim-treesitter.configs").setup {}
  
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      command = "TSEnable highlight",
    })
  end,
}
