local context_class = require 'ui_context'
local button_class = require 'ui_button'

local WINDOW_W, WINDOW_H = 800, 800

function love.load()
  love.graphics.setBackgroundColor(255, 255, 255, 255)
  love.window.setMode(WINDOW_W, WINDOW_H, windowed, false, 0)

  title = tostring(WINDOW_W) .. " x " .. tostring(WINDOW_H)
  love.window.setTitle(title)

  context = context_class:new()
  context:add_child(button_class:new(10, 10, 50, 80))
  context:add_child(button_class:new(60, 10, 100, 80))
  context:add_child(button_class:new(60, 70, 100, 140))
end

function love.mousepressed(x, y, button, istouch)
  context:on_mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
  context:on_mousereleased(x, y, button)
end

function love.mousemoved(x, y, dx, dy)
  context:on_mousemoved(x, y, dx, dy)
end

function love.update(dt)
end

function love.draw()
  context:draw()
end
