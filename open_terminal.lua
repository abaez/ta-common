local M = {}


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

return M
