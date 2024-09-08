return {
  "echasnovski/mini.pick",
  lazy = false, -- So we can patch vim.ui.select()
  version = "*",
  dependencies = {
    require("plugins.web-devicons"),
  },
  keys = {
    {
      "<C-p>",
      function()
        require("mini.pick").builtin.files()
      end,
      desc = "Search files",
    },
    {
      "<C-b>",
      function()
        require("mini.pick").builtin.buffers()
      end,
      desc = "Search buffers",
    },
    {
      "<C-S-f>",
      function()
        require("mini.pick").builtin.grep_live(nil, { source = { name = "Find in all files" } })
      end,
    },
    {
      "<C-f>",
      function() --[[TODO: Search current file]]
      end,
      desc = "Find in current file",
    },
    {
      "<F12>",
      function()
        require("mini.pick").builtin.help()
      end,
      desc = "Search help pages",
    },
  },
  config = function()
    local mini_pick = require("mini.pick")

    mini_pick.setup {
      -- Delays (in ms; should be at least 1)
      delay = {
        -- Delay between forcing asynchronous behavior
        async = 10,

        -- Delay between computation start and visual feedback about it
        busy = 50,
      },

      -- Keys for performing actions. See `:h MiniPick-actions`.
      mappings = {
        caret_left = "<Nop>",
        caret_right = "<Nop>",

        choose = "<CR>",
        choose_in_split = "<C-s>",
        choose_in_tabpage = "<C-t>",
        choose_in_vsplit = "<C-v>",
        choose_marked = "<Nop>",

        delete_char = "<BS>",
        delete_char_right = "<Del>",
        delete_left = "<C-u>",
        delete_word = "<C-h>",

        mark = "<Nop>",
        mark_all = "<Nop>",

        move_down = "<C-j>",
        move_up = "<C-k>",
        move_start = "<Nop>",

        paste = "<C-r>",

        refine = "<C-Space>",
        refine_marked = "<M-Space>",

        scroll_down = "<C-d>",
        scroll_left = "<C-h>",
        scroll_right = "<C-l>",
        scroll_up = "<C-u>",

        stop = "<Esc>",

        toggle_info = "<S-Tab>",
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
        -- Center on screen
        config = function ()
          height = math.floor(0.618 * vim.o.lines)
          width = math.floor(0.618 * vim.o.columns)
          return {
            anchor = 'NW', height = height, width = width,
            row = math.floor(0.5 * (vim.o.lines - height)),
            col = math.floor(0.5 * (vim.o.columns - width)),
          }
        end,

        -- String to use as cursor in prompt
        prompt_cursor = "▏",

        -- String to use as prefix in prompt
        prompt_prefix = "> ",
      },
    }

    vim.ui.select = function (items, opts, on_choice)
      local format_item = opts.format_item or H.item_to_string
      local items_ext = {}
      for i = 1, #items do
        table.insert(items_ext, { text = format_item(items[i]), item = items[i], index = i })
      end

      local preview_item = vim.is_callable(opts.preview_item) and opts.preview_item or function(x) return vim.split(vim.inspect(x), "\n") end
      local preview = function(buf_id, item) H.set_buflines(buf_id, preview_item(item.item)) end

      local was_aborted = true
      local choose = function(item)
        was_aborted = false
        if item == nil then 
          return 
        end

        local win_target = mini_pick.get_picker_state().windows.target
        if not H.is_valid_win(win_target) then win_target = H.get_first_valid_normal_window() end
        vim.api.nvim_win_call(win_target, function()
          on_choice(items[item.index], item.index)
          mini_pick.set_picker_target_window(vim.api.nvim_get_current_win())
        end)
      end

      local source = { items = items_ext, name = opts.prompt or opts.kind, preview = preview, choose = choose }
      local item = mini_pick.start({
        source = source,
        window = {
          config = {
            relative = 'cursor',
            anchor = 'SW',
            row = 0,
            col = 0,
            width = 80,
            height = 10,
          },
        }
      })
      if item == nil and was_aborted then on_choice(nil) end
      if item == nil and was_aborted then on_choice(nil) end
    end
  end,
}
