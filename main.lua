-- Main controller of graphics and input
-- TODO: Figure out what to do with draw configs.

local grid_class = require'grid'
local grid_render = require'grid_renderer'

local WINDOW_W, WINDOW_H = 500, 500
local ROWS, COLUMNS = 3, 3

local draw_conf = {}
local grid

function love.load()
	love.graphics.setBackgroundColor(255, 255, 255, 255)
	love.window.setMode(WINDOW_W, WINDOW_H, windowed, false, 0)

  title = tostring(WINDOW_W) .. " x " .. tostring(WINDOW_H)
  love.window.setTitle(title)

  grid = grid_class:new(ROWS, COLUMNS, true)
  grid:setrb(1, 1, false)
  rend = grid_render:new(grid, 0, 0, love.graphics.getDimensions())
end

function love.update(dt)

end

function love.draw()
	rend:draw()
end