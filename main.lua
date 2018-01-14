-- Main controller of graphics and input
-- TODO: Figure out what to do with draw configs.

local make_grid = require 'grid'
local make_renderer = require 'grid_renderer'

local make_bintree = require 'binarytree'
local make_sidewinder = require 'sidewinder'
local make_backtracking = require 'backtracking'

local WINDOW_W, WINDOW_H = 800, 800
local ROWS, COLUMNS = 10, 10

local draw_conf = {}

math.randomseed( os.time() )

function love.load()
	love.graphics.setBackgroundColor(255, 255, 255, 255)
	love.window.setMode(WINDOW_W, WINDOW_H, windowed, false, 0)

  title = tostring(WINDOW_W) .. " x " .. tostring(WINDOW_H)
  love.window.setTitle(title)

  bintree_gen = make_bintree(ROWS, COLUMNS)
  -- bintree_gen:generate()

  sidewinder_gen = make_sidewinder(ROWS, COLUMNS)
  -- sidewinder_gen:generate()

  backtracking_gen = make_backtracking(ROWS, COLUMNS)
  -- backtracking_gen:generate()

  rend = make_renderer(bintree_gen:get_grid(), {ox = 0, oy = 0, x = 800, y = 800})
  rend2 = make_renderer(sidewinder_gen:get_grid(), {ox = 0, oy = 0, x = 800, y = 800})
  rend3 = make_renderer(backtracking_gen:get_grid(), {ox = 0, oy = 0, x = 800, y = 800})
end

function love.update(dt)
  if not gen_iter then 
    gen_iter = backtracking_gen:iter()
  end

  gen_iter()
  love.timer.sleep(0.5)
end

function love.draw()
	rend3:draw()
end
