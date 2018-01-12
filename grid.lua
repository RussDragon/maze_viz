local error, setmetatable = error, setmetatable

-------------------------------------------------------------------------------

local make_grid
do
	local calc_pos = function(self, x, y)
		return (y * self._rows + x) + 1
	end

	local get = function(self, x, y, i)
		if not (x * y <= self._size - 1 and x >= 0 and y >= 0) then error('Coordinates must be in grid.') end

		return self._grid[calc_pos(self, x, y) * 2 + i]
	end

	local set = function(self, x, y, i, f)
		if not (x * y <= self._size-1 and x >= 0 and y >= 0) then error('Coordinates must be in grid.') end
		
		self._grid[calc_pos(self, x, y) * 2 + i] = f
		return true
	end

	local getrb = function(self, x, y)
		return self:get(x, y, 0), self:get(x, y, 1)
	end

	local getr = function(self, x, y)
		return self:get(x, y, 0)
	end

	local getb = function(self, x, y)
		return self:get(x, y, 1)
	end

	local setrb = function(self, x, y, r, b)
		self:set(x, y, 0, r)
		self:set(x, y, 1, b)

		return true
	end

	local setr = function(self, x, y, r)
		self:set(x, y, 0, r)

		return true
	end

	local setb = function(self, x, y, b)
		self:set(x, y, 1, b)

		return true
	end

	local get_attachment = function(self, x, y)
		-- print(x, y)
		return self._attachments[calc_pos(self, x, y)]
	end

	local set_attachment = function(self, x, y, data)
		self._attachments[calc_pos(self, x, y)] = data or false
		
		return true
	end

	local get_height = function(self)
		return self._rows
	end

	local get_width = function(self)
		return self._columns
	end

	local is_highlighted = function(self, x, y)
		return (self._highlighted.x == x and self._highlighted.y == y) or false
	end

	local set_highlight = function(self, x, y)
		self._highlighted.x, self._highlighted.y = x, y
	end

	-- Left to right, up to down
	local iter = function(self)
		local i = -1

		return function()
			if i < self._size then
				i = i + 1

				local y = math.floor(i/self._rows)
				local x = i - y * self._rows

				return x, y
			end
		end
	end

	make_grid = function(rows, columns, walls_mode, attach) 
		-- walls_mode – is walls enabled

		if not rows or not columns then error('Can not create a grid. Rows and columns must be specified.') end
		if rows <= 1 or columns <= 1 then 
			error('Rows and columns must be greater than 1. Minimal size of a grid is 2x2.') 
		end

		local walls_mode = not not walls_mode

		local grid = {}
		local size = rows * columns
		
		-- RIGHT WALL IS ALWAYS FIRST, BOTTOM WALL IS ALWAYS SECOND.
		for i = 1, size * 2 do
			grid[i] = walls_mode
		end

		if attach then 
			attachments = {}

			for i = 1, size do
				attachments[i] = attach
			end
		end

		return 
		{
			get = get;
			getrb = getrb;
			getr = getr;
			getb = getb;
			get_height = get_height;
			get_width = get_width;

			set = set;
			setrb = setrb;
			setr = setr;
			setb = setb;

			set_attachment = set_attachment;
			get_attachment = get_attachment;

			is_highlighted = is_highlighted;
			set_highlight = set_highlight;

			iter = iter;

			_rows = rows;
			_columns = columns;
			_size = size;
			_attachments = attachments;
			_grid = grid;
			_highlighted = { x = false; y = false; };
		}
	end
end

return make_grid
