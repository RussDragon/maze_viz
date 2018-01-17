local oop = require 'minioop'
local setmetatable = setmetatable

local widget = {}
widget.__index = widget

function widget:new(ox, oy, x, y)
  if x < ox or y < oy then error('Rectangle must be specified from left to right') end

  local obj = {}
  obj._children = {}
  obj._pos = { ox = ox; oy = oy; x = x; y = y }

  return setmetatable(obj, self)
end

function widget:check_collision(x, y)
  if x >= self._pos.ox and x <= self._pos.x and
     y >= self._pos.oy and y <= self._pos.y 
  then return true end
end

function widget:add_child(child)
  self._children[#self._children + 1]  = child
end

return widget
