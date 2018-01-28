local context_class = require 'ui_context'
local surface_class = require 'ui_surface'
local button_class = require 'ui_button'
local label_class = require 'ui_label'

local WINDOW_W, WINDOW_H = 800, 800

function love.load()
  love.graphics.setBackgroundColor(255, 255, 255, 255)
  love.window.setMode(WINDOW_W, WINDOW_H, windowed, false, 0)

  title = tostring(WINDOW_W) .. " x " .. tostring(WINDOW_H)
  love.window.setTitle(title)

  surface = surface_class:new()
  context = context_class:new(surface)
  context:add_child(button_class:new(10, 10, 80, 30))
  -- context:add_child(label_class:new(15, 15, 'TEST', 15))
  -- context:add_child(button_class:new(60, 10, 100, 80))
  -- context:add_child(button_class:new(60, 70, 100, 140))
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
