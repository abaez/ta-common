local M = {}


---[[ quick reset
function M.quick_reset()
  _G.reset()
 end
--]]

---[[ edit textadept init.lua
function M.tae()
  io.open_file(_USERHOME .. "/init.lua")
end
--]]


return M
