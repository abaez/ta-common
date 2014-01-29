local M = {}


---[[ open terminal here
local function openTerminalHere()
  terminalString = "urxvt"
  pathString = "~"
  if buffer.filename then
    pathString = (buffer.filename or ''):match('^.+[//]')
  end
  io.popen(terminalString.." -cd "..pathString.." &")
end
--]]


setmetatable(M, {
  __call = openTerminalHere
})

return M
