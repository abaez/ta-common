--- the initializer for common module.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- @copyright 2015
-- @license MIT (see LICENSE)
-- @module init

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
  -- changes the theme for each instance of textadept.
  CURRENT_THEME, CURRENT_BACKGROUND = M.themer.change(
    TIME_INITIAL or 06, TIME_FINAL or 17)
end

events.connect(events.INITIALIZED, function()
  -- deletes a line or a selection. Also cancels current snippet.
  keys['cK'] = {function()
    textadept.snippets._cancel_current()
    M.delete_line()
  end}

  -- opens a terminal in the locaton
  keys['cT'] = {M.open_terminal}
  -- opens the `~/.textadept/init.lua` file
  keys['cae'] = {M.quick_edit}
  -- selects all similar words and puts a cursor on it!
  keys["cG"] = {M.multiedit.select_all}

  -- expand line or highlighted lines.
  keys['aright'] = {function()
    local line = #buffer:get_sel_text() == 0 and buffer:get_sel_text() or false
    M.folding.expand_fold(line)
  end}
  -- collapse line or highlighted lines.
  keys['aleft'] = {function()
    local line = #buffer:get_sel_text() == 0 and buffer:get_sel_text() or false
    M.folding.collapse_fold(line)
  end}
  -- expand all lines.
  keys['caright'] = {M.folding.expand_folds}
  -- collapse all lines.
  keys['caleft'] = {M.folding.collapse_folds}

  -- reset
  keys["cesc"] = {_G.reset}
end)

if TABSTOP_ENABLE then
  -- enable elastic_tabstops
  M.elastic_tabstops.enable()
end

return M
