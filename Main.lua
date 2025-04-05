-- Modz Hub Mobile UI - Full Customizable
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Gui = Instance.new("ScreenGui", game.CoreGui)
Gui.Name = "ModzHubUI"
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.ResetOnSpawn = false

-- Main UI
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0, 360, 0, 300)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = false

-- Drag support mobile
local dragging, startPos, startInput
Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		startPos = input.Position
		startInput = Main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)
UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.Touch then
		local delta = input.Position - startPos
		Main.Position = UDim2.new(startInput.X.Scale, startInput.X.Offset + delta.X, startInput.Y.Scale, startInput.Y.Offset + delta.Y)
	end
end)

-- Header
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 36)
Header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Header.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Modz Hub | Fisch"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Minimize & Close
local MinBtn = Instance.new("TextButton", Header)
MinBtn.Size = UDim2.new(0, 32, 0, 32)
MinBtn.Position = UDim2.new(1, -70, 0, 2)
MinBtn.Text = "-"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 20
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MinBtn.BorderSizePixel = 0

local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -35, 0, 2)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
CloseBtn.BorderSizePixel = 0

CloseBtn.MouseButton1Click:Connect(function()
	Gui:Destroy()
end)

-- Sidebar
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 100, 1, -36)
Sidebar.Position = UDim2.new(0, 0, 0, 36)
Sidebar.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
Sidebar.BorderSizePixel = 0

-- Content area
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -100, 1, -36)
Content.Position = UDim2.new(0, 100, 0, 36)
Content.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Content.BorderSizePixel = 0

-- Placeholder tab: Fishing
local FishingTab = Instance.new("TextButton", Sidebar)
FishingTab.Size = UDim2.new(1, 0, 0, 36)
FishingTab.Text = "Fishing"
FishingTab.Font = Enum.Font.Gotham
FishingTab.TextColor3 = Color3.fromRGB(255, 255, 255)
FishingTab.TextSize = 14
FishingTab.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
FishingTab.BorderSizePixel = 0

-- Content inside tab
local AutoCastLabel = Instance.new("TextLabel", Content)
AutoCastLabel.Size = UDim2.new(0, 100, 0, 30)
AutoCastLabel.Position = UDim2.new(0, 20, 0, 20)
AutoCastLabel.Text = "Auto Cast"
AutoCastLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoCastLabel.Font = Enum.Font.Gotham
AutoCastLabel.TextSize = 16
AutoCastLabel.BackgroundTransparency = 1
AutoCastLabel.TextXAlignment = Enum.TextXAlignment.Left

local ToggleBack = Instance.new("Frame", Content)
ToggleBack.Size = UDim2.new(0, 50, 0, 24)
ToggleBack.Position = UDim2.new(0, 140, 0, 22)
ToggleBack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleBack.BorderSizePixel = 0

local ToggleBall = Instance.new("Frame", ToggleBack)
ToggleBall.Size = UDim2.new(0, 20, 0, 20)
ToggleBall.Position = UDim2.new(0, 2, 0, 2)
ToggleBall.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ToggleBall.BorderSizePixel = 0
ToggleBall.ZIndex = 2

local toggleState = false
ToggleBack.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		toggleState = not toggleState
		local pos = toggleState and UDim2.new(0, 28, 0, 2) or UDim2.new(0, 2, 0, 2)
		local col = toggleState and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
		TweenService:Create(ToggleBall, TweenInfo.new(0.2), {
			Position = pos,
			BackgroundColor3 = col
		}):Play()
	end
end)

-- Minimize
local IconBtn = Instance.new("ImageButton", Gui)
IconBtn.Image = "rbxassetid://7733960981"
IconBtn.Size = UDim2.new(0, 50, 0, 50)
IconBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
IconBtn.BackgroundTransparency = 1
IconBtn.Visible = false

MinBtn.MouseButton1Click:Connect(function()
	Main.Visible = false
	IconBtn.Visible = true
end)

IconBtn.MouseButton1Click:Connect(function()
	Main.Visible = true
	IconBtn.Visible = false
end)
