return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                -- default
                "vim",
                "vimdoc",
                "lua",
                "luadoc",

                -- shell
                "bash",
                "gitcommit",
                "gitignore",
                "git_config",
                "git_rebase",
                "gitattributes",
                "diff",

                -- data
                "json",
                "json5",
                "jsonc",
                "toml",
                "yaml",
                "csv",
                "tsv",
                "xml",
                "gomod",
                "gosum",

                -- text
                "markdown",
                "markdown_inline",
                "regex",

                -- config
                "dockerfile",
                "make",
                "cmake",
                "ini",
                "nix",
                "passwd",
                "ssh_config",

                -- web
                "html",
                "css",
                "javascript",
                "typescript",
                "tsx",
                "jsdoc",
                "scss",
                "graphql",
                "http",
                "proto",
                "svelte",

                -- programming
                "c",
                "cpp",
                "go",
                "rust",
                "python",
                "java",
                "c_sharp",
                "sql",
                "groovy",
            },
        },
    },
}
