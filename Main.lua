local ModzHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/FakeModz/PanjulHub-Script/refs/heads/main/UI"))()

local window = ModzHub:CreateWindow({
    Title = "Modz Hub | Fisch",
    })

local tab = window:CreateTab("Fishing Tab")


tab:AddToggle("Auto Fish", false, function(state)
    print("Auto Fish:", state)
end)

tab:AddToggle("Auto Fish", false, function(state)
    print("Auto Fish:", state)
end)

tab:AddToggle("Auto Fish", false, function(state)
    print("Auto Fish:", state)
end)


tab:AddButton("Buy Rod", function()
    print("Button clicked!")
end)

tab:AddLabel("This is just a label")



