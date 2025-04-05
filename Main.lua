local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()


local Window = OrionLib:MakeWindow({
Name = "Modz Hub | Fisch",
HidePremium = false,
SaveConfig = true,
ConfigFolder = "ModzHub"
})

local Tab = Window:MakeTab({
	Name = "Fishing",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddToggle({
	Name = "Auto Cast",
	Default = false,
	Callback = function(Value)
		print(Value)
	end    
})


OrionLib:Init()







