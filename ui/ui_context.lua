local context = {}
context.__index = context

function context:new()
  local obj = {}
  obj._children = {}

  return setmetatable(obj, self)
end

function context:add_child(child)
  self._children[#self._children + 1]  = child
end

function context:on_mousepressed(x, y, button)
  for i = #self._children, 1, -1 do
    if self._children[i]:on_mousepressed(x, y, button) then
      return true
    end
  end
end

function context:on_mousereleased(x, y, button)
  for i = #self._children, 1, -1 do
    if self._children[i]:on_mousereleased(x, y, button) then
      return true
    end
  end
end

function context:on_mousemoved(x, y, dx, dy)
  for i = #self._children, 1, -1 do
    if self._children[i]:on_mousemoved(x, y, dx, dy) then
      return true
    end
  end
end

function context:draw()
  for i = 1, #self._children do
    self._children[i]:draw()
  end
end

function context:update()
end

return context
