local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.default_prog = { "nu.exe" }
config.font = wezterm.font("Iosevka Custom")
config.window_decorations = "RESIZE"
config.color_scheme = "Tokyo Night"
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 5000 }
config.keys = {
  {
    key ="j",
    mods ="LEADER",
    action = wezterm.action.ActivatePaneDirection "Down",
  },
  {
    key ="k",
    mods ="LEADER",
    action = wezterm.action.ActivatePaneDirection "Up",
  },
  {
    key ="h",
    mods ="LEADER",
    action = wezterm.action.ActivatePaneDirection "Left",
  },
  {
    key ="l",
    mods ="LEADER",
    action = wezterm.action.ActivatePaneDirection "Right",
  },
  {
    key = "p",
    mods = "LEADER",
    action = wezterm.action.ActivateKeyTable { name = "pane", one_shot = true },
  },
  {
    key = "t",
    mods = "LEADER",
    action = wezterm.action.ActivateKeyTable { name = "tab", one_shot = true },
  },
  {
    key = "s",
    mods = "LEADER",
    action = wezterm.action.ActivateKeyTable { name = "search", one_shot = true },
  },
  {
    key = "1",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(0),
  },
  {
    key = "2",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(1),
  },
  {
    key = "3",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(2),
  },
  {
    key = "4",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(3),
  },
  {
    key = "5",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(4),
  },
  {
    key = "6",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(5),
  },
  {
    key = "7",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(6),
  },
  {
    key = "8",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(7),
  },
  {
    key = "9",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(8),
  },
}

config.key_tables = {
  pane = {
    {
      key = "Escape",
      action = wezterm.action.PopKeyTable,
    },
    {
      key = "r",
      action = wezterm.action.ActivateKeyTable { name = "pane_resize", one_shot = false },
    },
    {
      key = "v",
      action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
    {
      key = "s",
      action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
    },
    {
      key = "c",
      action = wezterm.action.CloseCurrentTab { confirm = true },
    },
  },
  pane_resize = {
    {
      key = "Escape",
      action = wezterm.action.PopKeyTable,
    },
    {
      key = "j",
      action = wezterm.action.AdjustPaneSize { "Down", 3 },
    },
    {
      key = "k",
      action = wezterm.action.AdjustPaneSize { "Up", 3 },
    },
    {
      key = "h",
      action = wezterm.action.AdjustPaneSize { "Left", 3 },
    },
    {
      key = "l",
      action = wezterm.action.AdjustPaneSize { "Right", 3 },
    },
  },
  tab = {
    {
      key = "Escape",
      action = wezterm.action.PopKeyTable,
    },
    {
      key = "n",
      action = wezterm.action.SpawnTab "DefaultDomain"
    },
    {
      key = "1",
      action = wezterm.action.ActivateTab(0),
    },
    {
      key = "2",
      action = wezterm.action.ActivateTab(1),
    },
    {
      key = "3",
      action = wezterm.action.ActivateTab(2),
    },
    {
      key = "4",
      action = wezterm.action.ActivateTab(3),
    },
    {
      key = "5",
      action = wezterm.action.ActivateTab(4),
    },
    {
      key = "6",
      action = wezterm.action.ActivateTab(5),
    },
    {
      key = "7",
      action = wezterm.action.ActivateTab(6),
    },
    {
      key = "8",
      action = wezterm.action.ActivateTab(7),
    },
    {
      key = "9",
      action = wezterm.action.ActivateTab(8),
    },
    {
      key = "{",
      action = wezterm.action.ActivateTabRelative(-1),
    },
    {
      key = "}",
      action = wezterm.action.ActivateTabRelative(1),
    },
    {
      key = "-",
      action = wezterm.action.MoveTabRelative(-1),
    },
    {
      key = "_",
      action = wezterm.action.MoveTabRelative(-1),
    },
    {
      key = "=",
      action = wezterm.action.MoveTabRelative(1),
    },
    {
      key = "+",
      action = wezterm.action.MoveTabRelative(1),
    },
    {
      key = "/",
      action = wezterm.action.ShowTabNavigator,
    },
  },
  search = {
    {
      key = "Escape",
      action = wezterm.action.PopKeyTable,
    },
    {
      key = "o",
      action = wezterm.action.EmitEvent "open-scrollback-in-editor"
    },
  }
}

wezterm.on("update-status", function(window)
  local BLACK = 1;
  local RED = 2;
  local GREEN = 3;
  local YELLOW = 4;
  local BLUE = 5;
  local MAGENTA = 6;
  local CYAN = 7;
  local WHITE = 8;
  
  local color_scheme = window:effective_config().resolved_palette

  local function get_leader_key_display_text ()
    if not window:leader_is_active() then
      return nil
    end

    return wezterm.format({
      { Background = { Color = color_scheme.brights[BLACK] } },
      { Foreground = { Color = color_scheme.foreground } },
      { Text = " ^a " }
    })
  end

  local function get_key_table_display_text ()
    local key_table = window:active_key_table() or "default"
  
    local key_table_colors = {
      pane = { foreground = color_scheme.background, background = color_scheme.ansi[BLUE] },
      pane_resize = "pane",
      tab = { foreground = color_scheme.background, background = color_scheme.ansi[MAGENTA] },
      search = { foreground = color_scheme.background, background = color_scheme.ansi[YELLOW] },
    }

    local function get_key_table_colors (kt)
      local value = key_table_colors[kt]

      if not value then
        return { foreground = color_scheme.background, background = color_scheme.ansi[WHITE] }
      end

      if type(value) == "string" then
        return get_key_table_colors(value)
      end
    
      if type(value) == "table" then
        return value
      end

      if value == nil then
        return { foreground = color_scheme.background, background = color_scheme.ansi[WHITE] }
      end

      error("key_table_colors malformed!")
    end

    local display_text = key_table:gsub("_", " "):upper() or "default"
    local display_colors = get_key_table_colors(key_table)
    return wezterm.format({
      { Attribute = { Intensity = "Bold" } },
      { Background = { Color = display_colors.background } },
      { Foreground = { Color = display_colors.foreground } },
      { Text = " " .. display_text .. " " },
    })
  end
  
  local display_text = ""
  for _, part in ipairs({ get_leader_key_display_text, get_key_table_display_text }) do
    local part_text = part()
    if part_text ~= nil then
      display_text = display_text .. part_text
    end
  end
  
  window:set_right_status(display_text)
end)

wezterm.on("open-scrollback-in-editor", function (window, pane)
  local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)

  local tmp_file_path = os.tmpname()
  local tmp_file = io.open(tmp_file_path, "w+")
  
  tmp_file:write(text)
  tmp_file:flush()
  tmp_file:close()

  local tab = window:mux_window():spawn_tab { args = { "hx", tmp_file_path } }
  tab:set_title("Scrollback")
  
  wezterm.sleep_ms(1000)
  os.remove(name)
end)

return config
