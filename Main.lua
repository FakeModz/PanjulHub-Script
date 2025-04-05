-- Rayfield Mobile V2 - Lengkap & Centered
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "Rayfield_MobileV2"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = game.CoreGui

-- Main Frame (Centered)
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0, 300, 0, 360)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.BorderSizePixel = 0
Main.Active = true

-- Touch Drag
local dragging, dragInput, dragStart, startPos
Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)
UIS.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch and dragging then
		local delta = input.Position - dragStart
		Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Title
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 32)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Text = "Rayfield Mobile UI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.BorderSizePixel = 0

-- Minimize Button
local MinBtn = Instance.new("TextButton", Main)
MinBtn.Size = UDim2.new(0, 26, 0, 26)
MinBtn.Position = UDim2.new(1, -30, 0, 3)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.SourceSansBold
MinBtn.TextSize = 20
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinBtn.BorderSizePixel = 0

-- Logo icon (appear saat minimize)
local Logo = Instance.new("ImageButton", Gui)
Logo.Size = UDim2.new(0, 48, 0, 48)
Logo.Position = UDim2.new(0.02, 0, 0.2, 0)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://7733960981" -- Ganti asset sesuai keinginan
Logo.Visible = false
Logo.MouseButton1Click:Connect(function()
	Main.Visible = true
	Logo.Visible = false
end)

-- Tab Container
local Tab = Instance.new("ScrollingFrame", Main)
Tab.Size = UDim2.new(1, -10, 1, -40)
Tab.Position = UDim2.new(0, 5, 0, 35)
Tab.CanvasSize = UDim2.new(0, 0, 0, 600)
Tab.ScrollBarThickness = 4
Tab.BackgroundTransparency = 1

-- Section
local function createSection(name, y)
	local Label = Instance.new("TextLabel", Tab)
	Label.Size = UDim2.new(1, 0, 0, 28)
	Label.Position = UDim2.new(0, 0, 0, y)
	Label.Text = name
	Label.TextColor3 = Color3.fromRGB(255, 255, 0)
	Label.Font = Enum.Font.GothamBold
	Label.TextSize = 18
	Label.BackgroundTransparency = 1
	return y + 32
end

-- Button
local function createButton(text, y, callback)
	local Btn = Instance.new("TextButton", Tab)
	Btn.Size = UDim2.new(1, 0, 0, 40)
	Btn.Position = UDim2.new(0, 0, 0, y)
	Btn.Text = text
	Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	Btn.Font = Enum.Font.Gotham
	Btn.TextSize = 16
	Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Btn.BorderSizePixel = 0
	Btn.MouseButton1Click:Connect(callback)
	return y + 44
end

-- Toggle (Slider Style)
local function createToggle(text, y, callback)
	local ToggleFrame = Instance.new("Frame", Tab)
	ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
	ToggleFrame.Position = UDim2.new(0, 0, 0, y)
	ToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	ToggleFrame.BorderSizePixel = 0

	local Label = Instance.new("TextLabel", ToggleFrame)
	Label.Size = UDim2.new(0.8, -10, 1, 0)
	Label.Position = UDim2.new(0, 10, 0, 0)
	Label.Text = text
	Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label.Font = Enum.Font.Gotham
	Label.TextSize = 16
	Label.BackgroundTransparency = 1

	local ToggleBtn = Instance.new("Frame", ToggleFrame)
	ToggleBtn.Size = UDim2.new(0, 40, 0, 20)
	ToggleBtn.Position = UDim2.new(1, -50, 0.5, -10)
	ToggleBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	ToggleBtn.BorderSizePixel = 0
	ToggleBtn.ClipsDescendants = true

	local Circle = Instance.new("Frame", ToggleBtn)
	Circle.Size = UDim2.new(0, 18, 0, 18)
	Circle.Position = UDim2.new(0, 1, 0, 1)
	Circle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
	Circle.BorderSizePixel = 0
	Circle.ZIndex = 2

	local state = false
	ToggleFrame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			state = not state
			local goalPos = state and UDim2.new(0, 21, 0, 1) or UDim2.new(0, 1, 0, 1)
			local color = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
			TweenService:Create(Circle, TweenInfo.new(0.2), {Position = goalPos, BackgroundColor3 = color}):Play()
			callback(state)
		end
	end)

	return y + 44
end

-- Isi UI
local y = 0
y = createSection("Control", y)
y = createButton("Cetak Halo", y, function() print("Halo!") end)
y = createToggle("Aktifkan Fitur", y, function(on) print("Toggle State:", on) end)

-- Minimize Function
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	Main.Visible = not minimized
	Logo.Visible = minimized
end)
