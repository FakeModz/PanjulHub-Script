-- Custom Mobile-Friendly Rayfield UI
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- GUI container
local Gui = Instance.new("ScreenGui", game.CoreGui)
Gui.Name = "Rayfield_Mobile"
Gui.ResetOnSpawn = false

-- Main frame
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0, 300, 0, 360)
Main.Position = UDim2.new(0.5, -150, 0.5, -180)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.BorderSizePixel = 0
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Active = true
Main.Draggable = false

-- Title
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 32)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Text = "Rayfield Custom UI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.BorderSizePixel = 0

-- Minimize button
local MinBtn = Instance.new("TextButton", Main)
MinBtn.Size = UDim2.new(0, 26, 0, 26)
MinBtn.Position = UDim2.new(1, -30, 0, 3)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.SourceSansBold
MinBtn.TextSize = 20
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinBtn.BorderSizePixel = 0

-- Container for tabs & content
local TabContainer = Instance.new("Frame", Main)
TabContainer.Size = UDim2.new(1, -10, 1, -40)
TabContainer.Position = UDim2.new(0, 5, 0, 35)
TabContainer.BackgroundTransparency = 1

-- Example tab (add more tabs if needed)
local Tab = Instance.new("ScrollingFrame", TabContainer)
Tab.Size = UDim2.new(1, 0, 1, 0)
Tab.CanvasSize = UDim2.new(0, 0, 0, 500)
Tab.ScrollBarThickness = 4
Tab.BackgroundTransparency = 1
Tab.Name = "MainTab"

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

-- Toggle
local function createToggle(text, y, callback)
	local Toggle = Instance.new("TextButton", Tab)
	Toggle.Size = UDim2.new(1, 0, 0, 40)
	Toggle.Position = UDim2.new(0, 0, 0, y)
	Toggle.Text = "[ OFF ] " .. text
	Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	Toggle.Font = Enum.Font.Gotham
	Toggle.TextSize = 16
	Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Toggle.BorderSizePixel = 0
	local state = false
	Toggle.MouseButton1Click:Connect(function()
		state = not state
		Toggle.Text = state and "[ ON ] " .. text or "[ OFF ] " .. text
		callback(state)
	end)
	return y + 44
end

-- Slider
local function createSlider(label, y, min, max, callback)
	local Title = Instance.new("TextLabel", Tab)
	Title.Size = UDim2.new(1, 0, 0, 24)
	Title.Position = UDim2.new(0, 0, 0, y)
	Title.Text = label
	Title.TextColor3 = Color3.fromRGB(200, 200, 200)
	Title.Font = Enum.Font.Gotham
	Title.TextSize = 14
	Title.BackgroundTransparency = 1

	local Slide = Instance.new("TextButton", Tab)
	Slide.Size = UDim2.new(1, 0, 0, 20)
	Slide.Position = UDim2.new(0, 0, 0, y + 24)
	Slide.Text = "0"
	Slide.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	Slide.TextColor3 = Color3.fromRGB(255, 255, 255)
	Slide.Font = Enum.Font.Gotham
	Slide.TextSize = 14

	local value = min
	Slide.MouseButton1Click:Connect(function()
		value = value + 1
		if value > max then value = min end
		Slide.Text = tostring(value)
		callback(value)
	end)

	return y + 52
end

-- Dropdown
local function createDropdown(label, options, y, callback)
	local Dropdown = Instance.new("TextButton", Tab)
	Dropdown.Size = UDim2.new(1, 0, 0, 40)
	Dropdown.Position = UDim2.new(0, 0, 0, y)
	Dropdown.Text = label .. " ▼"
	Dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
	Dropdown.Font = Enum.Font.Gotham
	Dropdown.TextSize = 16
	Dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Dropdown.BorderSizePixel = 0

	local open = false
	local items = {}

	Dropdown.MouseButton1Click:Connect(function()
		open = not open
		for _, item in ipairs(items) do
			item.Visible = open
		end
	end)

	local oy = y + 44
	for _, opt in ipairs(options) do
		local Opt = Instance.new("TextButton", Tab)
		Opt.Size = UDim2.new(1, 0, 0, 36)
		Opt.Position = UDim2.new(0, 0, 0, oy)
		Opt.Text = "  - " .. opt
		Opt.TextColor3 = Color3.fromRGB(200, 200, 200)
		Opt.Font = Enum.Font.Gotham
		Opt.TextSize = 15
		Opt.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		Opt.Visible = false
		Opt.BorderSizePixel = 0
		Opt.MouseButton1Click:Connect(function()
			callback(opt)
			for _, b in ipairs(items) do b.Visible = false end
			open = false
			Dropdown.Text = label .. " ▼"
		end)
		table.insert(items, Opt)
		oy += 36
	end

	return oy
end

-- Textbox
local function createTextbox(label, y, callback)
	local Box = Instance.new("TextBox", Tab)
	Box.Size = UDim2.new(1, 0, 0, 36)
	Box.Position = UDim2.new(0, 0, 0, y)
	Box.PlaceholderText = label
	Box.Text = ""
	Box.TextColor3 = Color3.fromRGB(255, 255, 255)
	Box.Font = Enum.Font.Gotham
	Box.TextSize = 16
	Box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Box.BorderSizePixel = 0
	Box.FocusLost:Connect(function(enter)
		if enter then callback(Box.Text) end
	end)
	return y + 40
end

-- Example UI content
local y = 0
y = createSection("Main Controls", y)
y = createButton("Klik Saya", y, function() print("Tombol ditekan!") end)
y = createToggle("Aktifkan Mode", y, function(state) print("Toggle:", state) end)
y = createSlider("Volume", y, 0, 10, function(val) print("Slider:", val) end)
y = createDropdown("Pilih Item", {"Apple", "Banana", "Cherry"}, y, function(opt) print("Dipilih:", opt) end)
y = createTextbox("Masukkan Nama", y, function(text) print("Nama:", text) end)

-- Touch Drag Support
local dragging = false
local dragStart, startPos

Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

Main.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		UIS.InputChanged:Connect(function(moveInput)
			if moveInput == input and dragging then
				local delta = moveInput.Position - dragStart
				Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
					startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end
		end)
	end
end)

-- Minimize logic
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	Tab.Visible = not minimized
	MinBtn.Text = minimized and "+" or "-"
end)
