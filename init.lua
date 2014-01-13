local M = {}


---[[ delete a line
function get_sel_lines()
  if #buffer:get_sel_text() == 0 then
    return buffer:line_from_position(buffer.current_pos),
      buffer:line_from_position(buffer.current_pos)
  else
    startLine = buffer:line_from_position(buffer.selection_start)
    endLine = buffer:line_from_position(buffer.selection_end)
    if startLine > endLine then
      startLine, endLine = endLine, startLine
    end
    return startLine, endLine
  end
end

-- Deletes the currently selected lines
function M.delete_lines()
  buffer:begin_undo_action()
  local startLine, endLine = get_sel_lines()
  if buffer.current_pos == buffer.selection_end then
    buffer:goto_line(startLine)
  end
  for i = startLine, endLine do
    buffer:home()
    buffer:del_line_right()
    if buffer:line_from_position(buffer.current_pos) == 0 then
      buffer:line_down()
      buffer:home()
      buffer:delete_back()
    else
      buffer:delete_back()
      buffer:line_down()
    end
  end
  buffer:end_undo_action()
end
--]]

---[[ open terminal here
function M.openTerminalHere()
  terminalString = "urxvt"
  pathString = "~"
  if buffer.filename then
    pathString = (buffer.filename or ''):match('^.+[//]')
  end
  io.popen(terminalString.." -cd "..pathString.." &")
end
--]]

---[[ quick reset
function M.quick_reset()
  _G.reset()
end
--]] 

---[[ edit textadept init.lua
function M.tae()
  io.open_file("/home/arch/.textadept/init.lua")
end
--]]

return M