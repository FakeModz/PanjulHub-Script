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
	Name = "Sell All Fish",
	Default = false,
	Callback = function(Value)
    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SellAll"):FireServer()
	end
})



OrionLib:Init()







