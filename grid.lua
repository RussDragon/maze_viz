local class = {}
local aux = {}

class.__index = class

class.new = function(rows, columns, is_wall_opened) 
	if not rows or not columns then error("Can not create grid. Rows and columns must be specified.") end
	
end