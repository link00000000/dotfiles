local keymap = require('utils.keymap')

local M = {}

local function on_attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end


    keymap.normal.apply('<CR>', api.node.open.edit, opts('Open'))
    keymap.normal.apply('l', api.node.open.edit, opts('Open'))
    keymap.normal.apply('<2-LeftMouse>', api.node.open.edit, opts('Open'))
    keymap.normal.apply('<C-]>', api.tree.change_root_to_node, opts('CD'))
    keymap.normal.apply('<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
    keymap.normal.apply('v', api.node.open.vertical, opts('Open: Vertical Split'))
    keymap.normal.apply('s', api.node.open.horizontal, opts('Open: Horizontal Split'))
    keymap.normal.apply('t', api.node.open.tab, opts('Open: New Tab'))
    keymap.normal.apply('h', api.node.navigate.parent_close, opts('Close Directory'))
    keymap.normal.apply('<Tab>', api.node.open.preview, opts('Open Preview'))
    keymap.normal.apply('K', api.node.navigate.sibling.first, opts('First Sibling'))
    keymap.normal.apply('J', api.node.navigate.sibling.last, opts('Last Sibling'))
    keymap.normal.apply('C', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
    keymap.normal.apply('I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
    keymap.normal.apply('H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
    keymap.normal.apply('B', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
    keymap.normal.apply('U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
    keymap.normal.apply('R', api.tree.reload, opts('Refresh'))
    keymap.normal.apply('n', api.fs.create, opts('Create'))
    keymap.normal.apply('D', api.fs.remove, opts('Delete'))
    keymap.normal.apply('r', api.fs.rename, opts('Rename'))
    keymap.normal.apply('c', api.fs.copy.node, opts('Copy'))
    keymap.normal.apply('x', api.fs.cut, opts('Cut'))
    keymap.normal.apply('p', api.fs.paste, opts('Paste'))
    keymap.normal.apply('y', api.fs.copy.filename, opts('Copy Name'))
    keymap.normal.apply('Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
    keymap.normal.apply('-', api.tree.change_root_to_parent, opts('Up'))
    keymap.normal.apply('f', api.live_filter.start, opts('Filter'))
    keymap.normal.apply('F', api.live_filter.clear, opts('Clean Filter'))
    keymap.normal.apply('q', api.tree.close, opts('Close'))
    keymap.normal.apply('S', api.tree.search_node, opts('Search'))
    keymap.normal.apply('.', api.node.run.cmd, opts('Run Command'))
    keymap.normal.apply('<C-k>', api.node.show_info_popup, opts('Info'))
    keymap.normal.apply('g?', api.tree.toggle_help, opts('Help'))

end

local function config ()
    local nvim_tree = require('nvim-tree')
    local codicons = require('codicons')

    nvim_tree.setup({
        on_attach = on_attach,
        sort_by = "case_sensitive",
        sync_root_with_cwd = true,
        view = {
            adaptive_size = true,
            mappings = {
                custom_only = true,
            }
        },
        update_focused_file = {
            enable = true,
        },
        renderer = {
            group_empty = true,
            icons = {
                webdev_colors = true,
                git_placement = "after",
                modified_placement = "before",
                padding = " ",
                symlink_arrow = " " .. codicons.get("arrow-small-right") .. " ",
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true,
                    modified = true,
                },
                glyphs = {
                    default = codicons.get("symbol-file"),
                    symlink = codicons.get("file-symlink-file"),
                    bookmark = codicons.get("check"),
                    modified = codicons.get("circle-filled"),
                    folder = {
                        arrow_closed = codicons.get("chevron-right"),
                        arrow_open = codicons.get("chevron-down"),
                        default = "",
                        open = "",
                        empty = "",
                        empty_open = "",
                        symlink = "",
                        symlink_open = "",
                    },
                    git = {
                        unstaged = "",
                        staged = "",
                        unmerged = "",
                        renamed = codicons.get('diff-renamed'),
                        untracked = codicons.get('diff-added'),
                        deleted = codicons.get('diff-removed'),
                        ignored = codicons.get('diff-ignored'),
                    },
                },
            },
        },
        filters = {
            dotfiles = false,
        }
    })
end

local function open_tree ()
    local nvim_tree_api = require('nvim-tree.api')

    nvim_tree_api.tree.open()
end

local function create_file ()
    local nvim_tree_api = require('nvim-tree.api')
    nvim_tree_api.fs.create()
end

local function delete_current_file ()
    local nvim_tree_api = require('nvim-tree.api')
    nvim_tree_api.fs.remove()
end

M.spec = {
    'nvim-tree/nvim-tree.lua',
    lazy = true,
    config = config,
    dependencies = {
        require('plugins.codicons').spec
    },
    keys = {
        keymap.normal.lazy('<Leader>ff', open_tree),
        keymap.normal.lazy('<Leader>fn', create_file),
        keymap.normal.lazy('<Leader>fd', delete_current_file),
    },
    cmd = {
        "NvimTreeOpen", "NvimTreeClose", "NvimTreeToggle",
        "NvimTreeFocus", "NvimTreeRefresh", "NvimTreeFindFile",
        "NvimTreeFindFileToggle", "NvimTreeClipboard", "NvimTreeResize",
        "NvimTreeCollapse", "NvimTreeCollapseKeepBuffers", "NvimTreeGenerateOnAttach"
    }
}

return M
