--local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/FakeModz/PanjulHub-Script/refs/heads/main/UI')))()
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
--Roblox Client
--ReplicatedStorage = game:GetService("ReplicatedStorage")








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
local AutoCasting = false
local AutoReeling = false
local InstantBob = false
local AutoSelling = false

function NotifyHub(judulx, juduly)
OrionLib:MakeNotification({
	Name = judulx,
	Content = juduly,
	Image = "rbxassetid://4483345998",
	Time = 5
})
end


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
local DelayAutoSell = 5
local SellLoop = false

Items:AddToggle({
	Name = "Auto Sell",
	Default = false,
	Callback = function(Value)
        AutoSelling = Value
        if Value and not SellLoop then
        NotifyHub(" Auto Sell", "auto sell enable")
        SellLoop = true
        task.spawn(function()
	while SellLoop do
		task.wait(DelayAutoSell)
		if AutoSelling then
			pcall(function()
			game:GetService("ReplicatedStorage").events:WaitForChild("SellAll"):InvokeServer()
			end)
		end
	   end
	end) 
	elseif not Value then
	SellLoop = false
	NotifyHub("Auto Sell", "auto sell disable")
end
end
})


local SliderAutoSell = Items:AddSlider({
	Name = "Auto Sell Delay",
	Min = 1,
	Max = 120,
	Default = 5,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Auto Sell Delay",
	Callback = function(Value)
	DelayAutoSell = Value
	end    
})
SliderAutoSell:Set(1) 






--Misc
Misc:AddToggle({
	Name = "Anti Afk",
	Default = false,
	Callback = function(Value)
		print(Value)
	end    
})







OrionLib:Init()
