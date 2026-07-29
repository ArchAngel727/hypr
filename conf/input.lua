hl.config({
  input = {
    kb_layout = "us,de",
    kb_variant = "",
    kb_model = "",
    kb_options = "grp:win_space_toggle,fkeys:basic_13-24,ctrl:nocaps",
    kb_rules = "",

    follow_mouse = 1,
    accel_profile = "flat",
    sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

    touchpad = {
      natural_scroll = true,
      scroll_factor = 0.1,
    },

    numlock_by_default = true,
  },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

hl.gesture({ fingers = 2, direction = "pinch", action = "cursorZoom", zoom_level = 1, mode = "live" })

hl.gesture({
  fingers = 3,
  direction = "up",
  action = function()
    local layouts = { "scrolling", "dwindle" }
    local workspace = hl.get_active_workspace()
    if hl.get_active_special_workspace() then
      workspace = hl.get_active_special_workspace()
    end

    local next_layout = "dwindle"

    if not workspace then
      return
    end

    for i = 1, #layouts do
      if layouts[i] == workspace.tiled_layout then
        local next_layout_idx = (i % #layouts) + 1
        next_layout = layouts[next_layout_idx]
        break
      end
    end

    if workspace.special then
      hl.workspace_rule({ workspace = tostring(workspace.name), layout = next_layout })
    else
      hl.workspace_rule({ workspace = tostring(workspace.id), layout = next_layout })
    end
  end,
})
