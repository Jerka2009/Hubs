local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Organic - Control panel", "Synapse")
local Control = Window:NewTab("Control")
local More = Window:NewTab("More")
local Credit = Window:NewTab("Credit")
local CreditSection = Credit:NewSection("Credit")
local ControlSec = Control:NewSection("Player control")
local MoreSection = More:NewSection("More")
-- Variables
local Players = game:GetService("Players"):GetPlayers()
local LocalPlayer = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local Camera = game:GetService("Workspace").CurrentCamera
local TeleportService = game:GetService("TeleportService")
local ControlPlayerNick = ""
local PlayersList = {}
local Jokes = {"is clown!", "is bad", "pls leave", "goofy man"}
local themes = {
    SchemeColor = Color3.fromRGB(74, 99, 135),
    Background = Color3.fromRGB(36, 37, 43),
    Header = Color3.fromRGB(28, 29, 34),
    TextColor = Color3.fromRGB(255,255,255),
    ElementColor = Color3.fromRGB(32, 32, 38)
}
-- Control
for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
	table.insert(PlayersList, plr.Name)
end
local dropPlayer = ControlSec:NewDropdown("Player", "PlayerList", PlayersList, function(currentOption)
    ControlPlayerNick = currentOption
end)
game:GetService("Players").PlayerAdded:Connect(function(plr)
	table.insert(PlayersList, plr.Name)
	dropPlayer:Refresh(PlayersList)
end)
game:GetService("Players").PlayerRemoving:Connect(function(plr)
	local index = table.find(PlayersList, plr.Name) --get the index
	table.remove(PlayersList, index) --remove the index
	dropPlayer:Refresh(PlayersList)
end)
ControlSec:NewButton("Spectate", "follow the player", function()
	local ptp = game:GetService("Players"):FindFirstChild(ControlPlayerNick)
	local char = ptp.Character
	local hum = char:WaitForChild("Humanoid")
	Camera.CameraSubject = hum
end)
ControlSec:NewButton("Stop spectate", "stop follow the player", function()
	local char = LocalPlayer.Character
	local hum = char:WaitForChild("Humanoid")
	Camera.CameraSubject = hum
end)
ControlSec:NewButton("Teleport to player", "tp to player", function()
	local ptp = game:GetService("Players"):FindFirstChild(ControlPlayerNick)
	local char = ptp.Character
	local humRoot = char:WaitForChild("HumanoidRootPart")
	local plrw = LocalPlayer
	local char1 = plrw.Character
	local humRoot1 = char1:WaitForChild("HumanoidRootPart")
	humRoot1.CFrame = humRoot.CFrame
end)
ControlSec:NewButton("Joke on player [Message]", "Joke message", function()
	if ControlPlayerNick ~= "" or ControlPlayerNick ~= nil then
		local g = ControlPlayerNick.." "..Jokes[math.random(1,#Jokes)]
		game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(g)
	end
end)
-- More Tab
MoreSection:NewButton("ReJoin", "Rejoin On the Server", function()
	TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)
MoreSection:NewButton("Radio Gui", "Play your own sounds [Visual]", function()
-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Play = Instance.new("TextButton")
local SoundTrack = Instance.new("Sound")
local UICorner_2 = Instance.new("UICorner")
local Stop = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local TextBox = Instance.new("TextBox")
local Exit = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")

local gui = Frame

local dragging
local dragInput
local dragStart
local startPos
--Properties:

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SoundTrack.Parent = ScreenGui
SoundTrack.Looped = true
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(105, 106, 96)
Frame.BackgroundTransparency = 0.250
Frame.Position = UDim2.new(0.0436991863, 0, 0.592730999, 0)
Frame.Size = UDim2.new(0, 182, 0, 97)

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = Frame

Play.Name = "Play"
Play.Parent = Frame
Play.BackgroundColor3 = Color3.fromRGB(0, 255, 21)
Play.Position = UDim2.new(0.0494505502, 0, 0.556701005, 0)
Play.Size = UDim2.new(0, 81, 0, 31)
Play.Font = Enum.Font.SourceSans
Play.Text = "Play"
Play.TextColor3 = Color3.fromRGB(0, 0, 0)
Play.TextScaled = true
Play.TextSize = 14.000
Play.TextWrapped = true

UICorner_2.CornerRadius = UDim.new(0, 15)
UICorner_2.Parent = Play

Stop.Name = "Stop"
Stop.Parent = Frame
Stop.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Stop.Position = UDim2.new(0.494505495, 0, 0.556701005, 0)
Stop.Size = UDim2.new(0, 81, 0, 31)
Stop.Font = Enum.Font.SourceSans
Stop.Text = "Stop"
Stop.TextColor3 = Color3.fromRGB(0, 0, 0)
Stop.TextScaled = true
Stop.TextSize = 14.000
Stop.TextWrapped = true

UICorner_3.CornerRadius = UDim.new(0, 15)
UICorner_3.Parent = Stop

TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundTransparency = 0.300
TextBox.Position = UDim2.new(0.0769230798, 0, 0.0824742243, 0)
TextBox.Size = UDim2.new(0, 153, 0, 35)
TextBox.Font = Enum.Font.SourceSans
TextBox.ClearTextOnFocus = false
TextBox.PlaceholderColor3 = Color3.fromRGB(40, 40, 40)
TextBox.PlaceholderText = "Id pls..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
TextBox.TextSize = 22.000

Exit.Name = "Exit"
Exit.Parent = Frame
Exit.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Exit.Position = UDim2.new(0.917582393, 0, -0.144329891, 0)
Exit.Size = UDim2.new(0, 28, 0, 30)
Exit.Font = Enum.Font.SourceSans
Exit.Text = "X"
Exit.TextColor3 = Color3.fromRGB(0, 0, 0)
Exit.TextScaled = true
Exit.TextSize = 14.000
Exit.TextWrapped = true

UICorner_4.CornerRadius = UDim.new(0, 15)
UICorner_4.Parent = Exit
Play.MouseButton1Click:Connect(function()
	if TextBox.Text ~= "" then
		SoundTrack.SoundId = "rbxassetid://"..TextBox.Text
		SoundTrack:Play()
	end
end)

Stop.MouseButton1Click:Connect(function()
	SoundTrack:Stop()
end)

Exit.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)



local function update(input)
	local delta = input.Position - dragStart
	gui.Position = gui:TweenPosition(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y), 'Out', 'Linear', 0, true); -- drag speed
end

gui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = gui.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

gui.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)
end)
-- Color Picker
local PickerTheme = More:NewSection("Custom Theme")
for theme, color in pairs(themes) do
    PickerTheme:NewColorPicker(theme, "Change your "..theme, color, function(color3)
        Library:ChangeColor(theme, color3)
    end)
end
-- Credits
CreditSection:NewButton("Created by : YTim_Jerka2009#0067", "Click to copy", function()
	setclipboard("YTim_Jerka2009#0067")
end)
CreditSection:NewButton("Idea by : Niky#8422", "Click to copy", function()
	setclipboard("Niky#8422")
end)
