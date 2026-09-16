EnableSounds = true

function ToggleSoundsEnabled()
  EnableSounds = not EnableSounds
  local word = "Enabled"
  if not EnableSounds then
      word = "Disabled"
  end
  hl.exec_cmd("notify-send '"..word.." sounds'")
end
