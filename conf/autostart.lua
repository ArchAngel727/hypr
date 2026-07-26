hl.on("hyprland.start", function()
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("systemctl --user start opentabletdriver.service")
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

  hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')
  hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3"')

  hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface 'Remilia-Scarlet'")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 24")

  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("wayle panel start")
  hl.exec_cmd("udiskie")
  hl.exec_cmd("hyprsunset")

  hl.exec_cmd("cliphist wipe")
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")

  hl.exec_cmd("thunderbird")
  hl.exec_cmd("steam")
  hl.exec_cmd("vesktop --enable-features=UseOzonePlatform --ozone-platform=wayland")
  hl.exec_cmd(os.getenv("HOME") .. "/.cargo/bin/wppr scrape")
end)
