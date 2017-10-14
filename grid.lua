--[[
		Graph version of grid for mazes. On the init state obj.grid has some unconnected nodes
		which will be available for maze algorithms.
]]

local grid = {}
local aux = {}

grid.__index = grid

function grid:new(rows, columns, walls_mode) 
	-- walls_mode – is walls enabled

	if not rows or not columns then error('Can not create grid. Rows and columns must be specified.') end
	if rows <= 1 or columns <= 1 then 
		error('Rows and columns must be greater than 1. Minimal size of grid is 2x2.') 
	end

	local walls_mode = not not walls_mode

	local obj = {}

	obj.rows = rows
	obj.columns = columns
	obj.size = rows * columns

	obj.grid = {}

	for y = 1, columns do
		obj.grid[y] = {}

		for x = 1, rows do
			obj.grid[y][x] = {
				right_wall = walls_mode,
				bottom_wall = walls_mode,

				__additions = {}
			}
		end
	end

	return setmetatable( obj, self )
end

function grid:get(coords)
	return self[y] and self[y][x]
end

function grid:open_walls()
	for _, v in pairs(self.grid) do
		v.right_wall = false
		v.bottom_wall = false
	end
end

function grid:close_walls()
	for _, v in pairs(self.grid) do
		v.right_wall = false
		v.bottom_wall = false
	end
end

return grid