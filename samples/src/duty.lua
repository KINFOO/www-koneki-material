---
-- Used for harsh times
-- @module duty

--- @type duty
local M = { }

---
-- Get every thing ready.
--
-- @callof #duty
--
-- @param #duty   self
-- @param #number date Conflict's start date
-- @param #string alliance Name of your side
function M.start(self, date, alliance) end

local mt = {
  __call = M.start
}

function M.declaration()

end
function M.votebudget() end
function M.conscription() end
function M.invasion() end
M.style = {
  legacy  = 1,
  classic = 2,
  modern  = 3
}
return setmetatable(M, mt)
