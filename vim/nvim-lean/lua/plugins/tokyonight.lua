return {
  "folke/tokyonight.nvim",
  priority = 1000, -- make sure to load this plugin before all others in case they modify highlight groups
  config = function ()
    vim.cmd([[colorscheme tokyonight]])
  end
}
