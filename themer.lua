-- theme changer

local by_17 = {
  "solarized",
  "atelierheath",
  "ocean",
  "tomorrow",
  "mocha",
  "railscasts",
  "eighties",
  "atelierdune",
}

local function pick()
  local hour = os.date("*t")["hour"]

  local background
  if 06 < hour and  hour < 17 then
    background = "-light"
  else
    background = "-dark"
  end
  -- note: need to use
  return {background, hour % #by_17 + 1}
end


local function change()
  ui.set_theme(
--  'base16-'.. by_17[1] .. "-dark",
  'base16-'.. by_17[pick()[2]] .. pick()[1],
  {font = "Inconsolata",
  fontsize = 14}
  )
end


return {
  change = change,
  pick = pick
}
