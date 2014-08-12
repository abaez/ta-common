local M = {}


---[[ open terminal here
local function openTerminalHere()
  terminalString = "termite"
  pathString = "~"
  if buffer.filename then
    pathString = (buffer.filename or ''):match('^.+[//]')
  end
  io.popen(terminalString.." -d "..pathString.." &")
end
--]]


setmetatable(M, {
  __call = openTerminalHere
})

return M
