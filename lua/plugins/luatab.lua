local keymap = require('utils.keymap')

local function config ()
    local luatab = require('luatab')
    local luatab_highlight = require('luatab.highlight')

    local title = luatab.helpers.title
    local modified = luatab.helpers.modified
    local windowCount = luatab.helpers.windowCount
    local devicon = luatab.helpers.devicon
    local separator = luatab.helpers.separator
    local cell = luatab.helpers.cell
    local tabline = luatab.helpers.tabline

    -- Display the tab index next to the name for easier keyboard navigation.
    -- Do not display any tab indices after 9 since there is no keybind to jump to the tab
    local tabIndex = function (index)
        if index <= 9 then
            return '[' .. index .. ']'
        else
            return ''
        end
    end

    -- Modified version of luatab.helpers.modified to use a dot to indicate a modified file
    modified = function (bufnr)
        return vim.fn.getbufvar(bufnr, '&modified') == 1 and '● ' or ''
    end

    -- Modified version of luatab.helpers.devicon to always color devicon
    devicon = function (bufnr, isSelected)
        local icon, devhl
        local file = vim.fn.bufname(bufnr)
        local buftype = vim.fn.getbufvar(bufnr, '&buftype')
        local filetype = vim.fn.getbufvar(bufnr, '&filetype')
        local devicons = require'nvim-web-devicons'
        if filetype == 'TelescopePrompt' then
            icon, devhl = devicons.get_icon('telescope')
        elseif filetype == 'fugitive' then
            icon, devhl = devicons.get_icon('git')
        elseif filetype == 'vimwiki' then
            icon, devhl = devicons.get_icon('markdown')
        elseif buftype == 'terminal' then
            icon, devhl = devicons.get_icon('zsh')
        else
            icon, devhl = devicons.get_icon(file, vim.fn.expand('#'..bufnr..':e'))
        end
        if icon then
            local fg = luatab_highlight.extract_highlight_colors(devhl, 'fg')
            local bg
            if isSelected then
                bg = luatab_highlight.extract_highlight_colors('TabLineSel', 'bg')
            else
                bg = luatab_highlight.extract_highlight_colors('TabLine', 'bg')
            end

            local hl = luatab_highlight.create_component_highlight_group({bg = bg, fg = fg}, devhl)
            local selectedHlStart = (isSelected and hl) and '%#'..hl..'#' or ''
            local selectedHlEnd = isSelected and '%#TabLineSel#' or ''
            return selectedHlStart .. icon .. selectedHlEnd .. ' '
        end
        return ''
    end

    -- modified version of luatab.helpers.cell to display devicon before file name and remove window count
    cell = function (index)
        local isSelected = vim.fn.tabpagenr() == index
        local buflist = vim.fn.tabpagebuflist(index)
        local winnr = vim.fn.tabpagewinnr(index)
        local bufnr = buflist[winnr]
        local current_label = luatab.helpers.get_user_specified_tab_name(index)
        local hl = (isSelected and '%#TabLineSel#' or '%#TabLine#')

        return hl .. '%' .. index .. 'T' .. ' ' ..
        tabIndex(index) .. ' ' ..
        devicon(bufnr, isSelected) ..
        title(bufnr, current_label) .. ' ' ..
        modified(bufnr) ..
        separator(index) .. '%T'
    end

    luatab.setup({
        title = title,
        modified = modified,
        windowCount = windowCount,
        devicon = devicon,
        separator = separator,
        cell = cell,
        tabline = tabline,
    })
end

return {
    'link00000000/luatab.nvim',
    lazy = true,
    config = config,
    dependencies = {
        require('plugins.nvim-web-devicons'),
    },
    keys = {
        keymap.normal.lazy("<Leader>tr", function () require('luatab').rename_tab() end, { desc = "Rename tab" })
    },
    event = { "TabEnter" }
}
