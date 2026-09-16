active_opacity = 0.98
inactive_opacity = 0.9

hl.config({
    general = {
        layout = "dwindle",
        border_size = 1,

        gaps_in = 3,
        gaps_out = 5,

        col = {
            active_border = "rgba(255,255,255,1)",
            inactive_border = "rgba(255,255,255,0.25)"
        }
    },
    decoration = {
        rounding = 9,
        active_opacity = active_opacity,
        inactive_opacity = inactive_opacity,
        fullscreen_opacity = 1,
        blur = {
            noise = 0.15,
            contrast = 2,
            vibrancy = 0.3,
            vibrancy_darkness = 0.2
        }
    },
    dwindle = {
        preserve_split = true
    },
    scrolling = {
        column_width = 0.85
    }
})
