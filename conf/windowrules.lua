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
hl.window_rule({ workspace = 4, match = { class = "steam" } })

hl.window_rule({
  name = "floater",
  match = { class = "float-center" },
  float = true,
  size = { 727, 430 },
  center = true,
})
