--- A module that allow to manage geometry shapes
-- @module geometry
local M = {}
 
--- A rectangle 
-- @type rectangle
-- @field #number x 
-- @field #number y 
-- @field #number width
-- @field #number height
local R = {x=0, y=0, width=100, height=100, }
 
--- Move the rectangle
-- @function [parent=#rectangle] move
-- @param self
-- @param x
-- @param y
function R.move(self,x,y)
  self.x = self.x + x
  self.y = self.y + y
end
--- Create a new rectangle
-- @function [parent=#geometry] newRectangle
-- @param x
-- @param y
-- @param width
-- @param height
-- @return #rectangle the created rectangle
function M.newRectangle(x,y,width,height)
  local newrectangle = {x=x,y=y,width=width,height=height}
 
  -- set to new rectangle the properties of a rectangle
  setmetatable(newrectangle, {__index = R})
  return newrectangle
end
return M
