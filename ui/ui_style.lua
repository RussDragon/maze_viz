local oop = require 'minioop'

local style = oop.class()

local function hex_to_rgb(hex)
  hex = hex:gsub("#", "")

  return tonumber(hex:sub(1,2), 16),
         tonumber(hex:sub(3,4), 16), 
         tonumber(hex:sub(5,6), 16),
         #hex > 7 and tonumber(hex:sub(7,8) or 255) or 255
end

function style:new()
  local obj = {}

  obj.back_color = '#FF00FF'
  obj.borders_color = '#000000'
  obj.text_color = '#000000'

  return oop.object(self, obj)
end

function style:set_option(option, value)
  self[option] = value
end

function style:set_back_color(hex_color)
  self.back_color = hex_color
end

function style:set_borders_color(hex_color)
  self.colors.borders = hex_color
end

function style:set_text_color(hex_color)
  self.colors.text = hex_color
end

function style:draw_back(ox, oy, width, height)
  love.graphics.setColor(hex_to_rgb(self.back_color))
  love.graphics.rectangle('fill', ox, oy, width, height)
end

function style:draw_text(ox, oy, text)
end

function style:draw_borders(ox, oy, width, height)
end

return style
