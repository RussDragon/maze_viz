local widget = require 'ui_widget'
local oop = require 'minioop'

local textbox = {}
textbox.__index = textbox

oop.extend(textbox, widget)

function textbox:new(ox, oy, x, y, df)
  local obj = widget:new(ox, oy, x, y, df)
  obj._cb = false
  obj._is_pressed = false

  return setmetatable(obj, self)
end

function textbox:on_mousepressed(x, y, button)
end

function textbox:on_mousereleased(x, y, button)
end

function textbox:on_mousemoved(x, y, dx, dy)
end

function textbox:draw()
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

return textbox
