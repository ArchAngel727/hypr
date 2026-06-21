-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
  output = "DP-1",
  mode = "1920x1080@240",
  position = "0x0",
  scale = "1",
  icc = os.getenv("HOME") .. "/.config/hypr/icc/profile.icm",
})

hl.monitor({
  output = "HEADLESS-2",
  mode = "1920x1200@120",
  position = "1920x0",
  scale = "1",
})
