-- Main controller of graphics and input
-- TODO: Figure out what to do with draw configs.

local grid_class = require'grid'

local WINDOW_W, WINDOW_H = 800, 800
local ROWS, COLUMNS = 80, 50

local draw_conf = {}
local grid

function hex2rgb(hex)
  hex = hex:gsub("#", "")
  return tonumber(hex:sub(1,2), 16), 
  			 tonumber(hex:sub(3,4), 16), 
				 tonumber(hex:sub(5,6), 16),
				 #hex > 7 and tonumber(hex:sub(7,8) or 255)
end

function love.load()
	love.graphics.setBackgroundColor(255, 255, 255, 255)
	love.window.setMode(WINDOW_W, WINDOW_H, windowed, false, 0)

  title = tostring(window_w) .. " x " .. tostring(window_h)
  love.window.setTitle(title)

  grid = grid_class:new(ROWS, COLUMNS)
end

function love.update(dt)

end

function love.draw()

end