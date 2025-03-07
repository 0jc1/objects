
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Objects = require(script.Parent.Objects)

local objectData = Objects.objectData

local ObjectEvent = ReplicatedStorage.Events:WaitForChild("Objects")

--local Object = {__mode="v"}
local Object = {}
Object.__index = Object

--[[
    Constructor for the base class.
]]
function Object.new(instance: IntValue, objectName: string)
	local self = setmetatable({}, Object)

	-- Generate a unique ID
	self.id = HttpService:GenerateGUID(false)
	self.objectName = objectName
	
	self.instance = instance
	self.parent = instance.Parent

	if self.instance == nil then
		warn("instance is nil!")
	end

	for key, value in pairs(Objects.objectData[objectName]) do
		if self[key] == nil then
			self[key] = value
			self.instance:SetAttribute(key, value)
		end
	end

	Objects:AddObject(self)

	self.instance:SetAttribute("id", tostring(self.id))
	self.instance.Destroying:Connect(function()
		self:Cleanup()
	end)

	ObjectEvent:FireAllClients(0, {
		id = self.id,
		objectName = self.objectName
	}, self.instance)

	return self
end

function Object:Update(key, value)
	self[key] = value
	self.instance:SetAttribute(key, value)

	ObjectEvent:FireAllClients(0, {
		id = self.id,
		objectName = self.objectName
	}, self.instance)

end

function Object:GetState(): string
	return tostring(self.instance.Value)
end

--[[
    Called when the object is about to be removed. 
    Removes it from the Objects registry and destroys the Roblox instance if present.
]]
function Object:Destroy()

	-- Destroy the Roblox instance if it still exists
	if self.instance then
		self.instance:Destroy()
	end

	self.instance = nil
end

function Object:Cleanup()
	Objects:RemoveObject(self.id)

	ObjectEvent:FireAllClients(1, {
		id = self.id,
	})
end

return Object