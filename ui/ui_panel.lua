local widget = require 'ui_widget'
local oop = require 'minioop'

local panel = oop.class()
oop.extend(panel, widget)

function panel:new(ox, oy, width, height, text)
  local obj = widget:new(ox, oy, width, height)
  obj._text = text

  return oop.object(self, obj)
end

function panel:draw()
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

return panel
