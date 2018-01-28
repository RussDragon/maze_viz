local widget = require 'ui_widget'
local oop = require 'minioop'

local button = oop.class()
oop.extend(button, widget)

local function hex_to_rgb(hex)
  hex = hex:gsub("#", "")

  return tonumber(hex:sub(1,2), 16),
         tonumber(hex:sub(3,4), 16), 
         tonumber(hex:sub(5,6), 16),
         #hex > 7 and tonumber(hex:sub(7,8) or 255) or 255
end

function button:new(ox, oy, width, height, text)
  local obj = widget:new(ox, oy, width, height)

  -- _tc == _text_conf
  obj._tc = {} 
  obj._tc.text = text or ''
  obj._tc.color = '#000000'
  obj._tc.size = 12
  obj._tc.font = love.graphics.newFont(obj._tc.size)

  obj._cb = false
  obj._is_pressed = false

  return oop.object(self, obj)
end

function button:set_callback()
end

function button:set_text_size(size)
  self._tc.size = size
end

function button:set_text_color(hex_color)
  self._tc.color = hex_color
end

function button:on_mousepressed(x, y, button)
  if not self._is_pressed and self:check_collision(x, y) and button == 1 then
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
    self._style.button_pressed:draw_back(self._pos.ox, self._pos.oy, self._w, self._h)
    -- love.graphics.setColor(0, 255, 0)
  else
    self._style.button_normal:draw_back(self._pos.ox, self._pos.oy, self._w, self._h)
    -- love.graphics.setColor(255, 0, 0)
  end

  -- love.graphics.line(self._pos.ox, self._pos.oy, self._pos.x, self._pos.oy)
  -- love.graphics.line(self._pos.x, self._pos.oy, self._pos.x, self._pos.y)
  -- love.graphics.line(self._pos.x, self._pos.y, self._pos.ox, self._pos.y)
  -- love.graphics.line(self._pos.ox, self._pos.y, self._pos.ox, self._pos.oy)
end

return button
