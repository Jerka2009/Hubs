local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Origane Hub", "Sentinel")
local Player = Window:NewTab("Player")
local Tools = Window:NewTab("Tools")
local More = Window:NewTab("More")
local Credit = Window:NewTab("Credit")
local CreditSection = Credit:NewSection("Credit")
local MoreSection = More:NewSection("More")
local PlayerSection = Player:NewSection("Player")
local ToolsSection = Tools:NewSection("Tools")
-- Variables
local Players = game.Players:GetPlayers()
local TeleportService = game:GetService("TeleportService")
local Noclip = nil
local Clip = nil
-- Functions
function noclip()
	Clip = false
	local function Nocl()
		if Clip == false and game.Players.LocalPlayer.Character ~= nil then
			for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
				if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
					v.CanCollide = false
				end
			end
		end
		wait(0.50) -- basic optimization
	end
	Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
end

function clip()
	if Noclip then Noclip:Disconnect() end
	Clip = true
end
-- Player Tab
PlayerSection:NewButton("Reset", "RespawnCaracter", function()
	local char = game.Players.LocalPlayer.Character
	if char:FindFirstChildOfClass("Humanoid") then char:FindFirstChildOfClass("Humanoid"):ChangeState(15) end
	char:ClearAllChildren()
	local newChar = Instance.new("Model")
	newChar.Parent = workspace
	game.Players.LocalPlayer.Character = newChar
	wait()
	game.Players.LocalPlayer.Character = char
	newChar:Destroy()
    print("Clicked")
end)

PlayerSection:NewSlider("Walkspeed", "Changes the walkspeed", 250, 16, function(v)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)
 
PlayerSection:NewSlider("Jumppower", "Changes the jumppower", 250, 50, function(v)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
end)

PlayerSection:NewToggle("Noclip", "On / Off", function(state)
    if state then
		noclip()
        print("Toggle On")
    else
		clip()
        print("Toggle Off")
    end
end)
-- Tool Tab
ToolsSection:NewButton("TpTool", "Teleport Tool", function()
	mouse = game.Players.LocalPlayer:GetMouse()
	tool = Instance.new("Tool")
	tool.RequiresHandle = false
	tool.Name = "Equip to Click TP"
	tool.Activated:connect(function()
		local pos = mouse.Hit+Vector3.new(0,2.5,0)
		pos = CFrame.new(pos.X,pos.Y,pos.Z)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
	end)
	tool.Parent = game.Players.LocalPlayer.Backpack
end)
-- More Tab
MoreSection:NewButton("ReJoin", "Rejoin On the Server", function()
	TeleportService:Teleport(game.PlaceId, LocalPlayer)
    print("Clicked")
end)
-- KeyBind GUI
MoreSection:NewKeybind("Toggle Gui", "Show / Hide Gui", Enum.KeyCode.LeftAlt, function()
	Library:ToggleUI()
end)
-- Credits
CreditSection:NewLabel("Created by : Настюшка#7777")
CreditSection:NewLabel("Idea by : LA_???#1000")
