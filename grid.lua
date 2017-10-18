local error, setmetatable = error, setmetatable

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
	for i = 1, obj.size * 2 do
		obj.grid[i] = walls_mode
	end

	if has_additions then 
		obj.additions = {}

		for i = 1, obj.size do
			obj.additions[i] = false
		end
	end

	return setmetatable(obj, self)
end

-- WIP IN PROGRESS. ITERATOR ISN'T FINISHED. CONDITIONS DOESN'T WORK. !!!!!!
function grid:get(x, y, i)
	if not (x*y <= self.size-1 and x >= 0 and y >= 0) then error('Coordinates must be in grid.') end

	return self.grid[(y * self.rows + x)*2 + i + 1]
end

function grid:set(x, y, i, f)
	if not (x*y <= self.size-1 and x >= 0 and y >= 0) then error('Coordinates must be in grid.') end
	
	self.grid[(y * self.rows + x)*2 + i + 1] = f
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

function grid:iter()
	local i = -1

	return function()
		if not (i > self.size) then
			i = i + 1

			local y = math.floor(i/self.rows)
			local x = i - y * self.rows

			return x, y
		end
	end
end

function grid:rows_iter()
end

function grid:columns_iter()
end

return grid