local type, tonumber, error, setmetatable = type, tonumber, error, setmetatable

local DRAW_DEFAULTS = {
	thickness = 1,
	wall_color = "#000000",
	back_color = "#FFFFFF",
	highlight_color = "#FF0000"
}

local vertfromwalls = function(pix_x, pix_y, w, h, r_wall, b_wall)
  local vert = {}

  if r_wall then vert.right_wall = {pix_x+w, pix_y, pix_x+w, pix_y+h} end
  if b_wall then vert.bottom_wall = {pix_x, pix_y+h, pix_x+w, pix_y+h} end

  return vert
end

local hex2rgb = function(hex)
  hex = hex:gsub("#", "")

  return tonumber(hex:sub(1,2), 16),
  			 tonumber(hex:sub(3,4), 16), 
				 tonumber(hex:sub(5,6), 16),
				 #hex > 7 and tonumber(hex:sub(7,8) or 255)
end

local make_renderer
do
  local setup_draw = function(self, draw_mask, thickness, wall_color, highlight_color, back_color)
  	if draw_mask and type(draw_mask) == 'table' then 
  		self._draw_conf.ox = draw_mask.ox
  		self._draw_conf.oy = draw_mask.oy
  		self._draw_conf.x = draw_mask.x
  		self._draw_conf.y = draw_mask.y
  	end

  	self._draw_conf.thickness = thickness or self._draw_conf.thickness 
  	self._draw_conf.wall_color = wall_color or self._draw_conf.wall_color
  	self._draw_conf.back_color = back_color or self._draw_conf.back_color
  	self._draw_conf.highlight_color = highlight_color or self._draw_conf.highlight_color
  end

  local update = function(self, dt)
  end

  local draw = function(self)
  	local w, h = self._draw_conf.x/self._draw_conf.columns, self._draw_conf.y/self._draw_conf.rows
  	local ox, oy = self._draw_conf.ox, self._draw_conf.oy

  	for x, y in self._grid:iter() do
  		for _, v in pairs(vertfromwalls(ox+(w*x), oy+(h*y), w, h, self._grid:getrb(x, y))) do
  			local r, g, b = 0, 0, 0
        love.graphics.setColor(r, g, b)
        love.graphics.setLineWidth(1)
        love.graphics.line(v)
  		end
  	end

    love.graphics.line(ox, oy+1, self._draw_conf.max_x, oy+1) -- Borders on the top and left
    love.graphics.line(ox+1, oy, ox+1, self._draw_conf.max_y)
  end

  make_renderer = function(grid_obj, draw_mask)
    if not grid_obj then error('Grid object must be passed to render.') end
    local draw_mask = draw_mask or {}

    local wh, ww = love.window.getMode()
    return 
    {
      setup_draw = setup_draw;
      update = update;
      draw = draw;

      _wh = wh;
      _ww = ww;

      _grid = grid_obj;
      _draw_conf = 
      {
        ox = draw_mask.ox or 0,
        oy = draw_mask.oy or 0,
        x = draw_mask.x or ww,
        y = draw_mask.y or wh,

        rows = grid_obj:get_height(),
        columns = grid_obj:get_width(),
        
        thickness = DRAW_DEFAULTS.thickness,
        wall_color = DRAW_DEFAULTS.wall_color,
        back_color = DRAW_DEFAULTS.back_color,
        highlight_color = DRAW_DEFAULTS.highlight_color,
      };
    }
  end
end

return make_renderer
