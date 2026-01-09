local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/vericodified/AutofarmX/refs/heads/main/Source.lua"))();task.spawn(loadstring(game:HttpGet("https://raw.githubusercontent.com/vericodified/AutofarmX/refs/heads/main/Source2.lua")))
local Window = Library.CreateLib("AutofarmX", "Ocean")
local Tab = Window:NewTab("Auto")
local Section = Tab:NewSection("Main")
Section:NewToggle("Auto-Farm", "Wins for your noob self!", function(state)
    getgenv().TomatoAutoFarm = state
end);Section:NewLabel("Made by Verified")
