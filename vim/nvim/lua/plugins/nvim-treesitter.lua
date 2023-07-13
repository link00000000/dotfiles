-- Requires a C compiler. On Windows `scoop install zig`
-- Some languages require tree-sitter-cli `npm i -g tree-sitter-cli`

local M = {}

local function config ()
    local treesitter = require('nvim-treesitter.configs')
    local treesitter_install = require('nvim-treesitter.install')

    treesitter_install.compilers = { 'zig', vim.fn.getenv('CC'), 'cc', 'gcc', 'clang', 'cl' }

    treesitter.setup({
        -- A list of parser names, or "all"
        ensure_installed = {
            "bash",
            "c",
            "c_sharp",
            "cmake",
            "comment",
            "cpp",
            "css",
            "dockerfile",
            "gitcommit",
            "gitignore",
            "html",
            "javascript",
            "jsdoc",
            "json",
            "json5",
            "jsonc",
            "lua",
            "make",
            "markdown",
            "markdown_inline",
            "python",
            "regex",
            "scss",
            "sql",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "yaml"
        },

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        highlight = {
            -- Disable for large files
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
        },
    })
end

M.spec = {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = true,
    config = config,
    event = { 'BufEnter' },
    cmd = {
        'TSBufToggle',
        'TSEnable',
        'TSBufEnable',
        'TSEditQuery',
        'TSDisable',
        'TSUpdate',
        'TSToggle',
        'TSInstall',
        'TSUninstall',
        'TSBufDisable',
        'TSConfiglnfo',
        'TSModulelnfo',
        'TSUpdateSync',
        'TSInstalllnfo',
        'TSInstallSync',
        'TSEditQueryUserAfter',
        'TSInstaIIFrornGramar',
    }
}

return M
