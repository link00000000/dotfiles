local keymap = require("utils.keymap")
local command = require("utils.command")
local path = require("utils.path");

local function init ()
    vim.g.vimwiki_list = {
        { path = path.sync.documents.vimwiki.get_path() }
    }

    vim.g.vimwiki_folding = "expr";
end

local function config ()
    command.create("VimwikiDevlog", "e " .. path.sync.documents.vimwiki.get_path() .. "/Devlog.wiki")
end

---@type PluginModule
return {
    spec = {
        "vimwiki/vimwiki",
        lazy = true,
        init = init,
        config = config,
        keys = {
            keymap.normal.lazy("<Leader>ww", function () 
                vim.cmd.tabnew()
                vim.cmd("VimikwiIndex")
            end),
        },
        cmd = {
            "VimwikiIndex", "VimwikiTabIndex", "VimwikiUISelect", "VimwikiDiaryIndex",
            "VimwikiMakeDiaryNote", "VimiwkiTabMakeDiaryNote", "VimwikiMakeYesterdayDiaryNote",
            "VimwikiMakeTomorrowDiaryNote",

            "VimwikiDevlog"
        }
    }
}
