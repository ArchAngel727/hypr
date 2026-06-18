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

hl.plugin.hymission.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

hl.plugin.hymission.gesture({
  fingers = 3,
  direction = "up",
  action = "open",
})

hl.plugin.hymission.gesture({
  fingers = 3,
  direction = "down",
  action = "close",
})

hl.plugin.hymission.gesture({
  fingers = 4,
  direction = "up",
  action = "open",
  scope = "onlycurrentworkspace",
})
