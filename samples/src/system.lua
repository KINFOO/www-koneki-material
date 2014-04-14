---
-- Deep system concepts...
--
-- @module system
local M = { }

---
-- User description at system level
--
-- @type user
-- @field #string id User identifier
-- @field #string name User full name
-- @field #list<#group> groups All groups User belongs to
M.users = { }

---
-- @type system
-- @map <#string, #user> users All users sorted by identifier

---
-- Sanity checks
function M.checks()
  if not M.root then
    error('No root user found.')
  end
end

return M
