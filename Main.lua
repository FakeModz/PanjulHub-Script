--local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/FakeModz/PanjulHub-Script/refs/heads/main/UI')))()
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
--Roblox Client
--ReplicatedStorage = game:GetService("ReplicatedStorage")








local Window = OrionLib:MakeWindow({Name = "Panjul Hub | Fisch", HidePremium = false, SaveConfig = true, ConfigFolder = "PanjulHubZ"})

local GuiService = game:GetService("GuiService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RepliStorage = game:GetService("ReplicatedStorage")
	local HttpService = game:GetService("HttpService")
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
--	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local TweenService = game:GetService("TweenService")
	local VirtualInputManager = Instance.new("VirtualInputManager") -- fak u
	local VirtualUser = game:GetService("VirtualUser")
	local StarterGui = game:GetService("StarterGui")
	local CoreGui = game:GetService("CoreGui")
--	local GuiService = game:GetService("GuiService")
	local CollectionService = game:GetService("CollectionService")
	local UserInputService = game:GetService("UserInputService")
	local Lighting = game:GetService("Lighting")
	local CorePackages = game:GetService("CorePackages")
	local VeryImportantPart = Instance.new("Part") -- fake zone for tricking temperature/oxygen scripts

local LocalPlayer = Players.LocalPlayer
local Utils = {}
--local CurrentTool: Tool? 
	

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

					task.wait(0.1) -- delay antar cast
				end
			end)
		end
	end
})










local AutoShakeV2 = false
local AutoShakeConnection

Fishing:AddToggle({
	Name = "Auto Shake",
	Default = false,
	Callback = function(Value)
		AutoShakeV2 = Value

		if Value then
			if AutoShakeConnection then AutoShakeConnection:Disconnect() end

			local function MountShakeUI(ShakeUI)
				local SafeZone = ShakeUI:WaitForChild("safezone", 5)
				if not SafeZone then
					warn("Unable to mount shake UI.")
					return
				end

				-- Pusatkan tombol shake
				local Connect = SafeZone:WaitForChild("connect", 1)
				if Connect then
					Connect.Enabled = false
				end
				SafeZone.Size = UDim2.fromOffset(0, 0)
				SafeZone.Position = UDim2.fromScale(0.5, 0.5)
				SafeZone.AnchorPoint = Vector2.new(0.5, 0.5)

				local function HandleButton(Button)
					Button.Selectable = true
					GuiService.SelectedObject = Button
				end

				local Connection
				Connection = SafeZone.ChildAdded:Connect(function(Child)
					if not Child:IsA("ImageButton") then return end

					local Done = false

					task.spawn(function()
						repeat
							RunService.Heartbeat:Wait()
							HandleButton(Child)
						until Done
					end)

					task.spawn(function()
						repeat RunService.Heartbeat:Wait()
						until not Child:IsDescendantOf(SafeZone)
						Done = true
					end)
				end)

				task.spawn(function()
					repeat
						RunService.Heartbeat:Wait()
						if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(SafeZone) then
							VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
							VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
						end
					until not SafeZone:IsDescendantOf(LocalPlayer.PlayerGui) or not AutoShakeV2
					Connection:Disconnect()
					GuiService.SelectedObject = nil
				end)
			end

			AutoShakeConnection = LocalPlayer.PlayerGui.ChildAdded:Connect(function(Child)
				if Child.Name == "shakeui" and Child:IsA("ScreenGui") then
					MountShakeUI(Child)
				end
			end)

			local existing = LocalPlayer.PlayerGui:FindFirstChild("shakeui")
			if existing then
				MountShakeUI(existing)
			end
		else
			if AutoShakeConnection then
				AutoShakeConnection:Disconnect()
				AutoShakeConnection = nil
			end
			GuiService.SelectedObject = nil
		end
	end
})




local InstantReelRunning = false
local InstantReelCoroutine

local ReelFinished = game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("reelfinished ")

Fishing:AddToggle({
	Name = "Instant Reel",
	Default = false,
	Callback = function(Value)
		InstantReelRunning = Value

		if Value and not InstantReelCoroutine then
			InstantReelCoroutine = coroutine.create(function()
				while InstantReelRunning do
					RunService.RenderStepped:Wait()

					local ReelUI = LocalPlayer.PlayerGui:FindFirstChild("reel")
					if not ReelUI then continue end

					local Bar = ReelUI:FindFirstChild("bar")
					Bar.Visible = false
					if not Bar then continue end

					local ReelScript = Bar:FindFirstChild("reel")
					if ReelScript and ReelScript.Enabled then
					local player = game.Players.LocalPlayer
					local character = player.Character
					local tool = character:FindFirstChildOfClass("Tool")
					local castEvent = tool:FindFirstChild("events") and tool.events:FindFirstChild("cast") 
					game:GetService("Players").LocalPlayer.Character:FindFirstChild(tool).events.reset:FireServer()
                     task.wait(0.3) 
                     ReelFinished:FireServer(100)
					end
				end

				-- Bersihkan saat loop selesai
				InstantReelCoroutine = nil
			end)

			coroutine.resume(InstantReelCoroutine)
		end
	end
})


local InstantBobConnection

Fishing:AddToggle({
	Name = "Instant Bobber",
	Default = false,
	Callback = function(Value)
		if Value then
			InstantBobConnection = RunService.Heartbeat:Connect(function()
				local Character = LocalPlayer.Character
				if not Character then return end

				local Tool = Character:FindFirstChildOfClass("Tool")
				if Tool then
					local Bobber = Tool:FindFirstChild("bobber")
					if Bobber then
						local Params = RaycastParams.new()
						Params.FilterType = Enum.RaycastFilterType.Include
						Params.FilterDescendantsInstances = { workspace.Terrain }

						local RayResult = workspace:Raycast(Bobber.Position, Vector3.new(0, -10, 0), Params)
						if RayResult and RayResult.Instance:IsA("Terrain") then
							Bobber:PivotTo(CFrame.new(RayResult.Position))
						end
					end
				end
			end)
		elseif InstantBobConnection then
			InstantBobConnection:Disconnect()
			InstantBobConnection = nil
		end
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
