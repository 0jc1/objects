local Object = require(script.Parent.Object)
local Debris = game:GetService("Debris")

local Door = {}
Door.__index = Door
setmetatable(Door, Object)

function Door.new(instance: IntValue)
	local self = Object.new(instance, script.Name)
	setmetatable(self, Door)
	
	return self
end


Door["Interact"] = function(self, data)

end

Door["Lock"] = function(self, data)

end

Door["Unlock"] = function(self, data)

end

Door["Knock"] = function(self, data)

end

Door["Lockpick"] = function(self, data)

end

return Door
