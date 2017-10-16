local grid = {}
local aux = {}

grid.__index = grid

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
	for i = 0, obj.size * 2 - 1 do
		obj.grid[i] = walls_mode
	end

	if has_additions then 
		obj.additions = {}

		for i = 0, obj.size - 1 do
			obj.additions[i] = false
		end
	end

	return setmetatable(obj, self)
end

-- Maybe it is better to use grid:get(offset)?
function grid:get(x, y, i)
	if not (x*y <= self.size) then error('Coordinates must be in grid.') end

	return self.grid[(y * self.rows + x)*2 + i]
end

function grid:set(x, y, i, f)
	print(#self.grid)
	print('x: ', x, ' y: ', y, ' offset: ', y * self.rows + x + i)
	if not (x*y <= self.size) then error('Coordinates must be in grid.') end
	
	self.grid[(y * self.rows + x)*2 + i] = f
	return true
end

function grid:getrb(x, y)
	return self:get(x, y, 0), self:get(x, y, 1)
end

function grid:getr(x, y)
	return self:get(x, y, 0)
end

function grid:getb(x, y)
	return self:get(x, y, 1)
end

function grid:setrb(x, y, r, b)
	self:set(x, y, 0, r)
	self:set(x, y, 1, b)

	return true
end

function grid:setr(x, y, r)
	self:set(x, y, 0, r)

	return true
end

function grid:setb(x, y, b)
	self:set(x, y, 1, b)

	return true
end

return grid