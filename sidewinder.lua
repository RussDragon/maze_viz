local make_grid = require 'grid.grid'
local type, math_random = type, math.random

local make_sidewinder_gen
do
  local step = function(self)
    local x, y, grid = self._x, self._y, self._grid

    if y ~= 0 then
      if math.random(0, 1) == 0 and x ~= self._w - 1 then
        self._grid:setr(x, y, false)
      else 
        self._grid:setb(math_random(self._curx, x), y - 1, false)

        if x ~= self._w - 1 then self._curx = x + 1 else self._curx = 0 end
      end

    else 
      if self._x ~= self._w - 1 then 
        self._grid:setr(x, y, false)
      end
    end
  end

  local generate = function(self)
    for x, y in self._grid:iter() do
      self._x, self._y = x, y
      self:step()
    end
  end

  local iter = function(self)
  end

  local get_grid = function(self)
    return self._grid
  end

  make_sidewinder_gen = function(rows, columns)
    return 
    {
      step = step;
      generate = generate;
      iter = iter;
      get_grid = get_grid;

      _grid = make_grid(rows, columns, true, false);
      _h = columns;
      _w = rows;
      _x = false;
      _y = false;
      _curx = 0;
    }
  end
end

return make_sidewinder_gen
