-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("PATH", os.getenv("PATH") .. ":" .. os.getenv("HOME") .. "/.cargo/bin")

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- for Qt apps
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- Cursor
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Remilia-Scarlet")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Remilia-Scarlet")

-- Nvidia
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("__GL_VRR_ALLOWED", "1")
hl.env("NVD_BACKEND", "direct")

hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")

-- Cachyos
hl.env("PROTON_DLSS_UPGRADE", "1")
hl.env("PROTON_DLSS_INDICATOR", "1")
hl.env("PROTON_NVIDIA_LIBS", "1")
hl.env("PROTON_NO_WM_DECORATION", "1")
hl.env("PROTON_LOCAL_SHADER_CACHE", "0")
hl.env("PROTON_ENABLE_MEDIACONV", "1")
