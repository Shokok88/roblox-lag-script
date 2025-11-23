-- ВСТАВЬ ЭТОТ КОД В DELTA - TOOL SPAM LAG
print("🔄 Loading Tool Spam Lag...")

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

-- Ждем загрузки
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Создаем GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ToolSpamGUI"
gui.Parent = localPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 180)
mainFrame.Position = UDim2.new(0, 50, 0, 50)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 2
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

local title = Instance.new("TextLabel")
title.Text = "🛠️ TOOL SPAM LAG"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local status = Instance.new("TextLabel")
status.Text = "Status: Ready"
status.Size = UDim2.new(1, 0, 0, 25)
status.Position = UDim2.new(0, 0, 0, 35)
status.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
status.TextColor3 = Color3.fromRGB(255, 255, 255)
status.Font = Enum.Font.Gotham
status.Parent = mainFrame

local startBtn = Instance.new("TextButton")
startBtn.Text = "🚀 START TOOL SPAM"
startBtn.Size = UDim2.new(0.9, 0, 0, 40)
startBtn.Position = UDim2.new(0.05, 0, 0, 70)
startBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startBtn.Font = Enum.Font.GothamBold
startBtn.Parent = mainFrame

local stopBtn = Instance.new("TextButton")
stopBtn.Text = "🛑 STOP SPAM"
stopBtn.Size = UDim2.new(0.9, 0, 0, 40)
stopBtn.Position = UDim2.new(0.05, 0, 0, 120)
stopBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
stopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
stopBtn.Font = Enum.Font.GothamBold
stopBtn.Parent = mainFrame

-- Переменные
local isSpamming = false
local spamConnection = nil
local createdTools = {}

-- Функция создания инструментов
local function createTools()
    for _, tool in pairs(createdTools) do
        pcall(function() tool:Destroy() end)
    end
    createdTools = {}
    
    for i = 1, 10 do
        local tool = Instance.new("Tool")
        tool.Name = "LagTool_" .. i
        tool.Parent = localPlayer.Backpack
        
        local handle = Instance.new("Part")
        handle.Name = "Handle"
        handle.Size = Vector3.new(2, 2, 2)
        handle.BrickColor = BrickColor.new("Bright blue")
        handle.Parent = tool
        
        table.insert(createdTools, tool)
    end
end

-- Функция спама инструментами
local function startToolSpam()
    if isSpamming then return end
    
    isSpamming = true
    status.Text = "Status: SPAMMING TOOLS - Others will lag!"
    startBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    
    createTools()
    
    spamConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not isSpamming then return end
        
        pcall(function()
            local backpack = localPlayer:FindFirstChild("Backpack")
            local character = localPlayer.Character
            
            if backpack and character then
                for _, tool in pairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") then
                        tool.Parent = character
                        wait(0.01)
                        tool.Parent = backpack
                    end
                end
            end
        end)
    end)
end

-- Функция остановки
local function stopToolSpam()
    if not isSpamming then return end
    
    isSpamming = false
    status.Text = "Status: Stopped"
    startBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    
    if spamConnection then
        spamConnection:Disconnect()
        spamConnection = nil
    end
    
    for _, tool in pairs(createdTools) do
        pcall(function() tool:Destroy() end)
    end
    createdTools = {}
end

-- Обработчики кнопок
startBtn.MouseButton1Click:Connect(startToolSpam)
stopBtn.MouseButton1Click:Connect(stopToolSpam)

localPlayer.CharacterRemoving:Connect(function()
    stopToolSpam()
end)

print("🎯 TOOL SPAM LAG READY!")
