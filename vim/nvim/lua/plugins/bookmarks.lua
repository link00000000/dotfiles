return {
  {
    dir = vim.fn.stdpath("config") .. "/local-plugins/bookmarks",
    config = function ()
      require("bookmarks").setup {
        sign = { text = "M" }
      }
    end,
    keys = {
      { "<leader>bt", "<cmd>BookmarksToggle<cr>" }
    },
    dependencies = {
      { dir = vim.fn.stdpath("config") .. "/local-plugins/utils" }
    }
  },
}
