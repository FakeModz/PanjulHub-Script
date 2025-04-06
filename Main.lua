--local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/FakeModz/PanjulHub-Script/refs/heads/main/UI')))()
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
--Roblox Client
--ReplicatedStorage = game:GetService("ReplicatedStorage")








local Window = OrionLib:MakeWindow({Name = "Panjul Hub | Fisch", HidePremium = false, SaveConfig = true, ConfigFolder = "PanjulHubZ"})

local GuiService = game:GetService("GuiService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RepliStorage = game:GetService("ReplicatedStorage")


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
		AutoCasting = Value -- boolean global

		if AutoCasting then
			task.spawn(function()
				while AutoCasting do
					local player = game.Players.LocalPlayer
					local character = player.Character

					if character then
						local tool = character:FindFirstChildOfClass("Tool")
						if tool and not tool:FindFirstChild("bobber") then
							local castEvent = tool:FindFirstChild("events") and tool.events:FindFirstChild("cast")
							if castEvent then
								local power = math.random(90, 99)
								castEvent:FireServer(power)

								local root = character:FindFirstChild("HumanoidRootPart")
								if root then
									root.Anchored = false
								end
							end
						end
					end

					task.wait(0.5) -- delay antar cast
				end
			end)
		end
	end
})

local autoShake = false
local shakeLoop = false

Fishing:AddToggle({
	Name = "Auto Shake",
	Default = false,
	Callback = function(Value)
		autoShake = Value
		--local VirtualInputManager = game:GetService("VirtualInputManager")
		if autoShake and not shakeLoop then
			shakeLoop = true
			task.spawn(function()
				while autoShake do
					task.wait(autoShakeDelay or 0.5)
					local PlayerGUI = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
					local shakeUI = PlayerGUI:FindFirstChild("shakeui")
					if shakeUI and shakeUI.Enabled then
						local safezone = shakeUI:FindFirstChild("safezone")
						local Connect = safezone:WaitForChild("connect", 1)
                	if Connect then
					Connect.Enabled = false -- this script locks the size of the safezone, so we disable it.
				end
						if safezone then
						safezone.Size = UDim2.fromOffset(0, 0)
			        	safezone.Position = UDim2.fromScale(0.5, 0.5)
			        	safezone.AnchorPoint = Vector2.new(0.5, 0.5)
		             	local button = safezone:FindFirstChild("button")
							if button and button:IsA("ImageButton") and button.Visible then
								local pos = safezone.AbsolutePosition
								local size = safezone.AbsoluteSize
								VirtualInputManager:SendMouseButtonEvent(pos.X + size.X, pos.Y + size.Y, 0, true, game:GetService("Players").LocalPlayer, 0)
                                VirtualInputManager:SendMouseButtonEvent(pos.X + size.X, pos.Y + size.Y, 0, false, game:GetService("Players").LocalPlayer, 0)
										task.wait(1) 
							end
						end
					end
				end
				shakeLoop = false
			end)
		end
	end
})



Fishing:AddToggle({
	Name = "Center Shake",
	Default = false,
	Callback = function(Value)
print(value)    
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
	Min = 0,
	Max = 20,
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
