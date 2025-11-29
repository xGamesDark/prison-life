
-- Aimbot by zenss555a - English Version 2025 (Works on Xeno)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Loading screen
local loadingGui = Instance.new("ScreenGui")
local loadingText = Instance.new("TextLabel")
loadingGui.Parent = CoreGui
loadingText.Parent = loadingGui
loadingText.Size = UDim2.new(0, 300, 0, 100)
loadingText.Position = UDim2.new(0.5, -150, 0.5, -50)
loadingText.BackgroundTransparency = 1
loadingText.Text = "Loading..."
loadingText.TextColor3 = Color3.new(1, 0, 0)
loadingText.TextScaled = true
loadingText.Font = Enum.Font.GothamBold
task.wait(2.2)
loadingGui:Destroy()

-- Main GUI
local gui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local title = Instance.new("TextLabel")
local toggle = Instance.new("TextButton")
local fovLabel = Instance.new("TextLabel")
local fovBox = Instance.new("TextBox")

gui.Name = "ZenssHub"
gui.Parent = CoreGui

frame.Parent = gui
frame.Size = UDim2.new(0, 260, 0, 190)
frame.Position = UDim2.new(0, 15, 0, 15)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BorderColor3 = Color3.new(1, 0, 0)
frame.BorderSizePixel = 2
frame.Active = true
frame.Draggable = true

title.Parent = frame
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.Text = "Aimbot by zenss555a"
title.TextColor3 = Color3.new(1, 0, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = 20

toggle.Parent = frame
toggle.Size = UDim2.new(0, 220, 0, 50)
toggle.Position = UDim2.new(0.5, -110, 0, 50)
toggle.BackgroundColor3 = Color3.new(0.15, 0.15,0.15)
toggle.Text = "Aimbot: OFF"
toggle.TextColor3 = Color3.new(1, 0, 0)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 24

fovLabel.Parent = frame
fovLabel.Size = UDim2.new(1, 0, 0, 30)
fovLabel.Position = UDim2.new(0, 0, 0, 110)
fovLabel.BackgroundTransparency = 1
fovLabel.Text = "FOV: 160"
fovLabel.TextColor3 = Color3.new(1, 0, 0)
fovLabel.Font = Enum.Font.Gotham

fovBox.Parent = frame
fovBox.Size = UDim2.new(0, 220, 0, 35)
fovBox.Position = UDim2.new(0.5, -110, 0, 140)
fovBox.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
fovBox.Text = "160"
fovBox.TextColor3 = Color3.new(1,1,1)

-- Variables
local aimbotActive = false
fovRadius = 160

-- FOV circle
local circle = Drawing.new("Circle")
circle.Visible = true
circle.Thickness = 2
circle.Color = Color3.new(1,0,0)
circle.Radius = fovRadius
circle.Filled = false

RunService.RenderStepped:Connect(function()
    circle.Radius = fovRadius
    circle.Position = Vector2.new(Mouse.X, Mouse.Y + 36)
end)

toggle.MouseButton1Click:Connect(function()
    aimbotActive = not aimbotActive
    toggle.Text = aimbotActive and "Aimbot: ON" or "Aimbot: OFF"
    toggle.BackgroundColor3 = aimbotActive and Color3.new(0.4,0,0) or Color3.new(0.15,0.15,0.15)
end)

fovBox.FocusLost:Connect(function(enter)
    if enter then
        local num = tonumber(fovBox.Text)
        if num and num >= 20 and num <= 600 then
            fovRadius = num
            fovLabel.Text = "FOV: " .. num
        end
    end
end)

local function getClosestPlayer()
    local closest = nil
    local shortest = fovRadius
    for _, player in Players:GetPlayers() do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") and player.Team ~= LocalPlayer.Team then
            local head = player.Character.Head
            local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
            local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y+36)).Magnitude
            if onScreen and dist < shortest then
                shortest = dist
                closest = head
            end
        end
    end
    return closest
end

Anonymous, [29/11/2025 12:31]
Mouse.Button2Down:Connect(function()
    if aimbotActive then
        local target = getClosestPlayer()
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
            local sound = Instance.new("Sound", workspace)
            sound.SoundId = "rbxassetid://156894510"
            sound.Volume = 0.5
            sound:Play()
            task.delay(0.3, function() sound:Destroy() end)
        end
    end
end)

-- Red ESP
task.spawn(function()
    while task.wait(1) do
        for _, player in Players:GetPlayers() do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") and player.Team ~= LocalPlayer.Team then
                if not player.Character.Head:FindFirstChild("ZenssESP") then
                    local bill = Instance.new("BillboardGui", player.Character.Head)
                    bill.Name = "ZenssESP"
                    bill.AlwaysOnTop = true
                    bill.Size = UDim2.new(0,100,0,50)
                    bill.StudsOffset = Vector3.new(0,3,0)
                    local txt = Instance.new("TextLabel", bill)
                    txt.Text = player.Name
                    txt.BackgroundTransparency = 1
                    txt.TextColor3 = Color3.new(1,0,0)
                    txt.TextScaled = true
                    txt.Font = Enum.Font.GothamBold
                    txt.TextStrokeTransparency = 0
                end
            end
        end
    end
end)

print("Aimbot by zenss555a loaded - 2025 bypass")
