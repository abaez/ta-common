--- the Textadept theme changer.
-- See @{README.md} for details on usage.
-- @author [Alejandro Baez](https://twitter.com/a_baez)
-- @copyright 2015
-- @license MIT (see LICENSE)
-- @module themer

--- themes to choose from.
-- A simple list to locate themes to apply. Follows the 8 hour work schedule
-- for the brightness of the theme.
-- @table by_17
local by_17 = {}

for theme in io.popen("ls ~/.textadept/themes"):lines() do
  by_17[#by_17 + 1] = theme:gsub("%.lua", "")
end

--- picks the theme by hour.
-- @param themes a list of themes to choose from in _USERHOME/themes directory.
-- @param ti time to start the light theme choice.
-- @param tf time to end the light theme choice.
local function pick(themes, ti, tf)
  local hour = os.date("*t")["hour"]

  local background = (ti < hour and hour < tf) and "-light" or "-dark"

  local theme = ""
  while not theme:match(background) do
    theme = themes[math.random(1,#themes)]
  end

  return theme, background
end


--- changes the theme according to pick.
-- @param ti see @{pick} for more info.
-- @param tf see @{pick} for more info.
local function change(ti, tf)
  CURRENT_THEME, CURRENT_BACKGROUND = pick(by_17, ti, tf)

  ui.set_theme(
    CURRENT_THEME,
    {
      font = CURRENT_FONT,
      fontsize = CURRENT_FONTSIZE
    }
  )

  return CURRENT_THEME, CURRENT_BACKGROUND
end


--- @export
return {
  change = change
}
