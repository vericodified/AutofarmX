-- Load AutofarmX library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/vericodified/AutofarmX/refs/heads/main/Source.lua"))();
task.spawn(loadstring(game:HttpGet("https://raw.githubusercontent.com/vericodified/AutofarmX/refs/heads/main/Source2.lua")))

-- Create main window
local Window = Library.CreateLib("AutofarmX", "Ocean")
local Tab = Window:NewTab("Auto")
local Section = Tab:NewSection("Main")

-- Autofarm toggle
Section:NewToggle("Auto-Farm", "Wins for your noob self!", function(state)
    getgenv().TomatoAutoFarm = state
end)

-- Credit label
Section:NewLabel("Made by Verified")

---------------------------
-- JOINWATCHER HUB START --
---------------------------

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Remove old Joinwatcher GUI if exists
pcall(function()
    CoreGui:FindFirstChild("Joinwatcher"):Destroy()
end)

-- State
local enabled = false
local cooldown = false
local countdownLabel

-- Function: reset + kick with countdown
local function resetAndKick()
    if not enabled or cooldown then return end
    cooldown = true

    -- Reset character
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.Health = 0
    end

    -- Countdown display
    for i = 5, 1, -1 do
        if countdownLabel then
            countdownLabel.Text = "Kicking in: "..i.."s"
        end
        task.wait(1)
    end

    -- Kick
    if enabled then
        LocalPlayer:Kick("Reset + Kick executed (5 seconds).")
    end
end

-- Trigger for existing players
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        resetAndKick()
    end
end

-- Trigger for future player joins
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        resetAndKick()
    end
end)

-- === GUI ===
local gui = Instance.new("ScreenGui")
gui.Name = "Joinwatcher"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 180)
frame.Position = UDim2.new(0.7, -150, 0.4, -90) -- slightly offset from AutofarmX
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Joinwatcher Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Countdown label
countdownLabel = Instance.new("TextLabel", frame)
countdownLabel.Size = UDim2.new(1, 0, 0, 30)
countdownLabel.Position = UDim2.new(0, 0, 0.35, 0)
countdownLabel.BackgroundTransparency = 1
countdownLabel.Text = "Waiting..."
countdownLabel.Font = Enum.Font.Gotham
countdownLabel.TextSize = 16
countdownLabel.TextColor3 = Color3.fromRGB(200, 200, 200)

-- Toggle button
local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(0.7, 0, 0, 50)
toggle.Position = UDim2.new(0.15, 0, 0.65, 0)
toggle.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
toggle.Text = "OFF"
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 18
toggle.BorderSizePixel = 0
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 10)

-- Toggle logic
toggle.MouseButton1Click:Connect(function()
    enabled = not enabled
    cooldown = false
    if enabled then
        toggle.Text = "ON"
        toggle.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        countdownLabel.Text = "Waiting..."
    else
        toggle.Text = "OFF"
        toggle.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        countdownLabel.Text = "Disabled"
    end
end)

---------------------------
-- JOINWATCHER HUB END --
---------------------------
