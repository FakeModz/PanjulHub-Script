local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()


local Window = OrionLib:MakeWindow({
Name = "Modz Hub | Fisch",
HidePremium = false,
SaveConfig = true,
ConfigFolder = "ModzHub"
})

local autoCast = false
local autoShake = false

--Function
function AutoCasts()
while AutoCasting do
            local player = game.Players.LocalPlayer
            local character = player.Character

            if character then
                local tool = character:FindFirstChildOfClass("Tool")

                if tool then
                    local hasBobber = tool:FindFirstChild("bobber")

                    if not hasBobber then
                        local castEvent = tool:FindFirstChild("events") and tool.events:FindFirstChild("cast")

                        if castEvent then
                            local Random = math.random() * (99 - 90) + 90
                            local FRandom = string.format("%.4f", Random)
                            print(FRandom)
                            
                            local Random2 = math.random(90, 99)
                            castEvent:FireServer(Random2)

                            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                            if humanoidRootPart then
                                humanoidRootPart.Anchored = false
                            end
                        end
                    end
                end
                task.wait(1)
            end
        end
    end)
end


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
		autoCast = Value
		while autoCast do
			pcall(function()
				game:GetService("ReplicatedStorage").Remotes.Fishing:FireServer("Cast")
			end)
			wait(1)
		end
	end
})

Tab:AddToggle({
	Name = "Auto Shake",
	Default = false,
	Callback = function(Value)
		autoShake = Value
		while autoShake do
			pcall(function()
				-- Ganti "ShakeRod" dengan nama remote yang benar jika berbeda
				game:GetService("ReplicatedStorage").Remotes.ShakeRod:FireServer()
			end)
			wait(0.2) -- jeda antar shake, bisa disesuaikan
		end
	end
})



OrionLib:Init()







