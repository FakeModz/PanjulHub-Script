local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()


local Window = OrionLib:MakeWindow({
Name = "Modz Hub | Fisch",
HidePremium = false,
SaveConfig = true,
ConfigFolder = "ModzHub"
})


--Hook
local ReplicatedStorage = game:GetService("ReplicatedStorage")



--Variable
local autoCast = false
local autoShake = false

--Function



--UI Design
local Tab = Window:MakeTab({
	Name = "Fishing",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddToggle({
	Name = "Auto Cast",
	Default = false,
	Callback = function(Value)

		end
	end
})

Tab:AddToggle({
	Name = "Auto Shake",
	Default = false,
	Callback = function(Value)
		
		end
	end
})

Tab:AddToggle({
	Name = "Sell All Fish",
	Default = false,
	Callback = function(Value)
    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SellAll")
		end
	end
})



OrionLib:Init()







