writefile("dog.mp4", game:HttpGet("https://codeberg.org/Jerka2009/Hubs/raw/branch/main/Man.mp4/Man.mp4"))
  local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    ScreenGui.IgnoreGuiInset = true
  local ImageLabel = Instance.new("VideoFrame", ScreenGui)
    ImageLabel.Position = UDim2.new(0, 0, 0, 0)
    ImageLabel.Size = UDim2.new(1, 0, 1, 0)
    ImageLabel.Video = getcustomasset("dog.mp4")
print(getcustomasset("dog.mp4"))
    ImageLabel:Play()
