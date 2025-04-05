-- ModzHub Library UI (Modular Style + Control Buttons)
-- Gunakan fungsi `CreateWindow()` dan `CreateTab()` dari sini

local ModzHub = {}
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local DEFAULT_WIDTH = 400

-- Drag Function
local function enableDrag(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- CreateWindow(options)
function ModzHub:CreateWindow(config)
    config = config or {}
    local title = config.Title or "Modz Hub"
    local width = config.Width or DEFAULT_WIDTH

    -- UI Holder
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ModzHubUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    ScreenGui.Parent = CoreGui

    -- Main Frame
    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, width, 0, 300)
    Main.Position = UDim2.new(0.5, -width/2, 0.5, -150)
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Main.BorderSizePixel = 0
    Main.Name = "Main"
    Main.AnchorPoint = Vector2.new(0, 0)
    Main.Parent = ScreenGui
    Main.Visible = true

    -- Minimized Icon
    local MinimizedIcon = Instance.new("ImageButton")
    MinimizedIcon.Size = UDim2.new(0, 40, 0, 40)
    MinimizedIcon.Position = UDim2.new(0.5, -20, 0.5, -20)
    MinimizedIcon.Image = "rbxasset://textures/IconRoblox.png"
    MinimizedIcon.BackgroundTransparency = 1
    MinimizedIcon.Visible = false
    MinimizedIcon.Parent = ScreenGui
    enableDrag(MinimizedIcon)

    -- Title Bar
    local TitleBar = Instance.new("TextLabel")
    TitleBar.Size = UDim2.new(1, -100, 0, 40)
    TitleBar.Position = UDim2.new(0, 10, 0, 0)
    TitleBar.BackgroundTransparency = 1
    TitleBar.Text = title
    TitleBar.TextSize = 18
    TitleBar.Font = Enum.Font.GothamBold
    TitleBar.TextColor3 = Color3.fromRGB(255,255,255)
    TitleBar.TextXAlignment = Enum.TextXAlignment.Left
    TitleBar.Parent = Main

    -- Control Buttons
    local function createButton(txt, pos, cb)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(0, 30, 0, 30)
        Btn.Position = pos
        Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Btn.Text = txt
        Btn.TextColor3 = Color3.fromRGB(255,255,255)
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 14
        Btn.Parent = Main
        Btn.MouseButton1Click:Connect(cb)
        return Btn
    end

    local MinBtn = createButton("-", UDim2.new(1, -70, 0, 5), function()
        Main.Visible = false
        MinimizedIcon.Visible = true
    end)

    local ExitBtn = createButton("X", UDim2.new(1, -35, 0, 5), function()
        ScreenGui:Destroy()
    end)

    MinimizedIcon.MouseButton1Click:Connect(function()
        Main.Visible = true
        MinimizedIcon.Visible = false
    end)

    -- Content Area
    local TabHolder = Instance.new("Frame")
    TabHolder.Name = "TabHolder"
    TabHolder.Size = UDim2.new(1, 0, 1, -40)
    TabHolder.Position = UDim2.new(0, 0, 0, 40)
    TabHolder.BackgroundTransparency = 1
    TabHolder.Parent = Main

    return {
        CreateTab = function(_, tabName)
            local TabFrame = Instance.new("Frame")
            TabFrame.Name = tabName or "Tab"
            TabFrame.BackgroundTransparency = 1
            TabFrame.Size = UDim2.new(1, 0, 1, 0)
            TabFrame.Parent = TabHolder

            local Layout = Instance.new("UIListLayout", TabFrame)
            Layout.Padding = UDim.new(0, 5)
            Layout.FillDirection = Enum.FillDirection.Vertical
            Layout.SortOrder = Enum.SortOrder.LayoutOrder

            return {
                AddToggle = function(_, label, default, callback)
                    local Holder = Instance.new("Frame", TabFrame)
                    Holder.Size = UDim2.new(1, -20, 0, 30)
                    Holder.BackgroundTransparency = 1

                    local Label = Instance.new("TextLabel", Holder)
                    Label.Size = UDim2.new(1, -60, 1, 0)
                    Label.Position = UDim2.new(0, 0, 0, 0)
                    Label.BackgroundTransparency = 1
                    Label.Text = label
                    Label.Font = Enum.Font.Gotham
                    Label.TextSize = 14
                    Label.TextColor3 = Color3.fromRGB(255,255,255)
                    Label.TextXAlignment = Enum.TextXAlignment.Left

                    local ToggleBtn = Instance.new("Frame", Holder)
                    ToggleBtn.Size = UDim2.new(0, 50, 0, 24)
                    ToggleBtn.Position = UDim2.new(1, -50, 0.5, -12)
                    ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    ToggleBtn.BorderSizePixel = 0
                    ToggleBtn.ClipsDescendants = true

                    local Ball = Instance.new("Frame", ToggleBtn)
                    Ball.Size = UDim2.new(0, 20, 0, 20)
                    Ball.Position = default and UDim2.new(0, 28, 0, 2) or UDim2.new(0, 2, 0, 2)
                    Ball.BackgroundColor3 = default and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
                    Ball.BorderSizePixel = 0
                    Ball.BackgroundTransparency = 0.1

                    local glow = Instance.new("UIStroke", Ball)
                    glow.Thickness = 1
                    glow.Color = Ball.BackgroundColor3

                    local state = default
                    ToggleBtn.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                            state = not state
                            local pos = state and UDim2.new(0, 28, 0, 2) or UDim2.new(0, 2, 0, 2)
                            local col = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)

                            TweenService:Create(Ball, TweenInfo.new(0.2), {
                                Position = pos,
                                BackgroundColor3 = col
                            }):Play()

                            glow.Color = col
                            if callback then callback(state) end
                        end
                    end)
                end
            }
        end
    }
end

return ModzHub
