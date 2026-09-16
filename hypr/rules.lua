hl.window_rule({
  match = {
    class = "org.kde.dolphin"
  },
  size = {450,600}
})

hl.window_rule({
  match = {
    class = "blender|Godot"
  },
  opacity = "1.0 override 1.0 override 1.0 override"
})

hl.window_rule({
  match = {
    class =  "Godot"
  },
  opacity = "1.0 override 1.0 override 1.0 override"
})

hl.window_rule({
  match = {
    class = "org.kde.kcalc|com.github.hluk.copyq"
  },
  float = true,
  size = {450,600}
})

hl.window_rule({
  match = {
    class = "blender",
    title = "File Browser"
  },
  size = {900,600},
  float = true,
  center = true
})

hl.workspace_rule(
  {
  workspace = "special:magic",
  gaps_out = 65,
  gaps_in = 15,
  layout = "scrolling"
  }
)
