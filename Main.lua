-- Load Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Buat Window
local Window = Library.CreateLib("Script Keren", "DarkTheme")

-- Tab Utama
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Kontrol")

-- Komponen GUI
Section:NewButton("Klik Saya", "Tombol ini print ke console", function()
    print("Kamu menekan tombol!")
end)

Section:NewToggle("Mode Rahasia", "Hidupkan/matikan mode", function(state)
    print("Mode:", state and "AKTIF" or "NONAKTIF")
end)

Section:NewSlider("Kecepatan", "Atur kecepatanmu", 100, 1, function(value)
    print("Kecepatan diatur ke:", value)
end)

Section:NewTextBox("Masukkan Nama", "Print ke console", function(txt)
    print("Nama kamu adalah:", txt)
end)

Section:NewDropdown("Pilih Senjata", {"Pedang", "Busur", "Senapan"}, function(current)
    print("Kamu memilih:", current)
end)

Section:NewKeybind("Tekan Tombol", "Key untuk fungsi cepat", Enum.KeyCode.X, function()
    print("Tombol X ditekan")
end)

-- Simpan GUI agar bisa di-minimize/maximize
local gui = game.CoreGui:FindFirstChild("KavoUI") or game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("KavoUI")

-- Tombol Minimize / Maximize
local minimized = false
Section:NewButton("Sembunyikan/Perlihatkan GUI", "Klik untuk toggle GUI", function()
    if gui then
        minimized = not minimized
        gui.Enabled = not minimized
    end
end)

-- Tambahkan Drag ke Frame utama
task.wait(1)
if gui then
    for _, v in pairs(gui:GetDescendants()) do
        if v:IsA("Frame") and v.Name == "Main" then
            v.Active = true
            v.Draggable = true
        end
    end
end
