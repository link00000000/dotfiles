local function config()
    local nvim_ts_autotag = require("nvim-ts-autotag")

    nvim_ts_autotag.setup()
end

---@type PluginModule
return {
    spec = {
        "windwp/nvim-ts-autotag",
        lazy = true,
        config = config,
        ft = {
            "html",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "svelte",
            "vue",
            "tsx",
            "jsx",
            "rescript",
            "xml",
            "php",
            "markdown",
            "astro",
            "glimmer",
            "handlebars",
            "hbs"
        }
    }
}
