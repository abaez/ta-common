--- the open terminal module.
-- See @{README.md} for details on usage.
-- @author Alejandro Baez <https://twitter.com/a_baez>
-- @copyright 2014-2016
-- @license MIT (see LICENSE)
-- @module open_terminal

local M = {}

--- opens a terminal of the current buffer's directory.
local function openTerminalHere()
  terminalString = TERMINAL_STRING or "termite"
  pathString = "~"
  if buffer.filename then
    pathString = (buffer.filename or ''):match('^.+[//]')
  end
  spawn(terminalString.." -d "..pathString.." &")
end

setmetatable(M, {
  __call = openTerminalHere
})

return M
