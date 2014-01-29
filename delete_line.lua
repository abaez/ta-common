local M = {}

---[[ delete a line
local function get_sel_lines()
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
local function delete_lines()
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

setmetatable(M, {
  __call = delete_lines
})

return M
