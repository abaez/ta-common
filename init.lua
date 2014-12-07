local lfs = require 'lfs'

local M = {}

for filename in lfs.dir(_USERHOME..'/modules/common/') do
  if filename:find('%.lua$') and filename ~= 'init.lua' then

    -- using the name of the module as the key. ;)
    local key = filename:match('^(.+)%.lua$')

    M[key] = require('common.'..key)
  end
end


if not CURSES then
  -- changes the theme for every hour.
  M.themer.change()
end

events.connect(events.INITIALIZED, function()
  -- deletes a line ore a selection.
  keys['cK'] = { function()
    textadept.snippets._cancel_current()
    M.delete_line()
  end}

  -- opens a terminal in the locaton
  keys['cT'] = {M.open_terminal}
  -- opens the `~/.textadept/init.lua` file
  keys['cae'] = {M.quick_edit}
  -- selects all similar words and puts a cursor on it!
  keys["cG"] = {M.multiedit.select_all}

  -- reset
  keys["cesc"] = {_G.reset}

end)

return M
