hl.config({
  input = {
    kb_layout = "us,de",
    kb_variant = "",
    kb_model = "",
    kb_options = "grp:win_space_toggle,fkeys:basic_13-24",
    kb_rules = "",

    follow_mouse = 1,
    accel_profile = "flat",
    sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

    touchpad = {
      natural_scroll = false,
    },

    numlock_by_default = true,
  },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

hl.config({
  cursor = {
    no_hardware_cursors = true,
  },
})
