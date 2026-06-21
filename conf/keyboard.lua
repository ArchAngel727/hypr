-----------------
--- Variables ---
-----------------

local mainMod = "SUPER"
local terminal = "kitty -e tmux"

local mute_audio = hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
local mute_mic = hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")

local function layout_bind(bind_table)
  return function()
    local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()

    if not workspace then
      return
    end

    local layout = workspace.tiled_layout

    if bind_table[layout] then
      hl.dispatch(bind_table[layout])
    end
  end
end

----------------
--- Controls ---
----------------

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("~/.config/rofi/launchers/type-2/launcher.sh"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("kitty --class float-center -e " .. os.getenv("HOME") .. "/.cargo/bin/wppr"))
hl.bind(
  mainMod .. " + SHIFT + V",
  hl.dsp.exec_cmd(
    "cliphist list | rofi -dmenu -theme ~/.config/rofi/launchers/type-2/style-2.rasi | cliphist decode | wl-copy"
  )
)
hl.bind(
  mainMod .. " + CTRL + SHIFT + M",
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + G", hl.dsp.window.center())
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%"))
hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 50%"))
hl.bind(mainMod .. " + F3", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 70%"))
hl.bind(mainMod .. " + F4", hl.dsp.exec_cmd("nmcli conn up Framework-12"))
hl.bind(mainMod .. " + F5", hl.dsp.exec_cmd("nmcli conn down Framework-12"))
hl.bind(mainMod .. " + F7", hl.dsp.exec_cmd("brightnessctl set 1"))
hl.bind(mainMod .. " + F8", hl.dsp.exec_cmd("brightnessctl set 25%"))
hl.bind(mainMod .. " + F9", hl.dsp.exec_cmd("brightnessctl set 50%"))
hl.bind(mainMod .. " + F11", hl.dsp.window.fullscreen())

-- Move focus
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Move window
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
  hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.workspace.move({ workspace = i, monitor = "+1" }))
end

-- Layour specific
hl.bind(
  "SUPER + A",
  layout_bind({
    scrolling = hl.dsp.layout("swapcol l"), -- Scrolling: swap column with left one
    dwindle = hl.dsp.layout("swapsplit"), -- Dwindle: swap window split
    monocle = hl.dsp.layout("cycleprev"), -- Monocle and master: cycle prev window
    master = hl.dsp.layout("cycleprev"),
  })
)

hl.bind(
  "SUPER + D",
  layout_bind({
    scrolling = hl.dsp.layout("swapcol r"), -- Scrolling: swap column with right one
    dwindle = hl.dsp.layout("togglesplit"), -- Dwindle: toggle window split
    monocle = hl.dsp.layout("cyclenext"), -- Monocle and master: cycle next window
    master = hl.dsp.layout("cyclenext"),
  })
)

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + SHIFT + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + SHIFT + mouse:273", hl.dsp.window.resize(), { mouse = true })

---------------
--- Special ---
---------------

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })

hl.bind("XF86AudioMute", mute_audio)
hl.bind("XF86AudioMicMute", mute_mic)
hl.bind("F13", mute_audio)
hl.bind("F14", mute_mic)

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { repeating = true })

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"))

hl.bind(mainMod .. " + SHIFT + W", function()
  hl.dispatch(hl.dsp.workspace.move({
    workspace = hl.get_active_workspace().id,
    monitor = "+1",
  }))
end)

hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("hyprlock"))

---------------
--- Plugins ---
---------------

hl.bind(mainMod .. " + TAB", hl.plugin.hymission.toggle)
hl.bind(mainMod .. " + CTRL + TAB", function()
  hl.plugin.hymission.open("onlycurrentworkspace")
end)
