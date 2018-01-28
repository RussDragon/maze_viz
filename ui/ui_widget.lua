local oop = require 'minioop'
local def_style = require 'default_style'

local widget = oop.class()

function widget:new(ox, oy, width, height)
  if x < ox or y < oy then error('Rectangle must be specified from left to right') end

  local obj = {}
  obj._children = {}
  obj._pos = { ox = ox; oy = oy; x = ox + width; y = oy + height }
  obj._w = width
  obj._h = height
  obj._style = def_style

  return oop.object(self, obj)
end

function widget:set_option(option, value)
  if option == 'style' then 
    self:set_style(value)
  elseif option == 'x' then
    self:set_x(value)
  elseif option == 'y' then
    self:set_y(value)
  elseif option == 'width' then
    self:set_width(value)
  elseif option == 'height' then
    self:set_height(value)
  end
end

function widget:set_x(ox)
  self._pos.ox = ox
  self._pos.x = ox + self._w
end

function widget:set_y(oy)
  self._pos.oy = oy
  self._pos.y = oy + self._h
end

function widget:set_width(width)
  self._w = width
  self._pos.x = self._pos.ox + width
end

function widget:set_height(height)
  self._h = height
  self._pos.y = self._pos.oy + height
end

function widget:set_style(style)
  self._style = style
end

function widget:get_style()
  return self._style
end

function widget:check_collision(x, y)
  if x >= self._pos.ox and x <= self._pos.x and
     y >= self._pos.oy and y <= self._pos.y 
  then return true end
end

function widget:add_child(child)
  self._children[#self._children + 1]  = child
end

function widget:on_mousepressed(x, y, button)
end

function widget:on_mousereleased(x, y, button)
end

function widget:on_mousemoved(x, y, dx, dy)
end

function widget:draw()
end

return widget
