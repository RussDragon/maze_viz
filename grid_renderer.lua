-- WARNING: DO NOT USE THIS CODE IN PRODUCTION. THIS IS TEST ONLY.
local renderer = {}

renderer.__index = renderer

renderer.draw_conf = {	
	window_w = false,
	window_h = false,
	v_length = false,
	h_length = false,
	ox = false,
	oy = false,
	thickness = 1,
	color = '#000000',
	highlight_color = '#FF0000',
	back_color = '#FFFFFF' 
}

local function vertfromwalls(pix_x, pix_y, w, h, r_wall, b_wall)
  local vert = {}

  if r_wall then vert.right_wall = {pix_x+w, pix_y, pix_x+w, pix_y+h} end
  if b_wall then vert.bottom_wall = {pix_x, pix_y+h, pix_x+w, pix_y+h} end

  return vert
end

local function hex2rgb(hex)
  hex = hex:gsub("#", "")

  return tonumber(hex:sub(1,2), 16), 
  			 tonumber(hex:sub(3,4), 16), 
				 tonumber(hex:sub(5,6), 16),
				 #hex > 7 and tonumber(hex:sub(7,8) or 255)
end

function renderer:new(grid_obj, ox, oy, window_w, window_h)
	if not grid_obj then error('Grid object must be passed to render.') end

	local obj = {}
	obj.grid = grid_obj

	self.draw_conf.window_h = window_h
	self.draw_conf.window_w = window_w

	self.draw_conf.v_length = window_h / grid_obj.rows
	self.draw_conf.h_length = window_h / grid_obj.columns

	self.draw_conf.ox = ox
	self.draw_conf.oy = oy
	
	return setmetatable(obj, self)
end

function renderer:setup_draw(conf)
end

function renderer:update(dt)
end

function renderer:draw()
	local ox, oy = self.draw_conf.ox, self.draw_conf.oy
	local w, h = self.draw_conf.h_length, self.draw_conf.v_length

	for y = 0, self.grid.rows - 1 do
		for x = 0, self.grid.columns - 1 do
			for k, v in pairs(vertfromwalls(ox+(w*x), oy+(h*y), w, h, self.grid:getrb(x, y))) do
				local r, g, b = 0, 0, 0
	      love.graphics.setColor(r, g, b)
	      love.graphics.setLineWidth(1)
	      love.graphics.line(v)
	    end
		end
	end

  love.graphics.line(ox, oy+1, self.draw_conf.window_w, oy+1) -- Borders on the top and left
  love.graphics.line(ox+1, oy, ox+1, self.draw_conf.window_h)
end

return renderer