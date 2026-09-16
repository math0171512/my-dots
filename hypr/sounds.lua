require("states")

local sounds = {
  switch = "switch.ogg",
  relocate = "relocate.ogg",
  open = "open.ogg",
  close = "close.ogg",
  sounds_on = "sound_on.ogg",
  sounds_off = "sound_off.ogg",
  special_switch = "special_switch.ogg",
  focus = "focus.ogg"
}

local workspaceSwitchTime = -1000
local currentWorkspace = 1

function PlaySound(soundname)
  if (soundname ~= "sounds_off" and not EnableSounds) then
        return
  end
  assert(soundname,"Pick a sound please")
  hl.dispatch(hl.dsp.exec_cmd("play ~/.config/hypr/sounds/"..sounds[soundname]))
end

hl.on("workspace.active",function(ws)
  workspaceSwitchTime = os.clock()
  local difference = math.abs(tonumber(ws.name)-currentWorkspace)
  currentWorkspace = tonumber(ws.name)

  local total = difference
  local timesLeft = difference
  
  local function waitAndPlaySound()
    PlaySound("switch")
    timesLeft = timesLeft - 1
    if timesLeft > 0 then
      hl.timer(waitAndPlaySound,{
        timeout = 100/total, type = "oneshot"
      })
    end
  end
  waitAndPlaySound()
end)

hl.on("window.move_to_workspace",function()
  PlaySound("relocate")
end)

hl.on("window.open_early",function()
  PlaySound("open")
end)

hl.on("window.close",function()
  PlaySound("close")
end)

hl.on("workspace.special_active",function()
  PlaySound("special_switch")
end)

hl.on("window.fullscreen",function()
  PlaySound("special_switch")
end)
