--local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/FakeModz/PanjulHub-Script/refs/heads/main/UI')))()
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
--Roblox Client
ReplicatedStorage = game:GetService("ReplicatedStorage")








local Window = OrionLib:MakeWindow({Name = "Panjul Hub | Fisch", HidePremium = false, SaveConfig = true, ConfigFolder = "PanjulHubZ"})



local Fishing = Window:MakeTab({
	Name = "Fishing",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Items = Window:MakeTab({
	Name = "Items",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Misc = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Teleport = Window:MakeTab({
	Name = "Teleport",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})




--Variable
--local AutoCasting = false
--local AutoReeling = false
--local InstantBob = false
--local AutoSelling = false



--Fishing
Fishing:AddToggle({
	Name = "Auto Cast",
	Default = false,
	Callback = function(Value)
		print(Value)
	end    
})

Fishing:AddToggle({
	Name = "Auto Reel",
	Default = false,
	Callback = function(Value)
		print(Value)
	end    
})

Fishing:AddToggle({
	Name = "Instant Bobber",
	Default = false,
	Callback = function(Value)
		print(Value)
	end    
})

--Items

Items:AddToggle({
	Name = "Auto Sell",
	Default = false,
	Callback = function(Value)
    ReplicatedStorage.events:WaitForChild("SellAll"):InvokeServer()
	end    
})



--Misc
Misc:AddToggle({
	Name = "Anti Afk",
	Default = false,
	Callback = function(Value)
		print(Value)
	end    
})







OrionLib:Init()
