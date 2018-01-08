-- Main controller of graphics and input
-- TODO: Figure out what to do with draw configs.

local make_grid = require 'grid'
local make_renderer = require 'grid_renderer'

local make_bintree = require 'binarytree'

local WINDOW_W, WINDOW_H = 500, 500
local ROWS, COLUMNS = 30, 30

local draw_conf = {}
local grid, gen, rend

math.randomseed( os.time() )

function love.load()
	love.graphics.setBackgroundColor(255, 255, 255, 255)
	love.window.setMode(WINDOW_W, WINDOW_H, windowed, false, 0)

  title = tostring(WINDOW_W) .. " x " .. tostring(WINDOW_H)
  love.window.setTitle(title)

  -- grid = grid_class:new(ROWS, COLUMNS, true)
  -- grid:setr(0, 1, false)
  -- grid:setrb(1, 1, false)
  -- grid:setb(1, 0, false)
  -- rend = grid_render:new(grid, {ox = 0, oy = 0, x = 250, y = 250})

  gen = make_bintree(ROWS, COLUMNS)
  gen:generate()

  rend2 = make_renderer(gen:get_grid(), {ox = 0, oy = 0, x = 500, y = 500})

  -- grid2 = grid_class:new(ROWS, COLUMNS, true)
  -- grid2:setr(0, 1, false)
  -- grid2:setrb(1, 1, false)
  -- grid2:setb(1, 0, false)
  -- rend2 = grid_render:new(grid2, 250, 0, 250, 250)

  -- grid3 = grid_class:new(ROWS, COLUMNS, true)
  -- grid3:setr(0, 1, false)
  -- grid3:setrb(1, 1, false)
  -- grid3:setb(1, 0, false)
  -- rend3 = grid_render:new(grid3, 0, 250, 250, 250)

  -- grid4 = grid_class:new(ROWS, COLUMNS, true)
  -- grid4:setr(0, 1, false)
  -- grid4:setrb(1, 1, false)
  -- grid4:setb(1, 0, false)
  -- rend4 = grid_render:new(grid4, 250, 250, 250, 250)
end

function love.update(dt)

end

function love.draw()
	-- rend:draw()
  rend2:draw()
	-- rend2:draw()
	-- rend3:draw()
	-- rend4:draw()
end
