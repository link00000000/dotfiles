return {
  "stevearc/oil.nvim",
  dependencies = { require("plugins.web-devicons") },
  cmd = { "Oil" },
  keys = {
    {
      "<Leader>f",
      function()
        local buf_parent = vim.fn.expand("%:p:h")

        if #buf_parent > 0 then
          require("oil").open(buf_parent)
          return true
        end

        return false
      end
      ,
      desc = "Open Oil in the parent directory of the current buffer"
    },
    {
      "<Leader>F",
      function()
        local cwd = vim.fn.getcwd()

        if #cwd > 0 then
          require("oil").open(cwd)
          return true
        end

        return false
      end
      ,
      desc = "Open Oil in the current working directory"
    },
  },
  config = function()
    require("oil").setup {
      default_file_explorer = true,
      delete_to_trash = true,

      constain_cursor = "name",
      columns = { "icon" },

      use_default_keymaps = false,
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<BS>"] = "actions.parent",
        ["<C-h>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        ["<C-v>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
        ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
        ["<Tab>"] = "actions.preview",
        ["q"] = "actions.close",
        ["<C-r>"] = "actions.refresh",
        ["-"] = "actions.open_cwd",
        ["="] = "action.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },

      view_options = {
        show_hidden = true,
        natrual_order = true,
        case_insensitive = true,
        is_always_hidden = function (name, bufnr)
          return name == ".." or name == ".git"
        end,
        sort = {
          { "type", "asc" },
          { "name", "asc" },
        },
      },

      float = {
        border = require("config.style").border,
      },

      preview = {
        border = require("config.style").border,
      },

      progress = {
        border = require("config.style").border,
      },

      ssh = {
        border = require("config.style").border,
      },

      keymaps_help = {
        border = require("config.style").border,
      },
    }
  end,
}
