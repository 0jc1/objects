
local actions = game.ReplicatedStorage:WaitForChild("actions")

local Objects = {}
Objects.__index = Objects

-- This table will map unique IDs to object instances
Objects.objects = {}

Objects.objectData = require(script.Parent:WaitForChild("ObjectData"))

--[[
    Retrieves an object from the registry by its unique ID.
]]
function Objects:GetObject(id: string)
	return Objects.objects[id] 
end

--[[
    Registers an object with a unique ID into the registry.
]]
function Objects:AddObject(obj: any)
	if obj.id then
		Objects.objects[obj.id] = obj
	else
		warn("Attempted to add an object without an 'id' property.")
	end
end

--[[
    Removes an object from the registry by its unique ID.
]]
function Objects:RemoveObject(id: string)
	Objects.objects[id] = nil
end

return Objects

