# TODO

- Find this theme: https://www.reddit.com/r/neovim/comments/wf6sh1/issues_with_c_files_with_cmp_and_omnisharp/
- Place diagnostic icons and line numbers in the same location (No separate location for diagnostic icons)
    - https://www.reddit.com/r/neovim/comments/vnph10/background_color_with_diagnostic_icons/
- Customize repositories telescope to open project folder after selecting a file
- Bind open and close panels to window move when there is no window to move to?
- Automatically hide panel when panel is no longer focused
- Find replacements for and remove nvim-ide?
    - Maybe keep it for debugging?
- Use wider telescope previewer when searching
- Indent code block on paste to correct indentation
- If line is blank, dont include whitespace that was added by auto-indent
- Get better terminal colors based off of vim theme
    - Specifically lazygit colors
- Prevent word in front from getting deleted when accepting suggestion from cmp
- Replace lualine (and barbecue?) with galaxyline
- Replace vimplug with pakcer or lazy.nvim. Use nvim_rocks for luarocks if using lazy.nvim
- Use web-devicons in outline
- Add neoclip for clipboard history (maybe have custom integration with windows clipboard with WinApi)

## Keybinds

- Fix shift tab in insert mode ✅
- Add keybind to toggle panels
- Comment current line or selection with <C-/> ✅
- Contol backspace to delete entire word ✅
- Better <Leader>k hints with syntax highlighting and doc comments
- Make unused methods dim like VS

## LSP

- Remove lsp-zero and unused dependencies
    - Remove config 
- Setup cmp for suggestions ✅
- Show diagnostics on hover ✅
- Better diagnostics icons (see lsp-zero)

### Keybinds (See https://github.com/VonHeikemen/lsp-zero.nvim#default-keybindings for reference)

- Rename ✅
- <C-Space> to open suggestions ✅
- <Tab> to go to next suggestion ✅
- <C-n> to go to next suggestion ✅
- <S-Tab> to go to previous suggestion ✅
- <C-p> to go to previous suggestion ✅
- <Leader>a to open code actions ✅
- <Leader>rt to refactor
- <Leader>k to show documentation ✅
    - Map documentation scrolling ✅

## Snippets

- Setup snippets
    - https://github.com/VonHeikemen/lsp-zero.nvim#snippets

- CSharp namespace snippet
- CSharp test class snippet
- CSharp test method snippet (& async test class method snippet)

## New plugins

- Glance
- BufferTag
- Something for git gutter
- Something for git blame
- Hop or Leap or Pounce
- LspKind? ✅
- DAPs
- nvim-notify
- shade.nvim
- limelight like plugin
- Git integration
- Database integration
- Bracket pair insertion
- Bracket pair colors
- Copilot
- nvim-navic
- GitLens
- LazyGit integration
- Multiple cursor support
- Tab renaming
- Add index numbers to tabs
- Custom file browser
- Something to highlight TODO, NOTE, DELETEME, etc
