local widget = require 'ui_widget'
local oop = require 'minioop'

local label = oop.class()

oop.extend(label, widget)

function label:new(ox, oy, text, size, color)
  local size, text = size or 12, text or ''
  local font = love.graphics.newFont(size)
  local w, h = font:getHeight(text), font:getWidth(text)

  local obj = widget:new(ox, oy, w, h)

  obj._text = text
  obj._size = size
  obj._color = color or '#000000'
  obj._font = font

  return oop.object(self, obj)
end

function label:set_size(size)
  self._size = size
  self._font = love.graphics.newFont(size)
end

function label:set_color(hex_color)
  self._color = hex_color
end

function label:set_align(align)
end

-- set_color, set_size, set_align, set_borders, etc

function label:draw()
  love.graphics.setColor(hex_to_rgb(self._color))
  love.graphics.setFont(self._font)
  love.graphics.print(self._text, self._pos.ox, self._pos.oy)
end

return label
