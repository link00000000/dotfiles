local M = {}

M.create = function (base_spec, build)
    spec = base_spec or {}

    local function add_spec_key (key)
        spec.keys = spec.keys or {}
        spec.keys:append(key)
    end

    local spec_builder = {

        set_config = function (config)
            spec.config = config
        end,

        create_command = function (name, func, opts)
            opts = opts or {}
            spec.cmd = spec.cmd or {}

            vim.api.nvim_create_user_command(name, func, opts)
            spec.cmd:append(name)
        end,

        create_keymap = {

            set = function (modes, chord, action, opts)
                add_spec_key(keymap.set(modes, chord, action, opts).lazy)
            end,

            all = function (chord, action, opts)
                add_spec_key(keymap.all(chord, action, opts).lazy)
            end,

            normal = function (chord, action, opts)
                add_spec_key(keymap.normal(chord, action, opts).lazy)
            end,

            insert = function (chord, action, opts)
                add_spec_key(keymap.insert(chord, action, opts).lazy)
            end,

            visual = function (chord, action, opts)
                add_spec_key(keymap.visual(chord, action, opts).lazy)
            end,

            command = function (chord, action, opts)
                add_spec_key(keymap.command(chord, action, opts).lazy)
            end,

            terminal = function (chord, action, opts)
                add_spec_key(keymap.terminal(chord, action, opts).lazy)
            end,

            select = function (chord, action, opts)
                add_spec_key(keymap.select(chord, action, opts).lazy)
            end,

            visual_only = function (chord, action, opts)
                add_spec_key(keymap.visual_only(chord, action, opts).lazy)
            end,
        }
    }

    build(spec_builder)

    return spec
end

return M
