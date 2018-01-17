local make_grid = require 'grid.grid'
local type, math_random, table_insert, table_remove = 
      type, math.random, table.insert, table.remove

-------------------------------------------------------------------------------

local shuffle_table = function(t)
  for i = #t, 2, -1 do
      local j = math_random(i)
      t[i], t[j] = t[j], t[i]
  end
end

local get_unvisited = function(self)
  local dirs = {}
  local x, y, grid = self._x, self._y, self._grid

  if y - 1 >= 0 and not grid:get_attachment(x, y - 1).visited then
    dirs[#dirs + 1] = "up"
  end

  if y + 1 < self._h and not grid:get_attachment(x, y + 1).visited then
    dirs[#dirs + 1] =  "down"
  end

  if x - 1 >= 0 and not grid:get_attachment(x - 1, y).visited then
    dirs[#dirs + 1] = "left"
  end

  if x + 1 < self._w and not grid:get_attachment(x + 1, y).visited then
    dirs[#dirs + 1] = "right"
  end

  shuffle_table(dirs)
  return (#dirs > 0) and dirs or nil
end

-------------------------------------------------------------------------------

local make_backtracking_gen
do
  local step = function(self)
    local dirs = {}
    local x, y, grid, dir_stack = self._x, self._y, self._grid, self._dir_stack

    grid:set_attachment(x, y, {visited = true})

    if get_unvisited(self) then
      dirs = get_unvisited(self)
      if #get_unvisited(self) > 1 then
        table_insert(dir_stack, {x = x, y = y})
      end
    else
      if #dir_stack > 0 then
        while #dir_stack > 0 do
          local value = table_remove(dir_stack)
          x, y = value.x, value.y
          self._x, self._y = x, y

          if get_unvisited(self) then
            dirs = get_unvisited(self)
            break
          end
        end
      else
        return true
      end
    end

    local dir = table_remove(dirs)

    if dir == "up" and not grid:get_attachment(x, y - 1).visited then
      grid:setb(x, y - 1, false)
      y, x = y - 1, x
    elseif dir == "down" and not grid:get_attachment(x, y + 1).visited then
      grid:setb(x, y, false)
      y, x = y + 1, x
    elseif dir == "left" and not grid:get_attachment(x - 1, y).visited then
      grid:setr(x - 1, y, false)
      y, x = y, x - 1
    elseif dir == "right" and not grid:get_attachment(x + 1, y).visited then
      grid:setr(x, y, false)
      y, x = y, x + 1
    end

    self._x, self._y = x, y
  end

  local generate = function(self)
    while true do
      local is_finished = self:step()
      if is_finished then break end
    end
  end

  local iter = function(self)
    local is_finished = false
    return function()
      if is_finished then return false end
      is_finished = self:step()
    end
  end

  local get_grid = function(self)
    return self._grid
  end

  make_backtracking_gen = function(rows, columns)
    return 
    {
      step = step;
      generate = generate;
      iter = iter;
      get_grid = get_grid;

      _grid = make_grid(rows, columns, true, {});
      _h = columns;
      _w = rows;
      _x = 0;
      _y = 0;
      _dir_stack = {}; -- Stack for caching cells with unvisited neighbors
    }
  end
end

return make_backtracking_gen
