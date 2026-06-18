-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("PATH", os.getenv("PATH") .. ":" .. os.getenv("HOME") .. "/.cargo/bin")

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- for Qt apps
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- Cursor
hl.env("XCURSOR_SIZE", "96")
hl.env("XCURSOR_THEME", "Remilia-Scarlet")
hl.env("HYPRCURSOR_SIZE", "96")
hl.env("HYPRCURSOR_THEME", "Remilia-Scarlet")

hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
