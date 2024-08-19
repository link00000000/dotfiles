vim.opt.compatible = false
vim.opt.termguicolors = true
vim.opt.updatetime = 100

vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- Map <Space> to leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Have only one status bar instead of one per window
vim.opt.laststatus = 3

-- Set formatting options. See :h fo-table
vim.o.formatoptions = "jcrql"

-- Disable error bell
vim.opt.visualbell = true
vim.opt.errorbells = false

-- Highlight the current line
vim.opt.cursorline = true

-- Enabled mouse supoort
vim.opt.mouse = "a"

-- Use system clipboard
vim.opt.clipboard:prepend({ "unnamed", "unnamedplus" })

-- Disabled word wrap
vim.opt.wrap = false

-- Focus new pane when splitting
vim.o.splitbelow = true
vim.o.splitright = true

-- Ignore case when searching if search contains only lower case
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Show a few lines of context acround the cursor
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 10

-- Always delete previous word when deleting entire words
vim.opt.backspace = { "indent", "eol", "start" }

-- Show all folds expanded when a file is opened
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- Force gutter to always be visible
vim.opt.signcolumn = "yes"

-- Hide ./ and ../ in netrw
vim.g.netrw_list_hide = "^\\.*/$"
vim.g.netrw_hide = 1

-- Additional filetype associations
vim.filetype.add({
  extension = {
    njk = "html",
    liquid = "html",
  },
})

vim.cmd([[
  augroup neovim_terminal
    autocmd!

    " Enter Terminal-mode (insert) automatically
    autocmd TermOpen * startinsert

    " Disables number lines on terminal buffers
    autocmd TermOpen * :set nonumber norelativenumber
  augroup END
]])

-- Typo aliases
vim.api.nvim_create_user_command("W", function () vim.cmd([[w]]) end, {})
vim.api.nvim_create_user_command("Wa", function () vim.cmd([[wa]]) end, {})
vim.api.nvim_create_user_command("WA", function () vim.cmd([[wa]]) end, {})
vim.api.nvim_create_user_command("Waq", function () vim.cmd([[waq]]) end, {})
vim.api.nvim_create_user_command("WAq", function () vim.cmd([[waq]]) end, {})
vim.api.nvim_create_user_command("WaQ", function () vim.cmd([[waq]]) end, {})
vim.api.nvim_create_user_command("WAQ", function () vim.cmd([[waq]]) end, {})

vim.api.nvim_create_user_command("Config", function ()
  vim.cmd.tabnew()
  vim.cmd.tchdir(vim.fn.stdpath("config"))
  vim.cmd.edit("init.lua")
end, { desc = "Opens neovim settings in a new tab" })

vim.api.nvim_create_user_command("ExecuteBuffer", function (args)
  ---@type string[]
  local lines

  if args.range == 2 then
    lines = vim.api.nvim_buf_get_lines(0, args.line1 - 1, args.line2, false)
  else
    lines = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
  end

  loadstring(table.concat(lines, "\n"))()
end, { range = true })

-- Delete previous word
vim.keymap.set({ "i" }, "<C-BS>", "<C-W>")

-- Jump to start of line
vim.keymap.set({ "n", "v" }, "B", "^")

-- Jump to end of line
vim.keymap.set({ "n", "v" }, "E", "$")

-- Dont include new line when deleting until end of line
vim.keymap.set({ "n", "v" }, "D", "v$hd")

-- Dont include new line when replacing until end of line
vim.keymap.set({ "n", "v" }, "C", "v$hc")

-- Make Y behave like D and C, yanking till end of line (minus the line break)
vim.keymap.set({ "n", "v" }, "Y", "y$")

-- Dont copy characters removed with "x" to clipboard
vim.keymap.set({ "n", "v" }, "x", '"_x')

-- Don't overwrite register when pasting over selection
vim.keymap.set({ "v" }, "p", "pgvy")

-- Keep selection after indent
vim.keymap.set({ "v" }, "<", "<gv")
vim.keymap.set({ "v" }, ">", ">gv")

-- Indent and outdent with one button press
vim.keymap.set({ "n" }, ">", ">>")
vim.keymap.set({ "n" }, "<", "<<")

-- Create new tab
vim.keymap.set({ "n" }, "<Leader>tn", ":tabnew<CR>")

-- Use number keys to jump to tab
vim.keymap.set({ "n" }, "<Leader>1", "1gt")
vim.keymap.set({ "n" }, "<Leader>2", "2gt")
vim.keymap.set({ "n" }, "<Leader>3", "3gt")
vim.keymap.set({ "n" }, "<Leader>4", "4gt")
vim.keymap.set({ "n" }, "<Leader>5", "5gt")
vim.keymap.set({ "n" }, "<Leader>6", "6gt")
vim.keymap.set({ "n" }, "<Leader>7", "7gt")
vim.keymap.set({ "n" }, "<Leader>8", "8gt")
vim.keymap.set({ "n" }, "<Leader>9", "9gt")

-- Use number keys to jump to tab
vim.keymap.set({ "n" }, "+", ":+tabmove<CR>")
vim.keymap.set({ "n" }, "_", ":-tabmove<CR>")

-- Clear search highlighting with <CR>
-- Search stays in register so <n> and <C-n> will re-highlight results
vim.keymap.set({ "n" }, "<CR>", ":nohlsearch<CR>", { silent = true })

-- Delete current buffer
vim.keymap.set({ "n" }, "<Leader>bd", ":bd<CR>")
vim.keymap.set({ "n" }, "<Leader>bn", ":enew<CR>")

-- Exit terminal insert mode with <Esc> or <C-n>
vim.keymap.set({ "t" }, "<Esc>", "<C-\\><C-n>")
vim.keymap.set({ "t" }, "<C-n>", "<C-\\><C-n>")

-- Resize buffers with arrow keys
vim.keymap.set({ "n" }, "<Up>", ":resize +1<CR>")
vim.keymap.set({ "n" }, "<Down>", ":resize -1<CR>")
vim.keymap.set({ "n" }, "<Left>", ":vert resize -1<CR>")
vim.keymap.set({ "n" }, "<Right>", ":vert resize +1<CR>")

vim.keymap.set({ "n" }, "<S-Up>", ":resize +5<CR>")
vim.keymap.set({ "n" }, "<S-Down>", ":resize -5<CR>")
vim.keymap.set({ "n" }, "<S-Left>", ":vert resize -5<CR>")
vim.keymap.set({ "n" }, "<S-Right>", ":vert resize +5<CR>")
