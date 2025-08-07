-- 创建UI元素
local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "UnlockButtonGUI"
gui.Parent = game:GetService("CoreGui")

local button = Instance.new("TextButton")
button.Name = "UnlockButton"
button.Text = "一键解锁所有异想体信息"
button.Size = UDim2.new(0, 200, 0, 60)
button.Position = UDim2.new(0.5, -100, 0.8, -30) -- 初始位置在底部居中
button.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 20
button.BorderSizePixel = 0
button.ZIndex = 10
button.Parent = gui

-- 添加圆角效果
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0.3, 0)
corner.Parent = button

-- 添加阴影效果
local shadow = Instance.new("UIStroke")
shadow.Color = Color3.new(0, 0, 0)
shadow.Thickness = 2
shadow.Parent = button

-- 按钮拖动功能
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

button.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = button.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

button.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

-- 点击按钮执行解锁操作
button.MouseButton1Click:Connect(function()
	-- 查找并销毁 LockedFrame
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj.Name == "LockedFrame" then
			obj:Destroy()
		end
	end
	
	-- 查找并销毁 RequirerResearchLabel
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj.Name == "RequirerResearchLabel" then
			obj:Destroy()
		end
	end
	
	-- 添加点击反馈
	button.Text = "已解锁!"
	task.wait(1)
	button.Text = "一键解锁所有异想体信息"
end)

-- 适配移动设备触摸事件
if game:GetService("UserInputService").TouchEnabled then
	button.Activated:Connect(function()
		button:SetAttribute("TouchPressed", true)
		button.MouseButton1Click:Wait()
		button:SetAttribute("TouchPressed", false)
	end)
end