local mt_r = {
  move = function(r, x, y) r.x=x; r.y=y end
}
local mt_c = {
  move = function(r, x, y, z) r:move(x, y); r.z=z end
}
setmetatable(mt_c, mt_r)

--- @type rectangle
-- @field #number x
-- @field #number y

--- @return #rectangle
local createrectangle = function(x, y)
  return setmetatable({x=x, y=y}, mt_r)
end

--- @type cube
-- @extends rectangle#rectangle
-- @field #number z
local createcube = function(x, y, z)
  return setmetatable({x=x, y=y, z=z}, mt_c)
end
