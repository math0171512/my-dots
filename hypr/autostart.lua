local commands = {
    "hypridle",
    "hyprshell run",
    "steam -silent",
    "vesktop --start-minimized",
    "dunst",
    "awww-daemon",
    "wayle shell",
    "hyprsunset --temperature 6500",
    "copyq"
}

hl.on("hyprland.start",function()
    for _,command in pairs(commands) do
        hl.exec_cmd(command)
    end
end)
