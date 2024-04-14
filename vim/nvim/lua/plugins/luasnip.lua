local setup_snippets = function ()
    -- Load filetype snippets
    for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/plugins/snippets/ft/*.lua", true)) do
        loadfile(ft_path)()
    end
end

---@type { [integer]: { mode: string, lhs: string, callback: function, expr: integer, noremap: integer, silent: integer, nowait: integer, script: integer }[] }
local cached_keymaps = {}

---@type { [integer]: { mode: mode, lhs: string }[] }
local applied_keymaps = {}

---@param mode mode|mode[]
---@param lhs string
---@param rhs string|function
---@param opts table|nil
local apply_luasnip_keymap = function (mode, lhs, rhs, opts)
    local bufnr = vim.api.nvim_get_current_buf()

    if type(mode) == "string" then
        mode = { mode }
    end

    for _, m in ipairs(mode) do
        -- Search for any existing keymaps that would be replaced. Cache then remove them
        for _, existing_keymap in ipairs(vim.api.nvim_buf_get_keymap(0, m)) do
            -- nvim_buf_get_keymap does not store lhs with <Leader>, it uses the literal value of whatever <Leader> is set to
            local existing_lhs = existing_keymap.lhs:gsub("<[Ll][Ee][Aa][Dd][Ee][Rr]>", vim.g.mapleader)
            if existing_lhs == lhs then
                if cached_keymaps[bufnr] == nil then
                    cached_keymaps[bufnr] = {}
                end

                table.insert(cached_keymaps[bufnr], existing_keymap)
                vim.api.nvim_buf_del_keymap(bufnr, m, lhs)
            end
        end

        -- Create new mapping
        vim.keymap.set(m, lhs, rhs, vim.tbl_deep_extend("force", opts, { buffer = bufnr }))

        if applied_keymaps[bufnr] == nil then
            applied_keymaps[bufnr] = {}
        end

        table.insert(applied_keymaps[bufnr], { mode = m, lhs = lhs })
    end
end

local revert_luasnip_keymaps = function ()
    local bufnr = vim.api.nvim_get_current_buf()

    -- Remove LuaSnip mappings and clear cached applied mappings
    for _, applied_keymap in ipairs(applied_keymaps[bufnr]) do
        vim.keymap.del(applied_keymap.mode, applied_keymap.lhs, { buffer = bufnr })
    end
    applied_keymaps[bufnr] = nil

    -- Re-apply cached mappings and remove them from the cache
    for _, cached_keymap in ipairs(cached_keymaps[bufnr] or {}) do
        local opts = {}

        ---@param int integer
        local int_to_bool = function (int)
            return int ~= 0
        end

        opts.buffer = bufnr
        opts.noremap = int_to_bool(cached_keymap.noremap)
        opts.expr = int_to_bool(cached_keymap.expr)
        opts.silent = int_to_bool(cached_keymap.silent)
        opts.nowait = int_to_bool(cached_keymap.nowait)
        opts.script = int_to_bool(cached_keymap.script)

        vim.keymap.set(cached_keymap.mode, cached_keymap.lhs, cached_keymap.callback, opts)
    end
    cached_keymaps[bufnr] = nil
end

---@type PluginModule
return {
    spec = {
        'L3MON4D3/LuaSnip',
        config = function ()
            local ls = require("luasnip")

            -- TODO: Look into history and if that is something I want
            ls.setup({
                update_events = "TextChanged,TextChangedI",
            })

            -- Keymaps
            local augroup = vim.api.nvim_create_augroup("LuaSnipKeymaps", { clear = true })
            vim.api.nvim_create_autocmd("User", {
                group = augroup,
                pattern = "LuasnipInsertNodeEnter",
                callback = function ()
                    apply_luasnip_keymap({ "i", "s" }, "<Tab>", function () ls.jump(1) end, { desc = "Jump to next LuaSnip input", silent = false, buffer = 0 })
                    apply_luasnip_keymap({ "i", "s" }, "<S-Tab>", function () ls.jump(-1) end, { desc = "Jump to previous LuaSnip input", silent = true, buffer = 0 })
                end,
            })

            vim.api.nvim_create_autocmd("User", {
                group = augroup,
                pattern = "LuasnipInsertNodeLeave",
                callback = revert_luasnip_keymaps,
            })

            vim.api.nvim_create_user_command("LuaSnipReload", setup_snippets, { desc = "Reload LuaSnip snippets" })
            setup_snippets()
        end,
    },
}
