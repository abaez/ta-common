--- See @{README.md} for details on usage.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- @copyright 2015
-- @license MIT (see LICENSE)
-- @module quick_edit

M = {}

--- opens the init.lua file.
local function tae()
  io.open_file(_USERHOME .. "/init.lua")
end

setmetatable(M, {
  __call = tae
})

return M
