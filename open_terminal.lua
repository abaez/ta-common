--- the open terminal module.
-- See @{README.md} for details on usage.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- @copyright 2015
-- @license MIT (see LICENSE)
-- @module open_terminal

local M = {}

--- opens a terminal of the current buffer's directory.
local function openTerminalHere()
  terminalString = TERMINALSTRING or "termite"
  pathString = "~"
  if buffer.filename then
    pathString = (buffer.filename or ''):match('^.+[//]')
  end
  io.popen(terminalString.." -d "..pathString.." &")
end

setmetatable(M, {
  __call = openTerminalHere
})

return M
