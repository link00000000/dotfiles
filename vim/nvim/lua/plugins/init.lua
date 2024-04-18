local path = require('utils.path')

local lazy_path = path.resolve_nvim_data_dir_path('lazy/lazy.nvim')

---@return boolean
local function is_lazy_installed()
    if vim.loop.fs_stat(lazy_path) then
        return true
    else
        return false
    end
end

---@return nil
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

---@type ConfigModule
return {
    setup = function ()
        if not is_lazy_installed() then
            install_lazy()
        end

        vim.opt.rtp:prepend(lazy_path)

        require('lazy').setup({

            -- Appearance
            require("plugins.colorschemes.tokyonight").spec,

            -- Layout / Statusline / Tabline / Status Column
            require('plugins.luatab').spec, -- TODO: Replace with custom implementation in lualine
            require('plugins.fterm').spec,
            require('plugins.lualine').spec,
            require('plugins.nvim-treesitter').spec,
            require('plugins.todo-comments').spec,
            require('plugins.barbecue').spec,
            require("plugins.dressing").spec,
            require("plugins.statuscol").spec,

            -- Navigation
            require("plugins.nvim-hlslens").spec,
            require('plugins.nvim-tree').spec,
            require('plugins.telescope').spec,
            require("plugins.oil").spec,

            -- LSP / Intellisense / Syntax / Highlighting
            require("plugins.mason-lspconfig").spec,
            require("plugins.nvim-cmp").spec,
            require("plugins.nvim-autopairs").spec,
            require("plugins.trouble").spec,
            require("plugins.symbols-outline").spec,
            require("plugins.glance").spec,
            require("plugins.vim-razor").spec,
            require("plugins.nvim-nu").spec,
            require("plugins.nvim-ts-autotag").spec,
            require("plugins.indent-blankline").spec,

            -- Style / Formatting
            require("plugins.mason-null-ls").spec,

            -- Debugging
            require("plugins.mason-nvim-dap").spec,
            require("plugins.nvim-dap-virtual-text").spec,
            require("plugins.nvim-dap-ui").spec,
            require("plugins.nvim-projector").spec,
            require("plugins.dap.go").spec,

            -- Snippets
            require("plugins.luasnip").spec,

            -- Comments / Text editing
            require("plugins.comment").spec,
            require("plugins.nvim-surround").spec,
            require("plugins.multicursors").spec,
            -- require("plugins.vim-visual-multi").spec,

            -- Git / Version Control
            require("plugins.gitsigns").spec,

            -- Misc.
            require("plugins.alpha").spec,
            require("plugins.file-line").spec,
            require("plugins.vimwiki").spec,
            require("plugins.venn").spec,
            require("plugins.which-key").spec,
            require("plugins.nvim-unception").spec,
            require("plugins.nvim-treesitter-playground").spec,
        }, { change_detection = { enabled = true, notify = true } })
    end
}
