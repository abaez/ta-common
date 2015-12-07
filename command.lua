--- the command module.
-- See @{README.md} for details on usage.
-- @author  [Alejandro Baez](https://twitter.com/a_baez)
-- @copyright 2015
-- @license MIT (see LICENSE)
-- @module command

--- run shell on command entry.
-- Uses the current project or cwd for running shell commands.
local function command(...)
  local proc, err = spawn(tostring(...), io.get_project_root() or
    (buffer.filename or ''):match("^.+[//]"))
  if not proc then
    error(err)
  end
  ui.print(proc:read("*a"))
  proc:wait()
end

return {
  E = command
}
