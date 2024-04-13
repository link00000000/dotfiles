-- Requires a C compiler. On Windows `scoop install zig`
-- Some languages require tree-sitter-cli `npm i -g tree-sitter-cli`

---@type PlugiNModule
return {
    spec = {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        lazy = false,
        config = function ()
            require("nvim-treesitter.install").compilers = { 'zig', vim.fn.getenv('CC'), 'cc', 'gcc', 'clang', 'cl' }
            require("nvim-treesitter.configs").setup({
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
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    }
}
