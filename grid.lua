--[[
		Graph version of grid for mazes. On the init state obj.grid has some unconnected nodes
		which will be available for maze algorithms.
]]

local grid = {}
local aux = {}

grid.__index = grid

grid.draw_conf = {	
	v_length = false,
	h_length = false,
	thickness = 1,
	color = '#000000',
	highlight_color = '#FF0000',
	back_color = '#FFFFFF' 
}

function grid:new(rows, columns, walls_mode, has_additions) 
	-- walls_mode – is walls enabled

	if not rows or not columns then error('Can not create a grid. Rows and columns must be specified.') end
	if rows <= 1 or columns <= 1 then 
		error('Rows and columns must be greater than 1. Minimal size of a grid is 2x2.') 
	end

	local walls_mode = not not walls_mode

	local obj = {}
	obj.rows = rows
	obj.columns = columns
	obj.size = rows * columns

	obj.grid = {}
	
	-- RIGHT WALL IS ALWAYS FIRST, BOTTOM WALL IS ALWAYS SECOND.
	for i = 1, self.size * 2 do
		obj.grid[i] = walls_mode
	end

	if has_additions then 
		obj.additions = {}

		for i = 1, self.size do
			obj.additions[i] = false
		end
	end

	return setmetatable( obj, self )
end

-- Maybe it is better to use grid:get(offset)?
function grid:get(x, y, i)
	if not (x*y <= self.size) then error('Coordinates must be in grid.') end

	return 
end

function grid:set(x, y, i, f)
	if not (x*y <= self.size) then error('Coordinates must be in grid.') end
	
	self.grid[] = f
	return true
end

function grid:getrb(x, y)
	return grid:get(x, y, 0), grid:get(x, y, 1)
end

function grid:getr(x, y)
	return grid:get(x, y, 0)
end

function grid:getb(x, y)
	return grid:get(x, y, 1)
end

function grid:setrb(x, y, r, b)
	grid:set(x, y, 0, r)
	grid:set(x, y, 1, b)

	return true
end

function grid:setr(x, y, r)
	grid:set(x, y, 0, r)

	return true
end

function grid:setb(x, y, b)
	grid:set(x, y, 1, b)

	return true
end

return grid