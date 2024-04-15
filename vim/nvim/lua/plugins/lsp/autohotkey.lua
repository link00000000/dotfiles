-- TODO:
-- * Download and extract language server
-- * Make sure language server works

local path = require("plenary.path")

local ls_path = path:new{vim.fn.stdpath("data"), "vscode-autohotkey2-lsp"} --[[@as Path]]

local find_interpreter = function ()
    local search_paths = {
        "AutoHotkey.exe", -- On the systm path
        "AutoHotkey", -- On the system path
        "C:/Program Files/AutoHotkey/v2/AutoHotkey.exe",
        "C:/Program Files (x64)/AutoHotkey/v2/AutoHotkey.exe",
    }

    for _, search_path in pairs(search_paths) do
        if vim.fn.executable(search_path) == 1 then
            return search_path
        end
    end

    vim.notify("Could not find AutoHotkey 2 interpreter path", vim.log.levels.ERROR)

    return nil
end

local download_ls = function ()
    local path = require("plenary.path")
    local archive_path = path:new{vim.fn.stdpath("cache"), "vscode-autohotkey2-lsp.zip"}
    local archive_extract_path = path:new{vim.fn.stdpath("cache"), "vscode-autohotkey2-lsp.zip"}

    vim.fn.system("curl -o " .. archive_path .. " https://marketplace.visualstudio.com/_apis/public/gallery/publishers/thqby/vsextensions/vscode-autohotkey2-lsp/2.4.1/vspackage")
    vim.fn.system("7z e " .. archive_path .. "extension/server/dist/server.js -o " .. archive_extract_path)
end

local check_ls_installed = function ()
    if ls_path:exists(path:new{ls_path, "server/dist/server.js"}) then
        return true
    end

    local should_download = vim.fn.confirm("AutoHotkey 2 language server not installed. Download now?", "&Yes\n&No",  2) == 1
    if not should_download then
        return false
    end

    return download_ls()
end

local register_with_lspconfig = function ()
    local interpreter_path = find_interpreter()
    if interpreter_path == nil then
        return nil
    end

    local default_config = {
        autostart = true,
        cmd = { "node", ls_path, "--stdio" },
        filetypes = { "ahk", "ahk2", "autohotkey" },
        init_options = {
            locale = "en-us",
            InterpreterPath = interpreter_path,
        },
        single_file_support = true,
        flags = { debounce_text_changes = 500, },
    }

    require("lspconfig.configs")["ahk2"] = { default_config = default_config, }
end

return {
    register_with_lspconfig = register_with_lspconfig,
}
