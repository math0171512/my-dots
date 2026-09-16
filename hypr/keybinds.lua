require("states")
require("sounds")
require("windows")

local terminal = "alacritty"
local fileManager = "dolphin"
local launcher = "tofi-drun"
local browser = "helium-browser"
local discord = "vesktop"
local codeEditor = "helix"
local screenshot = "hyprshot -m region --clipboard-only --freeze"
local colorpicker = "hyprpicker --autocopy --format=hex --notify"
local bluelight = "hyprsunset"
local clipboardviewer = "copyq menu"

local mainMod = "SUPER"
local altMod = "ALT"

local languages = {
    "us",
    "de",
    "ua"
}
local languagesNamesHuman = {
    "English",
    "German",
    "Ukrainian"
}

local lastmethodoption = ""

local atlang = 1

hl.bind(mainMod.."+space",hl.dsp.global("quickshell:programLauncher"))

hl.bind(mainMod.."+V",hl.dsp.exec_cmd(clipboardviewer))
hl.bind(mainMod.."+return", hl.dsp.exec_cmd(terminal)) -- open terminal
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager)) -- open file manager
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(launcher)) -- open program launcher
hl.bind(mainMod.."+G",hl.dsp.exec_cmd(browser)) --open browser
hl.bind(mainMod.."+D",hl.dsp.exec_cmd(discord)) --open discord
hl.bind(mainMod.."+H",hl.dsp.exec_cmd(terminal.." --command "..codeEditor)) --open code editor
hl.bind("print",function()
    hl.animation({ leaf = "fade", enabled = true,  speed = 0.01, bezier = "instant" })
    hl.config({
        decoration = {
            active_opacity = 1,
            inactive_opacity = 1
        }
    })
    hl.timer(function()
        hl.dispatch(hl.dsp.exec_cmd(screenshot))
        hl.config({
            decoration = {
                active_opacity = active_opacity,
                inactive_opacity = inactive_opacity
            }
        })
        hl.animation({ leaf = "fade", enabled = true,  speed = 3.03, bezier = "quick" })
    end,{
        timeout = 10,
        type = "oneshot"
    })
end) --start screenshotting

hl.bind(mainMod.."+P",hl.dsp.exec_cmd(colorpicker)) --start screenshotting
hl.bind(mainMod.."+N",function()
    ToggleSoundsEnabled()
    if EnableSounds then
        PlaySound("sounds_on")
    else
        PlaySound("sounds_off")
    end
end)

hl.bind(mainMod.."+W",hl.dsp.window.close()) --close window
hl.bind(mainMod.."+"..altMod.."+W",hl.dsp.window.signal({signal = 9})) --forcefully close window
hl.bind(mainMod.."+SHIFT+W",function()
    local all_windows = hl.get_windows()
    local windowstoclose = {}
    for _,window in pairs(all_windows) do
        if window.workspace.id == hl.get_active_workspace().id then
            table.insert(windowstoclose,window)
        end
    end
    local i = 0
    local function closeNext()
        i=i+1
        if #windowstoclose < i then
            return
        else
            hl.dispatch(hl.dsp.window.close({
                window = windowstoclose[i]
            }))
            hl.timer(closeNext,{
                timeout=50,
                type="oneshot"
            })
        end
    end
    closeNext()
end)

hl.bind(mainMod.."+B",function()
    hl.exec_cmd("hyprctl hyprsunset temperature -500")
end)
hl.bind(mainMod.."+SHIFT+B",function()
    hl.exec_cmd("hyprctl hyprsunset temperature +500")
end)
hl.bind(mainMod.."+CTRL+B",function()
    hl.exec_cmd("hyprctl hyprsunset temperature 6500")
end)

hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" })) --float window

hl.bind(mainMod.."+SHIFT+c",function()
    local methods = {"grow","wave"}
    for i,method in pairs(methods) do
        if method == lastmethodoption then
            table.remove(methods,i)
            break
        end
    end
    local method = methods[math.random(1,#methods)]
    lastmethodoption = method

    local params = "--transition-type "..method.." --transition-duration 2 --transition-fps 200 --transition-bezier .57,1.08,.55,.08 --transition-pos "..math.random(0,100)/100 ..","..math.random(0,100)/100 .." --transition-angle "..math.random(0,360)

    hl.exec_cmd('~/.config/hypr/change_wallpaper.sh "'..params..'"')
    --hl.exec_cmd("awww img "..wallpaperDir.."'"..wallpaperNames[atwallpaper].."' --transition-type "..method.." --transition-fps 200 --transition-duration 1.5 --transition-step 255 --transition-bezier .17,1.37,.31,.91 --transition-pos "..math.random(0,100)/100 ..","..math.random(0,100)/100)
end)

local function changeLayout()
    atlang = atlang + 1
    if atlang > #languages then
        atlang = 1
    end
    local lang = languagesNamesHuman[atlang]
    hl.device({
        name = "corsair-corsair-k55-rgb-pro-gaming-keyboard",
        kb_layout = languages[atlang]
    })
    hl.exec_cmd("notify-send "..lang.." 'Switched to "..lang.."'")
end
hl.bind(mainMod.."+K",changeLayout)

hl.bind(mainMod.."+F",hl.dsp.window.fullscreen())

hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

-- Move focus with mainMod + arrow keys
local directions = {"left","right","up","down"}
for _,direction in pairs(directions) do
    hl.bind(mainMod.."+"..direction,hl.dsp.focus({direction=direction}))
    hl.bind(mainMod.."+ SHIFT +"..direction,hl.dsp.window.swap({direction=direction}))
end

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

local specials = 2
local atspecial = 1

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("XF86AudioLowerVolume",hl.dsp.exec_cmd("amixer -D pulse sset Master 5%-; play ~/.config/hypr/sounds/switch.ogg"))
hl.bind("XF86AudioRaiseVolume",hl.dsp.exec_cmd("amixer -D pulse sset Master 5%+; play ~/.config/hypr/sounds/switch.ogg"))
hl.bind("XF86AudioMute",hl.dsp.exec_cmd("amixer -D pulse sset Master toggle"))
