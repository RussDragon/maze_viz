local oop = require 'minioop'

local context = oop.class()

function context:new(surface)
  local obj = {}
  obj._root = surface

  return oop.object(self, obj)
end

function context:add_child(child)
  self._root:add_child(child)
end

function context:on_mousepressed(x, y, button)
  self._root:on_mousepressed(x, y, button)
end

function context:on_mousereleased(x, y, button)
  self._root:on_mousereleased(x, y, button)
end

function context:on_mousemoved(x, y, dx, dy)
  self._root:on_mousemoved(x, y, dx, dy)
end

function context:draw()
  love.graphics.push()

  self._root:draw()
  
  love.graphics.pop()
end

return context
