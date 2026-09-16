local environment_variables = {
  XCURSOR_SIZE = "24",
  HYPRCURSOR_SIZE = "24",
  QT_QPA_PLATFORMTHEME = "kde"
}

for name,value in pairs(environment_variables) do
  hl.env(name,value)
end
