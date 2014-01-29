M = {}

---[[ edit textadept init.lua
local function tae()
  io.open_file(_USERHOME .. "/init.lua")
end
--]]


setmetatable(M, {
  __call = tae
})
return M
