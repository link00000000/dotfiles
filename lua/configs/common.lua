local keymap = require('utils.keymap')

local M = {}

M.keymaps = function ()
    -- Jump to start of line
    keymap.set({ 'n', 'v' }, 'B', '^')

    -- Jump to end of line
    keymap.set({ 'n', 'v' }, 'E', '$')

    -- Dont include new line when deleting until end of line
    keymap.set({ 'n', 'v' }, 'D', 'v$hd')

    -- Dont include new line when replacing until end of line
    keymap.set({ 'n', 'v' }, 'C', 'v$hc')

    -- Make Y behave like D and C, yanking till end of line (minus the line break)
    keymap.set({ 'n', 'v' }, 'Y', 'y$')

    -- Dont copy characters removed with 'x' to clipboard
    keymap.set({ 'n', 'v' }, 'x', '"_x')

    -- Don't overwrite register when pasting over selection
    keymap.visual('p', 'pgvy')

    -- Move virtual lines
    keymap.set({ 'n', 'v' }, 'j', 'gj')
    keymap.set({ 'n', 'v' }, 'k', 'gk')

    -- Keep selection after indent
    keymap.visual('<', '<gv')
    keymap.visual('>', '>gv')

    -- Indent and outdent with <Tab> and <S-Tab>
    keymap.set({ 'n', 'v' }, '<Tab>', '>gv')
    keymap.set({ 'n', 'v' }, '<S-Tab>', '<gv')
    keymap.insert('<S-Tab>', '<C-o><<')

    -- Use number keys to jump to tab
    keymap.normal('1', '1gt')
    keymap.normal('2', '2gt')
    keymap.normal('3', '3gt')
    keymap.normal('4', '4gt')
    keymap.normal('5', '5gt')
    keymap.normal('6', '6gt')
    keymap.normal('7', '7gt')
    keymap.normal('8', '8gt')
    keymap.normal('9', '9gt')
    keymap.normal('0', ':tablast<CR>')

    -- Move tabs
    keymap.normal('+', ':+tabmove<CR>')
    keymap.normal('_', ':-tabmove<CR>')

    -- Clear search highlighting with <CR>
    -- Search stays in register so <n> and <C-n> will re-highlight results
    keymap.normal('<CR>', ':nohlsearch<CR>')

    -- Delete current buffer
    keymap.normal('<Leader>bd', ':bd')

    -- Delete previous word
    keymap.insert('<C-BS>', '<C-W>')

    -- Open terminal in current window
    keymap.normal('<C-w><Enter>', ':terminal<CR>')
    keymap.normal('<C-w><C-Enter>', ':terminal<CR>')

    -- Exit terminal insert mode with <Esc> or <C-n>
    keymap.terminal('<Esc>', '<C-\\><C-n>')
    keymap.terminal('<C-n>', '<C-\\><C-n>')

    -- Resize buffers with arrow keys
    keymap.normal('<Up>', ':resize +1<CR>')
    keymap.normal('<Down>', ':resize -1<CR>')
    keymap.normal('<Left>', ':vert resize -1<CR>')
    keymap.normal('<Right>', ':vert resize +1<CR>')

    keymap.normal('<S-Up>', ':resize +5<CR>')
    keymap.normal('<S-Down>', ':resize -5<CR>')
    keymap.normal('<S-Left>', ':vert resize -5<CR>')
    keymap.normal('<S-Right>', ':vert resize +5<CR>')

    -- Scroll without moving cursor
    keymap.set({ 'n', 'v' }, '<C-S-k>', '<C-y>')
    keymap.set({ 'n', 'v' }, '<C-S-j>', '<C-u>')
end

M.setup = function ()
    vim.opt.compatible = false
    vim.opt.termguicolors = true
    vim.opt.updatetime = 100

    -- Highlight the current line
    vim.opt.cursorline = true

    -- Map <Space> to leader
    keymap.normal('<Space>', '<NOP>')
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

    M.keymaps()
end

return M