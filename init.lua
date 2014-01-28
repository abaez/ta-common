local lfs = require 'lfs'

local M = {}


for filename in lfs.dir(_USERHOME..'/modules/common/') do
  if filename:find('%.lua$') and filename ~= 'init.lua' then

    -- using the name of the module as the key. ;)
    local key = filename:match('^(.+)%.lua$')

    M[key] = require('common.'..key)
  end
end


return M
