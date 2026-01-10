getgenv().TomatoAutoFarm = false
task.spawn(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/vericodified/AutofarmX/refs/heads/main/autofarm.lua"))()
end)
