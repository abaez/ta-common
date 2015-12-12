--- small navigation mode based on vi.
-- Only used for simple 'hjkl' navigation and saving.
-- For a full vi setup, look at [Chris vi](https://github.com/jugglerchris/textadept-vi)
-- @author [Alejandro Baez](https://twitter.com/a_baez)
-- @module nav

keys.command_mode = {
  ['h'] = buffer.char_left,
  ['j'] = buffer.line_down,
  ['k'] = buffer.line_up,
  ['l'] = buffer.char_right,
  ['i'] = function()
    keys.MODE = nil
    ui.statusbar_text = 'INSERT MODE'
  end,
  ['o'] = function()
    buffer:line_end(); buffer:new_line()
    keys.MODE = nil
    ui.statusbar_text = 'INSERT MODE'
  end,
  [":"] = {
    w = {io.save_file},
    q = {io.close_buffer},
    Q = {quit}
  }
}

keys['esc'] = function()
  keys.MODE = 'command_mode'
  ui.statusbar_text = "COMMAND MODE"
  buffer.caret_style = buffer.CARETSTYLE_BLOCK
end
events.connect(events.UPDATE_UI, function()
  if keys.MODE == 'command_mode' then return end
  ui.statusbar_text = 'INSERT MODE'
  buffer.caret_style = buffer.CARETSTYLE_LINE
end)
