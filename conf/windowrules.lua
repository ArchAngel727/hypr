-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.window_rule({ name = "suppress-maximize-events", match = { class = ".*" }, suppress_event = "maximize" })

hl.window_rule({
  name = "fix-xwayland-drags",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },

  no_focus = true,
})

hl.window_rule({ workspace = 1, match = { class = "vesktop" } })
hl.window_rule({ workspace = 3, match = { class = "org.mozilla.Thunderbird" } })

hl.window_rule({
  name = "floater",
  match = { class = "float-center" },
  float = true,
  size = { 727, 430 },
  center = true,
})

hl.window_rule({
  name = "xwayland-video-bridge-fixes",
  match = { class = "xwaylandvideobridge" },

  no_initial_focus = true,
  no_focus = true,
  no_anim = true,
  no_blur = true,
  max_size = { 1, 1 },
  opacity = 0.0,
})

-- FLAMESHOT

hl.window_rule({
  match = { class = "flameshot" },
  no_anim = true,
  pin = true,
  float = true,
  decorate = false,
  no_blur = true,
  no_shadow = true,
})
hl.window_rule({
  match = { class = "flameshot", title = "flameshot" },
  move = { 0, 0 },
})
hl.window_rule({
  match = { class = "flameshot", title = "flameshot-pin" },
  move = { "cursor_x-(window_w*0.5)", "cursor_y-(window_h*0.5)" },
})
