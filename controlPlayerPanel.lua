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
local Jokes = {"is clown!", "is bad", "pls leave", "goofy man", "genius", "This is not toxic spam."}
local Thx = {"is good!", "is cool", "is beautiful", "GG!", "GGWP!"}
local themes = {
    SchemeColor = Color3.fromRGB(74, 99, 135),
    Background = Color3.fromRGB(36, 37, 43),
    Header = Color3.fromRGB(28, 29, 34),
    TextColor = Color3.fromRGB(255,255,255),
    ElementColor = Color3.fromRGB(32, 32, 38)
}	
-- Control
for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
	if plr.UserId ~= LocalPlayer.UserId then
		table.insert(PlayersList, plr.Name)
	end
end
local dropPlayer = ControlSec:NewDropdown("Player", "PlayerList", PlayersList, function(currentOption)
    ControlPlayerNick = currentOption
end)
game:GetService("Players").PlayerAdded:Connect(function(plr)
	if plr.UserId ~= LocalPlayer.UserId then
		table.insert(PlayersList, plr.Name)
	end
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
		local sucess, err = pcall(function()
			local args = {[1] = g,[2] = "All"}
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
		end)
		if err then
			local s, er = pcall(function()
				game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(g)
			end)
		end
	end
end)
ControlSec:NewButton("Thanking the player [Message]", "Thank message", function()
	if ControlPlayerNick ~= "" or ControlPlayerNick ~= nil then
		local g = ControlPlayerNick.." "..Thx[math.random(1,#Thx)]
		local sucess, err = pcall(function()
			local args = {[1] = g,[2] = "All"}
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
		end)
		if err then
			local s, er = pcall(function()
				game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(g)
			end)
		end
	end
end)
-- More Tab
MoreSection:NewButton("ReJoin", "Rejoin On the Server", function()
	TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)
MoreSection:NewButton("Radio Gui", "Play your own sounds [Visual]", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Jerka2009/Hubs/main/MusicGui.lua"))()
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
