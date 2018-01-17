local widget = require 'ui_widget'
local oop = require 'minioop'

local button = {}
button.__index = button

oop.extend(button, widget)

function button:new(ox, oy, x, y)
  local obj = widget:new(ox, oy, x, y)
  obj._cb = false
  obj._is_pressed = false

  return setmetatable(obj, self)
end

function button:on_mousepressed(x, y, button)
  if not self._is_pressed and self:check_collision(x, y) then
    self._is_pressed = true

    return true
  end
end

function button:on_mousereleased(x, y, button)
  if self._is_pressed and self:check_collision(x, y) then
    if self._cb then self._cb() end

    self._is_pressed = false

    return true
  end
end

function button:on_mousemoved(x, y, dx, dy)
  if self._is_pressed and not self:check_collision(x, y) then
    self._is_pressed = false

    return true
  end
end

function button:draw()
  if self._is_pressed then
    love.graphics.setColor(0, 255, 0)
  else
    love.graphics.setColor(255, 0, 0)
  end

  love.graphics.line(self._pos.ox, self._pos.oy, self._pos.x, self._pos.oy)
  love.graphics.line(self._pos.x, self._pos.oy, self._pos.x, self._pos.y)
  love.graphics.line(self._pos.x, self._pos.y, self._pos.ox, self._pos.y)
  love.graphics.line(self._pos.ox, self._pos.y, self._pos.ox, self._pos.oy)
end

return button
