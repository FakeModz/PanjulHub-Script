-- Load Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Buat Window
local Window = Library.CreateLib("Script Keren", "DarkTheme") -- bisa juga "LightTheme"

-- Tab Utama
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Kontrol")

-- Button
Section:NewButton("Klik Saya", "Tombol ini print ke console", function()
    print("Kamu menekan tombol!")
end)

-- Toggle
Section:NewToggle("Mode Rahasia", "Hidupkan/matikan mode", function(state)
    if state then
        print("Mode diaktifkan")
    else
        print("Mode dimatikan")
    end
end)

-- Slider
Section:NewSlider("Kecepatan", "Atur kecepatanmu", 100, 1, function(value)
    print("Kecepatan diatur ke:", value)
end)

-- TextBox
Section:NewTextBox("Masukkan Nama", "Print ke console", function(txt)
    print("Nama kamu adalah:", txt)
end)

-- Dropdown
Section:NewDropdown("Pilih Senjata", {"Pedang", "Busur", "Senapan"}, function(current)
    print("Kamu memilih:", current)
end)

-- Keybind
Section:NewKeybind("Tekan Tombol", "Menjalankan fungsi saat key ditekan", Enum.KeyCode.X, function()
    print("Tombol X ditekan")
end)
