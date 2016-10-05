--- See @{README.md} for details on usage.
-- @author Alejandro Baez <https://twitter.com/a_baez>
-- @copyright 2014-2016
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
