-- Target Player Lag with ON/OFF Switch
local function TargetLagWithSwitch()
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")
    local localPlayer = Players.LocalPlayer
    
    local isLagActive = false
    local targetPlayer = nil
    local lagConnections = {}
    
    -- GUI Interface
    local gui = Instance.new("ScreenGui")
    gui.Name = "TargetLagSwitch"
    gui.Parent = localPlayer:WaitForChild("PlayerGui")
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 300, 0, 200)
    mainFrame.Position = UDim2.new(0, 50, 0, 50)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = gui
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Text = "🎯 TARGET LAG SWITCH"
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    -- Target Player Input
    local targetBox = Instance.new("TextBox")
    targetBox.PlaceholderText = "Введите ник цели..."
    targetBox.Size = UDim2.new(0.8, 0, 0, 30)
    targetBox.Position = UDim2.new(0.1, 0, 0, 40)
    targetBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    targetBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    targetBox.Font = Enum.Font.Gotham
    targetBox.Parent = mainFrame
    
    -- ON/OFF Switch
    local switchButton = Instance.new("TextButton")
    switchButton.Text = "🔴 ВЫКЛ"
    switchButton.Size = UDim2.new(0.8, 0, 0, 40)
    switchButton.Position = UDim2.new(0.1, 0, 0, 80)
    switchButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    switchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    switchButton.Font = Enum.Font.GothamBold
    switchButton.Parent = mainFrame
    
    -- Status
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Text = "Статус: Ожидание цели..."
    statusLabel.Size = UDim2.new(0.8, 0, 0, 30)
    statusLabel.Position = UDim2.new(0.1, 0, 0, 130)
    statusLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = mainFrame
    
    -- Lag Methods
    local function startTargetLag(player)
        if not player or player == localPlayer then return end
        
        statusLabel.Text = "Лагируем: " .. player.Name
        print("🎯 Starting lag on: " .. player.Name)
        
        -- Method 1: Particle Spam around target
        local function particleSpam()
            local connection = RunService.Heartbeat:Connect(function()
                pcall(function()
                    local character = player.Character
                    if character then
                        local root = character:FindFirstChild("HumanoidRootPart")
                        if root then
                            -- Create particles around target
                            for i = 1, 5 do
                                local part = Instance.new("Part")
                                part.Position = root.Position + Vector3.new(
                                    math.random(-10, 10),
                                    math.random(0, 10),
                                    math.random(-10, 10)
                                )
                                part.Size = Vector3.new(2, 2, 2)
                                part.Anchored = true
                                part.CanCollide = false
                                part.Transparency = 0.5
                                part.Parent = workspace
                                
                                local fire = Instance.new("Fire")
                                fire.Size = 8
                                fire.Parent = part
                                
                                game:GetService("Debris"):AddItem(part, 1)
                            end
                        end
                    end
                end)
            end)
            table.insert(lagConnections, connection)
        end
        
        -- Method 2: Network Spam targeting player
        local function networkSpam()
            local connection = RunService.Heartbeat:Connect(function()
                pcall(function()
                    -- Spam RemoteEvents with target data
                    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
                        if obj:IsA("RemoteEvent") and math.random(1, 3) == 1 then
                            obj:FireServer({
                                Target = player,
                                Damage = 1,
                                Position = Vector3.new(math.random(-50,50), math.random(0,25), math.random(-50,50))
                            })
                        end
                    end
                end)
            end)
            table.insert(lagConnections, connection)
        end
        
        -- Method 3: Sound Spam on target
        local function soundSpam()
            local connection = RunService.Heartbeat:Connect(function()
                pcall(function()
                    local character = player.Character
                    if character then
                        local sound = Instance.new("Sound")
                        sound.SoundId = "rbxassetid://" .. math.random(1000000, 9999999)
                        sound.Parent = character
                        sound:Play()
                        game:GetService("Debris"):AddItem(sound, 0.5)
                    end
                end)
            end)
            table.insert(lagConnections, connection)
        end
        
        -- Start all lag methods
        particleSpam()
        networkSpam()
        soundSpam()
    end
    
    local function stopTargetLag()
        statusLabel.Text = "Лаги остановлены"
        print("🛑 Stopping all lag")
        
        -- Disconnect all lag connections
        for _, connection in pairs(lagConnections) do
            connection:Disconnect()
        end
        lagConnections = {}
    end
    
    -- Switch Button Handler
    switchButton.MouseButton1Click:Connect(function()
        if isLagActive then
            -- Turn OFF
            isLagActive = false
            switchButton.Text = "🔴 ВЫКЛ"
            switchButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
            stopTargetLag()
        else
            -- Turn ON
            local targetName = targetBox.Text
            if targetName ~= "" then
                targetPlayer = Players:FindFirstChild(targetName)
                if targetPlayer then
                    isLagActive = true
                    switchButton.Text = "🟢 ВКЛ"
                    switchButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
                    startTargetLag(targetPlayer)
                else
                    statusLabel.Text = "Игрок не найден: " .. targetName
                end
            else
                statusLabel.Text = "Введите ник игрока!"
            end
        end
    end)
    
    -- Auto-find VIP players
    local function findVIPPlayers()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= localPlayer then
                -- Check for VIP indicators
                local character = player.Character
                if character then
                    -- Look for expensive items/effects
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("Part") then
                            if part.Material == Enum.Material.Neon or
                               part.BrickColor == BrickColor.new("Bright yellow") or
                               part:FindFirstChildOfClass("ParticleEmitter") then
                                targetBox.Text = player.Name
                                statusLabel.Text = "Найден VIP: " .. player.Name
                                break
                            end
                        end
                    end
                end
            end
        end
    end
    
    -- Auto-find VIP on start
    delay(2, findVIPPlayers)
    
    print("🎯 Target Lag Switch loaded!")
    print("📝 Instructions:")
    print("1. Введите ник игрока в поле")
    print("2. Нажмите кнопку для ВКЛ/ВЫКЛ")
    print("3. Пока он лагает - крадите!")
end

-- Start the script
TargetLagWithSwitch()
