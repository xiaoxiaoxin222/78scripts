local ScreenGui = Instance.new("ScreenGui")
local VideoScreen = Instance.new("VideoFrame")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.IgnoreGuiInset = true
ScreenGui.Name = "sz"

VideoScreen.Parent = ScreenGui
VideoScreen.Size = UDim2.new(1,0,1,0)

writefile("XJL.mp4", game:HttpGet("https://raw.githubusercontent.com/xiaoxiaoxin222/78scripts/refs/heads/main/Video_1754373105038.mp4"))

VideoScreen.Video = getcustomasset("XJL.mp4")

VideoScreen.Looped = true
VideoScreen.Playing = true
VideoScreen.Volume = 10
