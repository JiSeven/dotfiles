local wezterm = require('wezterm')
local act = wezterm.action
local config = wezterm.config_builder()

-- =============================================================================
-- 1. WINDOW SIZE & POSITION (No jumping on startup)
-- =============================================================================
-- Adjust these numbers based on 'stty size' command in your terminal
config.initial_cols = 200
config.initial_rows = 60
config.adjust_window_size_when_changing_font_size = false

config.window_padding = {
  left = 20,
  right = 20,
  top = 20,
  bottom = 20,
}

-- =============================================================================
-- 2. APPEARANCE (macOS native look)
-- =============================================================================
config.color_scheme = 'Dracula'
config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Medium' })
config.font_size = 15.0

config.colors = {
  selection_fg = 'none',
  selection_bg = '#44475a', -- Dracula selection
}

config.window_background_opacity = 0.90
config.macos_window_background_blur = 20
config.window_decorations = 'RESIZE'
config.front_end = 'WebGpu' -- Best performance for Metal-based Macs

-- Prevents Option key from typing special characters (like ∫, ∂)
config.send_composed_key_when_left_alt_is_pressed = false

-- =============================================================================
-- 3. UI SETTINGS
-- =============================================================================
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- =============================================================================
-- 4. KEYBINDINGS (The stable CMD-way)
-- =============================================================================
config.keys = {
  -- SPLITS (CMD + d)
  { key = 'd',   mods = 'CMD',       action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
  { key = 'd',   mods = 'CMD|SHIFT', action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },
  { key = 'w',   mods = 'CMD',       action = act.CloseCurrentPane({ confirm = true }) },

  -- PANE NAVIGATION (CMD + hjkl)
  { key = 'h',   mods = 'CMD',       action = act.ActivatePaneDirection('Left') },
  { key = 'j',   mods = 'CMD',       action = act.ActivatePaneDirection('Down') },
  { key = 'k',   mods = 'CMD',       action = act.ActivatePaneDirection('Up') },
  { key = 'l',   mods = 'CMD',       action = act.ActivatePaneDirection('Right') },

  -- WORKSPACES (Updated to Table flags)
  { key = 's',   mods = 'CMD',       action = act.ShowLauncherArgs({ flags = 'WORKSPACES' }) },
  { key = 'Tab', mods = 'CMD',       action = act.SwitchToWorkspace({ relative_to_current_view = true }) },
  {
    key = 'n',
    mods = 'CMD',
    action = act.PromptInputLine({
      description = "New workspace name:",
      action = wezterm.action_callback(function(window, pane, line)
        if line then window:perform_action(act.SwitchToWorkspace({ name = line }), pane) end
      end),
    })
  },

  -- RESIZING (CMD + CTRL + Arrows)
  { key = 'LeftArrow',  mods = 'CMD|CTRL',  action = act.AdjustPaneSize({ 'Left', 5 }) },
  { key = 'RightArrow', mods = 'CMD|CTRL',  action = act.AdjustPaneSize({ 'Right', 5 }) },
  { key = 'UpArrow',    mods = 'CMD|CTRL',  action = act.AdjustPaneSize({ 'Up', 5 }) },
  { key = 'DownArrow',  mods = 'CMD|CTRL',  action = act.AdjustPaneSize({ 'Down', 5 }) },

  -- UTILITIES
  { key = 'e',          mods = 'CMD',       action = act.QuickSelect },                             -- CMD+e: Copy without mouse
  { key = 'p',          mods = 'CMD|SHIFT', action = act.ActivateCommandPalette },                  -- Command search
  { key = 'f',          mods = 'CMD',       action = act.Search("CurrentSelectionOrEmptyString") }, -- Find
}

-- =============================================================================
-- 5. STATUS BAR
-- =============================================================================
wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(wezterm.format({
    { Foreground = { Color = '#BD93F9' } },
    { Text = '  ' .. window:active_workspace() .. '  ' },
  }))
end)

return config
