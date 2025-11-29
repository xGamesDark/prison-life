-- Aimbot by zenss555a - Fixed Nil Errors 2025 (Xeno Compatible)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Safe GUI creation with pcall
local function createGui()
    pcall(function()
        local gui = Instance.new("ScreenGui")
        local frame = Instance.new("Frame")
        local title = Instance.new("TextLabel")
        local toggle = Instance.new("TextButton")
        local fovLabel = Instance.new("TextLabel")
        local fovBox = Instance.new("TextBox")

        gui.Name = "ZenssHub"
        gui.Parent = CoreGui
        gui.ResetOnSpawn = false

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
        toggle.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
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
        fovBox.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        fovBox.Text = "160"
        fovBox.TextColor3 = Color3.new(1, 1, 1)
        fovBox.Font = Enum.Font.Gotham

        -- Variables
        local aimbotActive = false
        local fovRadius = 160

        -- FOV Circle
        local circle = Drawing.new("Circle")
        circle.Visible = true
        circle.Thickness = 2
        circle.Color = Color3.new(1, 0, 0)
        circle.Radius = fovRadius
        circle.Filled = false
        circle.NumSides = 40

        RunService.RenderStepped:Connect(function()
            circle.Radius = fovRadius
            circle.Position = Vector2.new(Mouse.X, Mouse.Y + 36)
        end)

        toggle.MouseButton1Click:Connect(function()
            aimbotActive = not aimbotActive
            toggle.Text = aimbotActive and "Aimbot: ON" or "Aimbot: OFF"
            toggle.BackgroundColor3 = aimbotActive and Color3.new(0.4, 0, 0) or Color3.new(0.15, 0.15, 0.15)
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
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") and player.Team ~= LocalPlayer.Team then
                    local head = player.Character.Head

Anonymous, [29/11/2025 13:21]
local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                    if onScreen then
                        local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y + 36)).Magnitude
                        if dist < shortest then
                            shortest = dist
                            closest = head
                        end
                    end
                end
            end
            return closest
        end

        Mouse.Button2Down:Connect(function()
            if aimbotActive then
                local target = getClosestPlayer()
                if target then
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
                    -- Safe beep
                    pcall(function()
                        local soundService = game:GetService("SoundService")
                        local beep = Instance.new("Sound")
                        beep.SoundId = "rbxassetid://156894510"
                        beep.Volume = 0.5
                        beep.Parent = soundService
                        beep:Play()
                        game:GetService("Debris"):AddItem(beep, 0.3)
                    end)
                end
            end
        end)

        -- ESP Loop (safe spawn)
        spawn(function()
            while wait(1) do
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") and player.Team ~= LocalPlayer.Team then
                        if not player.Character.Head:FindFirstChild("ZenssESP") then
                            local bill = Instance.new("BillboardGui")
                            bill.Name = "ZenssESP"
                            bill.Parent = player.Character.Head
                            bill.AlwaysOnTop = true
                            bill.Size = UDim2.new(0, 100, 0, 50)
                            bill.StudsOffset = Vector3.new(0, 3, 0)
                            local txt = Instance.new("TextLabel")
                            txt.Parent = bill
                            txt.Text = player.Name
                            txt.BackgroundTransparency = 1
                            txt.TextColor3 = Color3.new(1, 0, 0)
                            txt.TextScaled = true
                            txt.Font = Enum.Font.GothamBold
                            txt.TextStrokeTransparency = 0
                            txt.TextStrokeColor3 = Color3.new(0, 0, 0)
                        end
                    else
                        if player.Character and player.Character:FindFirstChild("Head") and player.Character.Head:FindFirstChild("ZenssESP") then
                            pcall(function() player.Character.Head.ZenssESP:Destroy() end)
                        end
                    end
                end
            end
        end)
    end)
end

-- Delay to avoid nil on load
wait(1)
createGui()

print("Aimbot by zenss555a loaded - No Errors 2025")
