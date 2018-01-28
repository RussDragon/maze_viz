local style_class = require 'ui_style'

local skin = {}

do
  local style = style_class:new()
  style:set_back_color('#FFAA00')

  skin.button_normal = style
end

do
  local style = style_class:new()
  style:set_back_color('#0000FF')

  skin.button_pressed = style
end

return skin
