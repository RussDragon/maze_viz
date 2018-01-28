local oop = require 'minioop'
local widget = require 'ui_widget'

local surface = oop.class()

oop.extend(surface, widget)

function surface:new()
  local obj = {}
  obj._children = {}

  return oop.object(self, obj)
end

function surface:add_child(child)
  self._children[#self._children + 1]  = child
end

function surface:on_mousepressed(x, y, button)
  for i = #self._children, 1, -1 do
    if self._children[i]:on_mousepressed(x, y, button) then
      return true
    end
  end
end

function surface:on_mousereleased(x, y, button)
  for i = #self._children, 1, -1 do
    if self._children[i]:on_mousereleased(x, y, button) then
      return true
    end
  end
end

function surface:on_mousemoved(x, y, dx, dy)
  for i = #self._children, 1, -1 do
    if self._children[i]:on_mousemoved(x, y, dx, dy) then
      return true
    end
  end
end

function surface:draw()
  for i = 1, #self._children do
    self._children[i]:draw()
  end
end

return surface
