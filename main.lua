-- Main controller of graphics and input
-- TODO: Figure out what to do with draw configs.

local make_renderer = require 'grid.grid_renderer'
local make_widget_controller = require 'ui.surface'

local make_bintree = require 'binarytree'
local make_sidewinder = require 'sidewinder'
local make_backtracking = require 'backtracking'

local WINDOW_W, WINDOW_H = 900, 600
local ROWS, COLUMNS = 10, 10

local cur_gen = false
local cur_render = false
local maze_coords ={ ox = 0; oy = 0; x = 600; y = 600 }

local gens = 
{
  ['binarytree'] = make_bintree;
  ['sidewinder'] = make_sidewinder;
  ['backtracking'] = make_backtracking;
}

math.randomseed( os.time() )

function love.load()
	love.graphics.setBackgroundColor(255, 255, 255, 255)
	love.window.setMode(WINDOW_W, WINDOW_H, windowed, false, 0)

  title = tostring(WINDOW_W) .. " x " .. tostring(WINDOW_H)
  love.window.setTitle(title)

  cur_gen = gens['backtracking'](ROWS, COLUMNS)
  cur_render = make_renderer(cur_gen:get_grid(), maze_coords)
end

function love.update(dt)
  if not gen_iter then 
    gen_iter = cur_gen:iter()
  end

  gen_iter()
  love.timer.sleep(0.5)
end

function love.draw()
	cur_render:draw()
end
