return {
  "echasnovski/mini.pick",
  version = "*",
  dependencies = {
    "echasnovski/mini.icons",
  },
  config = function ()
    require("mini.pick").setup { 
      -- Delays (in ms; should be at least 1)
      delay = {
        -- Delay between forcing asynchronous behavior
        async = 10,

        -- Delay between computation start and visual feedback about it
        busy = 50,
      },

      -- Keys for performing actions. See `:h MiniPick-actions`.
      mappings = {
        caret_left  = "<Nop>",
        caret_right = "<Nop>",

        choose            = "<CR>",
        choose_in_split   = "<C-s>",
        choose_in_tabpage = "<C-t>",
        choose_in_vsplit  = "<C-v>",
        choose_marked     = "<Nop>",

        delete_char       = "<BS>",
        delete_char_right = "<Del>",
        delete_left       = "<C-u>",
        delete_word       = "<C-h>",

        mark     = "<Nop>",
        mark_all = "<Nop>",

        move_down  = "<C-j>",
        move_up    = "<C-k>",
        move_start = "<Nop>",

        paste = "<C-r>",

        refine        = "<C-Space>",
        refine_marked = "<M-Space>",

        scroll_down  = "<C-d>",
        scroll_left  = "<C-h>",
        scroll_right = "<C-l>",
        scroll_up    = "<C-u>",

        stop = "<Esc>",

        toggle_info    = "<S-Tab>",
        toggle_preview = "<Tab>",
      },

      -- General options
      options = {
        -- Whether to show content from bottom to top
        content_from_bottom = true,

        -- Whether to cache matches (more speed and memory on repeated prompts)
        use_cache = true,
      },

      -- Window related options
      window = {
        -- Float window config (table or callable returning it)
        config = nil,

        -- String to use as cursor in prompt
        prompt_cursor = "▏",

        -- String to use as prefix in prompt
        prompt_prefix = "> ",
      },
    }
  end,
}
