loadstring(game:HttpGet("https://raw.githubusercontent.com/vova999000333/Hubs/main/intro.lua"))()

-- Gui to Lua
-- Version: 3.2

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local FGUI = Instance.new("Frame")
local Tittle = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local btnSex = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local tbxVictim = Instance.new("TextBox")
local UICorner_3 = Instance.new("UICorner")

--Properties:
if game.CoreGui:FindFirstChild("SexGuiOrganic") then
 game.CoreGui:FindFirstChild("SexGuiOrganic"):Destroy()
end

ScreenGui.Name = "SexGuiOrganic"
ScreenGui.Parent = game.CoreGui

FGUI.Name = "FGUI"
FGUI.Parent = ScreenGui
FGUI.BackgroundColor3 = Color3.fromRGB(255, 255, 114)
FGUI.ClipsDescendants = true
FGUI.Draggable = true
FGUI.Active = true
FGUI.Selectable = true
FGUI.Position = UDim2.new(0.0611587986, 0, 0.562160313, 0)
FGUI.Size = UDim2.new(0, 140, 0, 208)

Tittle.Name = "Tittle"
Tittle.Parent = FGUI
Tittle.BackgroundColor3 = Color3.fromRGB(255, 170, 34)
Tittle.BorderSizePixel = 0
Tittle.Size = UDim2.new(0, 140, 0, 36)
Tittle.Font = Enum.Font.FredokaOne
Tittle.Text = "Sex Gui by Organic Hub"
Tittle.TextColor3 = Color3.fromRGB(0, 0, 0)
Tittle.TextScaled = true
Tittle.TextSize = 14.000
Tittle.TextWrapped = true

UICorner.CornerRadius = UDim.new(0.200000003, 0)
UICorner.Parent = Tittle

btnSex.Name = "NbtJoke"
btnSex.Parent = FGUI
btnSex.BackgroundColor3 = Color3.fromRGB(69, 255, 75)
btnSex.Position = UDim2.new(0, 0, 0.798076928, 0)
btnSex.Size = UDim2.new(0, 140, 0, 42)
btnSex.Font = Enum.Font.Unknown
btnSex.Text = "Go fuck!"
btnSex.TextColor3 = Color3.fromRGB(0, 0, 0)
btnSex.TextScaled = true
btnSex.TextSize = 14.000
btnSex.TextWrapped = true

UICorner_2.CornerRadius = UDim.new(0.200000003, 0)
UICorner_2.Parent = NbtJoke

tbxVictim.Name = "VictimTEXT"
tbxVictim.Parent = FGUI
tbxVictim.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbxVictim.Position = UDim2.new(0, 0, 0.379807681, 0)
tbxVictim.Size = UDim2.new(0, 140, 0, 50)
tbxVictim.Font = Enum.Font.Unknown
tbxVictim.PlaceholderColor3 = Color3.fromRGB(104, 104, 104)
tbxVictim.PlaceholderText = "Player name"
tbxVictim.Text = ""
tbxVictim.TextColor3 = Color3.fromRGB(0, 0, 0)
tbxVictim.TextSize = 20.000
tbxVictim.TextWrapped = true

UICorner_3.CornerRadius = UDim.new(0.200000003, 0)
UICorner_3.Parent = FGUI
--Scripts
 
 
btnSex.MouseButton1Click:Connect(function()
 
local player = tbxVictim.Text
local stupid = Instance.new('Animation')
stupid.AnimationId = 'rbxassetid://148840371'
hummy = game:GetService("Players").LocalPlayer.Character.Humanoid
pcall(function()
    hummy.Parent.Pants:Destroy()
end)
pcall(function()
    hummy.Parent.Shirt:Destroy()
end)
local notfunny = hummy:LoadAnimation(stupid)
notfunny:Play()
notfunny:AdjustSpeed(10)
while hummy.Parent.Parent ~= nil do
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[tbxVictim.Text].Character.HumanoidRootPart.CFrame
end
end)
