local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- 创建主界面
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AbnormalityTracker"
screenGui.Parent = game:GetService("CoreGui")
-- 创建可拖动按钮
local dragButton = Instance.new("TextButton")
dragButton.Name = "DragButton"
dragButton.Size = UDim2.new(0, 100, 0, 40)
dragButton.Position = UDim2.new(0, 20, 0.5, -20)
dragButton.BackgroundColor3 = Color3.fromRGB(25, 120, 200)
dragButton.Text = "异想体房间传送"
dragButton.TextColor3 = Color3.new(1, 1, 1)  -- 恢复白色文本
dragButton.Font = Enum.Font.SourceSansBold
dragButton.TextSize = 18
dragButton.Parent = screenGui

-- 创建UI容器
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- 添加标题
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.Text = "异想体列表"
title.TextColor3 = Color3.new(1, 1, 1)  -- 恢复白色文本
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = mainFrame

-- 创建滚动区域
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Size = UDim2.new(1, -10, 1, -40)
scrollFrame.Position = UDim2.new(0, 5, 0, 35)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 8
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = mainFrame

-- 创建UI模板
local itemTemplate = Instance.new("Frame")
itemTemplate.Name = "ItemTemplate"
itemTemplate.Size = UDim2.new(1, -10, 0, 60)
itemTemplate.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
itemTemplate.BorderSizePixel = 0
itemTemplate.Visible = false

local nameLabel = Instance.new("TextLabel")
nameLabel.Name = "NameLabel"
nameLabel.Size = UDim2.new(0.7, 0, 0.6, 0)
nameLabel.Position = UDim2.new(0.05, 0, 0.2, 0)
nameLabel.BackgroundTransparency = 1
nameLabel.Text = "名称"
nameLabel.TextColor3 = Color3.new(1, 1, 1)  -- 恢复白色文本
nameLabel.Font = Enum.Font.SourceSans
nameLabel.TextSize = 18
nameLabel.TextXAlignment = Enum.TextXAlignment.Left
nameLabel.Parent = itemTemplate

local teleportButton = Instance.new("TextButton")
teleportButton.Name = "TeleportButton"
teleportButton.Size = UDim2.new(0.25, 0, 0.6, 0)
teleportButton.Position = UDim2.new(0.7, 0, 0.2, 0)
teleportButton.BackgroundColor3 = Color3.fromRGB(80, 150, 80)
teleportButton.Text = "传送"
teleportButton.TextColor3 = Color3.new(1, 1, 1)  -- 恢复白色文本
teleportButton.Font = Enum.Font.SourceSansBold
teleportButton.TextSize = 16
teleportButton.Parent = itemTemplate

itemTemplate.Parent = screenGui

-- 存储当前显示的UI项
local activeItems = {}

-- 拖动功能
local dragging = false
local dragOffset = Vector2.new(0, 0)

dragButton.MouseButton1Down:Connect(function()
    dragging = true
    dragOffset = Vector2.new(mouse.X - dragButton.AbsolutePosition.X, mouse.Y - dragButton.AbsolutePosition.Y)
end)

mouse.Move:Connect(function()
    if dragging then
        dragButton.Position = UDim2.new(
            0, mouse.X - dragOffset.X,
            0, mouse.Y - dragOffset.Y
        )
    end
end)

dragButton.MouseButton1Up:Connect(function()
    dragging = false
end)

-- 按钮点击切换UI显示
dragButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- 瞬间传送玩家到目标位置
local function teleportPlayer(targetPosition)
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        -- 尝试找到其他可移动的部分
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "Head" then
                humanoidRootPart = part
                break
            end
        end
    end
    
    if humanoidRootPart then
        -- 创建传送效果
        local teleportEffect = Instance.new("Part")
        teleportEffect.Size = Vector3.new(1, 1, 1)
        teleportEffect.Position = humanoidRootPart.Position
        teleportEffect.Anchored = true
        teleportEffect.CanCollide = false
        teleportEffect.Transparency = 0.5
        teleportEffect.BrickColor = BrickColor.new("Bright blue")
        teleportEffect.Shape = Enum.PartType.Ball
        teleportEffect.Parent = workspace
        
        -- 瞬间传送
        humanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, 3, 0))
        
        -- 添加特效
        game:GetService("TweenService"):Create(
            teleportEffect,
            TweenInfo.new(0.5),
            {Size = Vector3.new(5, 5, 5), Transparency = 1}
        ):Play()
        
        game.Debris:AddItem(teleportEffect, 0.6)
    end
end

-- 创建UI项函数
local function createItem(model)
    local newItem = itemTemplate:Clone()
    newItem.Visible = true
    newItem.Name = model.Name .. "_Item"
    
    local nameLabel = newItem:FindFirstChild("NameLabel")
    if nameLabel then
        nameLabel.Text = model.Name
    end
    
    local teleportButton = newItem:FindFirstChild("TeleportButton")
    if teleportButton then
        teleportButton.MouseButton1Click:Connect(function()
            -- 获取模型的位置
            local targetPosition
            if model:IsA("Model") and model.PrimaryPart then
                targetPosition = model.PrimaryPart.Position
            else
                targetPosition = model:GetPivot().Position
            end
            
            -- 传送玩家
            teleportPlayer(targetPosition)
            
            -- 关闭UI
            --mainFrame.Visible = false
        end)
    end
    
    return newItem
end

-- 更新滚动区域
local function updateScrollFrame()
    local totalHeight = 0
    local padding = 5
    
    -- 清除现有项
    for _, item in ipairs(scrollFrame:GetChildren()) do
        if item:IsA("Frame") and item.Name:find("_Item") then
            item:Destroy()
        end
    end
    table.clear(activeItems)
    
    local abnormalitiesFolder = workspace:FindFirstChild("Abnormalities")
    if abnormalitiesFolder then
        for _, model in ipairs(abnormalitiesFolder:GetChildren()) do
            if model:IsA("Model") then
                local item = createItem(model)
                item.Parent = scrollFrame
                table.insert(activeItems, item)
                
                item.Position = UDim2.new(0, 5, 0, totalHeight)
                totalHeight = totalHeight + item.AbsoluteSize.Y + padding
            end
        end
    end
    
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
end

-- 初始化文件夹（如果不存在）
task.spawn(function()
    if not workspace:FindFirstChild("Abnormalities") then
        Instance.new("Folder", workspace).Name = "Abnormalities"
    end
end)

-- 设置文件夹监听
local function setupFolderListener()
    local abnormalitiesFolder = workspace:WaitForChild("Abnormalities", 10)
    if abnormalitiesFolder then
        abnormalitiesFolder.ChildAdded:Connect(updateScrollFrame)
        abnormalitiesFolder.ChildRemoved:Connect(updateScrollFrame)
    end
end

-- 初始化UI
setupFolderListener()
updateScrollFrame()

-- 添加关闭按钮
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 18
closeButton.Parent = mainFrame

closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- 添加UI边框
local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 2
uiStroke.Color = Color3.fromRGB(100, 100, 100)
uiStroke.Parent = mainFrame

-- 添加按钮边框
local buttonStroke = Instance.new("UIStroke")
buttonStroke.Thickness = 1
buttonStroke.Color = Color3.fromRGB(150, 150, 150)
buttonStroke.Parent = dragButton