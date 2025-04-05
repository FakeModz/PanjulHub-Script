local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "My Script",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by kamu",
    ConfigurationSaving = {
        Enabled = false,
    }
})

local Tab = Window:CreateTab("Main", 4483362458)

Tab:CreateButton({
    Name = "Click Me",
    Callback = function()
        print("Clicked")
    end
})
