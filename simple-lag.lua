-- SIMPLE WORKING LAG SCRIPT
print("🚀 LAG SCRIPT LOADING...")

wait(1)

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local localPlayer = Players.LocalPlayer

print("✅ Game services loaded")

-- Create simple GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LagSwitchGUI"
screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 120)
mainFrame.Position = UDim2.new(0, 50, 0, 50)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
mainFrame.BorderSizePixel = 2
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Text = "LAG SWITCH"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local button = Instance.new("TextButton")
button.Text = "START LAG"
button.Size = UDim2.new(0.8, 0, 0, 40)
button.Position = UDim2.new(0.1, 0, 0, 40)
button.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.Parent = mainFrame

local status = Instance.new("TextLabel")
status.Text = "Click button to start lag"
status.Size = UDim2.new(0.8, 0, 0, 30)
status.Position = UDim2.new(0.1, 0, 0, 90)
status.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
status.TextColor3 = Color3.fromRGB(255, 255, 255)
status.Font = Enum.Font.Gotham
status.Parent = mainFrame

print("✅ GUI created")

-- Lag function
local isLagging = false
local lagParts = {}

button.MouseButton1Click:Connect(function()
    if not isLagging then
        -- START LAG
        isLagging = true
        button.Text = "STOP LAG"
        button.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        status.Text = "LAGGING OTHERS..."
        
        print("🔴 STARTING LAG...")
        
        -- Create LOTS of parts to lag everyone
        spawn(function()
            while isLagging do
                wait(0.1)
                
                -- Create 10 parts each time
                for i = 1, 10 do
                    local part = Instance.new("Part")
                    part.Size = Vector3.new(5, 5, 5)
                    part.Position = Vector3.new(
                        math.random(-100, 100),
                        math.random(10, 50), 
                        math.random(-100, 100)
                    )
                    part.Anchored = true
                    part.Material = Enum.Material.Neon
                    part.BrickColor = BrickColor.new("Bright red")
                    part.Parent = Workspace
                    
                    -- Add effects
                    local fire = Instance.new("Fire")
                    fire.Size = 10
                    fire.Parent = part
                    
                    local sparkles = Instance.new("Sparkles")
                    sparkles.Parent = part
                    
                    table.insert(lagParts, part)
                end
                
                -- Clean old parts to prevent crash
                if #lagParts > 100 then
                    for i = 1, 20 do
                        if lagParts[i] then
                            lagParts[i]:Destroy()
                            table.remove(lagParts, i)
                        end
                    end
                end
            end
        end)
        
    else
        -- STOP LAG
        isLagging = false
        button.Text = "START LAG"
        button.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        status.Text = "LAG STOPPED"
        
        print("🟢 STOPPING LAG...")
        
        -- Clean all lag parts
        for _, part in pairs(lagParts) do
            pcall(function() part:Destroy() end)
        end
        lagParts = {}
    end
end)

print("🎯 LAG SWITCH READY!")
print("📝 Click the button to start/stop lag")
print("💡 While others lag - you can steal!")
