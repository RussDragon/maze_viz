local make_grid = require 'grid.grid'
local type, math_random = type, math.random

local make_binarytree_gen
do
  local step = function(self)
    local x, y, grid = self._x, self._y, self._grid

    if y ~= 0 then
      if math_random(0, 1) == 1 and x ~= self._w - 1 then
        grid:setr(x, y, false)
      else
        grid:setb(x, y - 1, false)
      end
    else
      if x ~= self._w - 1 then
        grid:setr(x, y, false)
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
    local grid_iter = self._grid:iter()

    return function()
      self._x, self._y = grid_iter()

      if self._x and self._y then
        self._grid:set_cursor(self._x, self._y)
        self:step()
      end
    end
  end

  local get_grid = function(self)
    return self._grid
  end

  make_binarytree_gen = function(rows, columns)
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
    }
  end
end

return make_binarytree_gen
