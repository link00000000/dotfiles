local function init ()
    local path = require("utils.path");

    vim.g.vimwiki_list = {
        { path = path.sync.documents.vimwiki.get_path() }
    }
end

---@type PluginModule
return {
    spec = {
        "vimwiki/vimwiki",
        init = init,
    }
}
