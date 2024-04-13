local keymap = require('utils.keymap')
local command = require("utils.command")

local setup_settings = function ()
    vim.opt.compatible = false
    vim.opt.termguicolors = true
    vim.opt.updatetime = 100

    -- Highlight the current line
    vim.opt.cursorline = true

    -- Map <Space> to leader
    keymap.normal.apply('<Space>', '<NOP>')
    vim.g.mapleader = ' '

    -- Enabled mouse supoort
    vim.opt.mouse = 'a'

    -- Use system clipboard
    vim.opt.clipboard:prepend({ "unnamed", "unnamedplus" })

    -- Disabled word wrap
    vim.opt.wrap = false

    -- Force word wrapping for markdown
    vim.cmd([[

    augroup markdown_config
        autocmd!

        autocmd FileType markdown set wrap
        autocmd FileType markdown set linebreak
    augroup END

    ]])

    -- Split panes
    vim.o.splitbelow = true
    vim.o.splitright = true

    -- Indentation
    vim.opt.expandtab = true
    vim.opt.smarttab = true
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4

    -- Ignore case when searching if search contains only lower case
    vim.opt.ignorecase = true
    vim.opt.smartcase = true

    -- Show a few lines of context acround the cursor
    vim.opt.scrolloff = 5
    vim.opt.sidescrolloff = 10

    -- Always delete previous word when deleting entire words
    vim.opt.backspace = { 'indent', 'eol', 'start' }

    -- Enable line numbers
    vim.opt.number = true

    -- Disable error bell
    vim.opt.visualbell = true
    vim.opt.errorbells = false

    -- Show all folds expanded when a file is opened
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    vim.opt.foldenable = true

    -- Force gutter to always be visible
    vim.opt.signcolumn = "yes"

    -- Hide ./ and ../ in netrw
    vim.g.netrw_list_hide = '^\\.*/$'
    vim.g.netrw_hide = 1

    -- Terminal settings
    vim.cmd([[

    augroup neovim_terminal
        autocmd!

        " Enter Terminal-mode (insert) automatically
        autocmd TermOpen * startinsert

        " Disables number lines on terminal buffers
        autocmd TermOpen * :set nonumber norelativenumber
    augroup END

    ]])

    -- Have only one status bar instead of one per window
    vim.opt.laststatus = 3

    -- Set formatting options. See :h fo-table
    vim.o.formatoptions = "jcrql"
end

local setup_commands = function ()
    command.create("W", "w")

    command.create("Config", "lcd " .. path.nvim_config_dir() .. "|NvimTreeFocus")
    command.create("ConfigCwd", "cd " .. path.nvim_config_dir() .. "|NvimTreeFocus")

    command.create("LuaBuffer", function ()
        local buffer_contents = table.concat(vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false), "\n")
        loadstring(buffer_contents)()
    end)
end

local setup_keymaps = function ()
    -- Jump to start of line
    keymap.set({ 'n', 'v' }).apply('B', '^')

    -- Jump to end of line
    keymap.set({ 'n', 'v' }).apply('E', '$')

    -- Dont include new line when deleting until end of line
    keymap.set({ 'n', 'v' }).apply('D', 'v$hd')

    -- Dont include new line when replacing until end of line
    keymap.set({ 'n', 'v' }).apply('C', 'v$hc')

    -- Make Y behave like D and C, yanking till end of line (minus the line break)
    keymap.set({ 'n', 'v' }).apply('Y', 'y$')

    -- Dont copy characters removed with 'x' to clipboard
    keymap.set({ 'n', 'v' }).apply('x', '"_x')

    -- Don't overwrite register when pasting over selection
    keymap.visual.apply('p', 'pgvy')

    -- Move virtual lines
    keymap.set({ 'n', 'v' }).apply('j', 'gj')
    keymap.set({ 'n', 'v' }).apply('k', 'gk')

    -- Keep selection after indent
    keymap.visual.apply('<', '<gv')
    keymap.visual.apply('>', '>gv')

    -- Indent and outdent with <Tab> and <S-Tab>
    keymap.set({ 'v' }).apply('<Tab>', '>gv')
    keymap.set({ 'v' }).apply('<S-Tab>', '<gv')
    keymap.insert.apply('<S-Tab>', '<C-o><<')

    -- Create new tab
    keymap.normal.apply('<Leader>tn', ':tabnew<CR>')

    -- Use number keys to jump to tab
    keymap.normal.apply('1', '1gt')
    keymap.normal.apply('2', '2gt')
    keymap.normal.apply('3', '3gt')
    keymap.normal.apply('4', '4gt')
    keymap.normal.apply('5', '5gt')
    keymap.normal.apply('6', '6gt')
    keymap.normal.apply('7', '7gt')
    keymap.normal.apply('8', '8gt')
    keymap.normal.apply('9', '9gt')
    keymap.normal.apply('0', ':tablast<CR>')

    -- Move tabs
    keymap.normal.apply('+', ':+tabmove<CR>')
    keymap.normal.apply('_', ':-tabmove<CR>')

    -- Clear search highlighting with <CR>
    -- Search stays in register so <n> and <C-n> will re-highlight results
    keymap.normal.apply('<CR>', ':nohlsearch<CR>')

    -- Delete current buffer
    keymap.normal.apply('<Leader>bd', ':bd')

    -- Delete previous word
    keymap.insert.apply('<C-BS>', '<C-W>')

    -- Open terminal in current window
    keymap.normal.apply('<C-w><Enter>', ':terminal<CR>')
    keymap.normal.apply('<C-w><C-Enter>', ':terminal<CR>')

    -- Exit terminal insert mode with <Esc> or <C-n>
    keymap.terminal.apply('<Esc>', '<C-\\><C-n>')
    keymap.terminal.apply('<C-n>', '<C-\\><C-n>')

    -- Resize buffers with arrow keys
    keymap.normal.apply('<Up>', ':resize +1<CR>')
    keymap.normal.apply('<Down>', ':resize -1<CR>')
    keymap.normal.apply('<Left>', ':vert resize -1<CR>')
    keymap.normal.apply('<Right>', ':vert resize +1<CR>')

    keymap.normal.apply('<S-Up>', ':resize +5<CR>')
    keymap.normal.apply('<S-Down>', ':resize -5<CR>')
    keymap.normal.apply('<S-Left>', ':vert resize -5<CR>')
    keymap.normal.apply('<S-Right>', ':vert resize +5<CR>')

    -- Scroll without moving cursor
    keymap.set({ 'n', 'v' }).apply('<C-S-k>', '<C-y>')
    keymap.set({ 'n', 'v' }).apply('<C-S-j>', '<C-u>')

    -- Make <C-v> paste the contents of the clipboard
    -- (Makes the Windows clipboard with history work)
    keymap.set({ "i" }).apply("<C-v>", "<ESC>:set paste<CR>a<C-r>*<ESC>:set nopaste<CR>a")
end

local setup_filetypes = function ()
    vim.filetype.add({
        extension = {
            njk = "html",
            liquid = "html",
        },
    })
end

---@type ConfigModule
return {
    setup = function ()
        setup_settings()
        setup_commands()
        setup_keymaps()
        setup_filetypes()
    end
}
