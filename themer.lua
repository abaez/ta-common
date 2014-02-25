--- the Textadept theme changer.
-- See @{README.md} for details on usage.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- @copyright 2014
-- @license MIT (see LICENSE)
-- @module themer


--- themes to choose from.
-- A simple list to locate themes to apply. Follows the 8 hour work schedule
-- for the brightness of the theme.
-- @table by_17
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


--- picks the theme by hour.
-- @function pick
-- @return a table that holds theme type(light, dark) and the theme.
local function pick()
  local hour = os.date("*t")["hour"]

  local background
  if 06 < hour and  hour < 17 then
    background = "-light"
  else
    background = "-dark"
  end
  -- note: need to use for the refresh.
  return {background, hour % #by_17 + 1}
end

--- changes the theme according to pick.
-- @function change
local function change()
  ui.set_theme(
  'base16-'.. by_17[pick()[2]] .. pick()[1],
  {font = "Inconsolata",
  fontsize = 14}
  )
end

--- @export
return {
  change = change,
  pick = pick
}
