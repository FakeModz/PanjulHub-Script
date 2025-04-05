-- Load Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Buat Window
local Window = Library.CreateLib("Script Keren", "DarkTheme")

-- Buat Tab
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Fitur")

-- Tombol Minimize / Maximize
local isMinimized = false
local gui = game:GetService("CoreGui"):FindFirstChild("KavoUI") or game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("KavoUI")

Section:NewButton("Toggle GUI", "Minimize / Maximize GUI", function()
    if gui then
        gui.Enabled = not gui.Enabled
        isMinimized = not gui.Enabled
    else
        warn("GUI tidak ditemukan")
    end
end)

-- Tambahkan Drag ke Frame
task.delay(1, function()
    if gui then
        local mainFrame = gui:FindFirstChild("Main", true) -- cari secara rekursif
        if mainFrame and mainFrame:IsA("Frame") then
            mainFrame.Active = true
            mainFrame.Draggable = true
        else
            warn("Main Frame tidak ditemukan")
        end
    else
        warn("KavoUI tidak ditemukan")
    end
end)

-- Fitur tambahan contoh
Section:NewButton("Contoh Print", "Print ke Output", function()
    print("Berhasil klik tombol!")
end)
