local path = require('utils.path')

local M = {}

local lazy_path = path.get_nvim_data_dir('lazy/lazy.nvim')

local function is_lazy_installed()
    return vim.loop.fs_stat(lazy_path)
end

local function install_lazy()
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazy_path,
    })
end

M.setup = function ()
    if not is_lazy_installed() then
        install_lazy()
    end

    vim.opt.rtp:prepend(lazy_path)

    require('lazy').setup({

        -- Appearance
        require('plugins.colorschemes').spec,
        require('plugins.shade').spec,

        -- Layout / Statusline / Tabline
        require('plugins.luatab').spec,
        require('plugins.fterm').spec,
        require('plugins.lualine').spec,
        require('plugins.nvim-tree').spec,
        require('plugins.nvim-treesitter').spec,
        require('plugins.todo-comments').spec,
        require('plugins.lspconfig').spec,
        require('plugins.barbecue').spec,
        require('plugins.telescope').spec,

        -- LSP / Intellisense / Syntax / Highlightinqg
        require("plugins.nvim-cmp").spec,
        require("plugins.nvim-autopairs").spec,
        require("plugins.trouble").spec,
        require("plugins.symbols-outline").spec,

        -- Snippets
        require("plugins.luasnip").spec,

        -- Comments
        require("plugins.comment").spec,

        -- Git / Version Control
        require("plugins.gitsigns").spec,

        -- Misc.
        require("plugins.alpha").spec,
        require("plugins.file-line").spec,
    })
end

return M
