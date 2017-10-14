-- Main controller of graphics and input

local grid_class = require'grid'

local WINDOW_W, WINDOW_H = 800, 800
local ROWS, COLUMNS = 80, 50

local draw_conf = {
	grid = {}
}

local function hex_to_rgb(str)

end

local function setup_grid_draw(conf)
	local conf = conf or {}

	draw_conf.grid.h_length = conf.h_length or WINDOW_H / ROWS or error('Horizontal length must be specified.')
	draw_conf.grid.v_length = conf.v_length or WINDOW_W / COLUMNS or error('Vertical length must be specified.')

	draw_conf.grid.thickness = conf.thickness or 1
	
	draw_conf.grid.color = conf.color or '#000000'
	draw_conf.grid.highlight_color = conf.highlight_color or '#FF0000'
	draw_conf.grid.back_color = conf.back_color or '#FFFFFF'
end

function love.load()
	love.graphics.setBackgroundColor(255, 255, 255, 255)
	love.window.setMode(WINDOW_W, WINDOW_H, windowed, false, 0)

  title = tostring(window_w) .. " x " .. tostring(window_h)
  love.window.setTitle(title)

  setup_grid_draw()

  local grid = grid_class:new(ROWS, COLUMNS)
end

function love.update(dt)

end

function love.draw()
	
end