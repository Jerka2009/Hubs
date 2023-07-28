local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Organic - MM2", "Synapse")
local Player = Window:NewTab("Player")
local MM2Menu = Window:NewTab("MM2")
local Tools = Window:NewTab("Tools")
local More = Window:NewTab("More")
local Credit = Window:NewTab("Credit")
local CreditSection = Credit:NewSection("Credit")
local MoreSection = More:NewSection("More")
local MM2Section = MM2Menu:NewSection("MM2")
local PlayerSection = Player:NewSection("Player")
local ToolsSection = Tools:NewSection("Tools")
-- Variables
local Players = game.Players:GetPlayers()
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local infjumpenabled = false
local printvar = false
local MapsTable = {"Bank2", "Mansion2", "Hospital3", "Hotel2", "House2", "MilBase", "nStudio", "Office3", "PoliceStation", "ResearchFacility", "Workplace"}
local player = game:GetService("Players").LocalPlayer
local Noclip = nil
local Clip = nil
_G.ESP = false
local teamname = "None"
local murderer = "None"
local sheriff = "None"
local themes = {
    SchemeColor = Color3.fromRGB(74, 99, 135),
    Background = Color3.fromRGB(36, 37, 43),
    Header = Color3.fromRGB(28, 29, 34),
    TextColor = Color3.fromRGB(255,255,255),
    ElementColor = Color3.fromRGB(32, 32, 38)
}
-- Starting
local plr = game:GetService("Players").LocalPlayer
if plr:FindFirstChild("HasKey") ~= nil then
	if plr:FindFirstChild("HasKey").Value == false then
		plr:Kick("Invalid key!")
	end
end
-- Functions
function Create(base, colors1, colors2, colors3, teamname) --For all esps
	--local tag = Instance.new("Highlight")
	--tag.Enabled = _G.ESP
	--tag.Parent = base.Parent
	--tag.Name = "ESPk"
	--tag.FillTransparency = 0.55
	--tag.FillColor = Color3.fromRGB(colors1, colors2, colors3)
	--tag.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	local bb = Instance.new("BillboardGui",player.PlayerGui)
	bb.Adornee = base
	bb.ExtentsOffset = Vector3.new(0,1,0)
	bb.AlwaysOnTop = true
	bb.Size = UDim2.new(0,5,0,5)
	bb.StudsOffset = Vector3.new(0,1,0)
	bb.Name = "tracker"
	local txtlbl = Instance.new("TextLabel",bb)
	txtlbl.ZIndex = 10
	txtlbl.Text = teamname
	txtlbl.BackgroundTransparency = 1
	txtlbl.Position = UDim2.new(0,0,0,-35)
	txtlbl.Size = UDim2.new(1,0,10,0)
	txtlbl.Font = "ArialBold"
	txtlbl.FontSize = "Size12"
	txtlbl.TextStrokeTransparency = 0.5
	txtlbl.TextColor3 = Color3.fromRGB(colors1, colors2, colors3)
end

function UpdateColor(v)
	if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
		local colors1 = 255
		local colors2 = 0
		local colors3 = 0
		v.Character:FindFirstChild("ESPk").FillColor = Color3.fromRGB(colors1, colors2, colors3)
	elseif v.Backpack:FindFirstChild("Gun") or v.Backpack:FindFirstChild("Revolver") or v.Character:FindFirstChild("Gun") or v.Character:FindFirstChild("Revolver") then
		local colors1 = 0
		local colors2 = 0
		local colors3 = 255
		v.Character:FindFirstChild("ESPk").FillColor = Color3.fromRGB(colors1, colors2, colors3)
	else
		local colors1 = 0
		local colors2 = 255
		local colors3 = 0
		v.Character:FindFirstChild("ESPk").FillColor = Color3.fromRGB(colors1, colors2, colors3)
	end
end

function randomString()
	local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

function SendNotifi(TTitle, text, timed)
	game.StarterGui:SetCore("SendNotification", {
		Title = TTitle;
		Text = text;
		Icon = "rbxassetid://2328131581";
		Duration = timed;
	})
end

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

function GrabGun()
	if game.Workspace.GunDrop.CFrame ~= nil then
		local lastCF = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
		wait(0.1)
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.GunDrop.CFrame
		wait(0.5)
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = lastCF
	else
		SendNotifi("Warning", "Gun is not dropped!", 3)
		if printvar == true then
			print("Gun not currently dropped")
		end
	end 
end

function findmurderer() --Find who the murderer is
	local colors1 = 255
	local colors2 = 0
	local colors3 = 0
	for i, v in pairs(game:GetService("Players"):GetChildren()) do
		if v ~= game:GetService("Players").LocalPlayer then
			if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
				if v.Character:FindFirstChild("ESPk") == nil then
					local teamname = v.Name
					murderer = v.Name
					Create(v.Character.Head, colors1, colors2, colors3, teamname)
				else
					local teamname = v.Name
					murderer = v.Name
					UpdateColor(v)
				end
			end
		end
	end
end
	
function findsheriff() --Find who the sheriff is
	local colors1 = 0
	local colors2 = 0
	local colors3 = 255
	for i, v in pairs(game:GetService("Players"):GetChildren()) do
		if v ~= game:GetService("Players").LocalPlayer then
			if v.Backpack:FindFirstChild("Gun") or v.Backpack:FindFirstChild("Revolver") or v.Character:FindFirstChild("Gun") or v.Character:FindFirstChild("Revolver") then
				if v.Character:FindFirstChild("ESPk") == nil then
					local teamname = v.Name
					sheriff = v.Name
					Create(v.Character.Head, colors1, colors2, colors3, teamname)
				else
					local teamname = v.Name
					sheriff = v.Name
					--UpdateColor(v)
				end
			end
		end
	end
end

function findplayers() --Find all players but local player
	findmurderer() --Finds murderer
	findsheriff() --Finds sheriff
	local colors1 = 0
	local colors2 = 255
	local colors3 = 0
	for i, v in pairs(game:GetService("Players"):GetChildren()) do
		if v ~= game:GetService("Players").LocalPlayer then --If not local player
			if v.Name ~= murderer then --If not murderer
				if v.Name ~= sheriff then --If not sheriff
					if v.Character:FindFirstChild("ESPk") == nil then
						local teamname = v.Name
						Create(v.Character.Head, colors1, colors2, colors3, teamname)
					else
						local teamname = v.Name
						--UpdateColor(v)
					end
				end
			end
		end
	end
end

function Clear() --Clears all the esps
	for _,g in pairs(game.Players:GetPlayers()) do
		if g.Character:FindFirstChild("ESPk") then
			g.Character:FindFirstChild("ESPk"):Destroy()
		end
	end
	for _,v in pairs(player.PlayerGui:children()) do
		if v.Name == "tracker" and v:isA("BillboardGui") then
			v:Destroy()
		end
	end
end

function UpdateESP()
	murderer = "None"
	sheriff = "None"
	findplayers()
	--UpdateColor()
	findmurderer()
	findsheriff()
	for _,v in pairs(player.PlayerGui:children()) do
		if v.Name == "tracker" and v:isA("BillboardGui") then
			if v:FindFirstChild("TextLabel").Text == sheriff then
				v:FindFirstChild("TextLabel").TextColor3 = Color3.fromRGB(0,0,255)
			elseif v:FindFirstChild("TextLabel").Text == murderer then
				v:FindFirstChild("TextLabel").TextColor3 = Color3.fromRGB(255,0,0)
			else
				v:FindFirstChild("TextLabel").TextColor3 = Color3.fromRGB(0,255,0)
			end
		end
	end
end

function Enabl()
	while wait(2) do
		if _G.ESP == true then
			UpdateESP()
		else
			Clear()
		end
	end
end

player.CharacterAdded:Connect(function(char)
	coroutine.wrap(Enabl)() --// Don't forget to call it!
end)

UserInputService.InputBegan:Connect(function(key, busy)
	if key.KeyCode == Enum.KeyCode.G and not busy then
		GrabGun()
	end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
	if infjumpenabled == true then
		game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):ChangeState("Jumping")
	end
end)

function infJumpOn()
	infjumpenabled = true
end

function infJumpOff()
	infjumpenabled = false
end

function clip()
	if Noclip then Noclip:Disconnect() end
	Clip = true
end
game:GetService("Workspace").ChildAdded:Connect(function(part)
	if part.Name == "GunDrop" then
		if _G.ESP == true then
			local tag = Instance.new("Highlight")
			tag.Enabled = _G.ESP
			tag.Parent = part
			tag.Name = "GunESP"
			tag.FillTransparency = 0.55
			tag.FillColor = Color3.fromRGB(169, 51, 255)
			tag.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		end
	end
end)
-- Player Tab

PlayerSection:NewSlider("Walkspeed", "Changes the walkspeed", 250, 16, function(v)
    game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = v
end)
 
PlayerSection:NewSlider("Jumppower", "Changes the jumppower", 250, 50, function(v)
    game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = v
end)

PlayerSection:NewSlider("Spin Speed", "Changes the speed", 500, 100, function(v)
    _G.SpinSpeedy = v
end)

PlayerSection:NewToggle("Spin", "On / Off", function(state)
    if state then
	local Spin = Instance.new("BodyAngularVelocity")
	Spin.Name = "Spinning"
	Spin.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
	Spin.MaxTorque = Vector3.new(0, math.huge, 0)
	Spin.AngularVelocity = Vector3.new(0,_G.SpinSpeedy,0)
    else
	game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spinning"):Destroy()
    end
end)

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
end)

PlayerSection:NewButton("Fly [E]", "Press 'E' to fly", function()
	repeat wait() 
	until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("UpperTorso") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid") 
local mouse = game.Players.LocalPlayer:GetMouse() 
repeat wait() until mouse
local plr = game.Players.LocalPlayer 
local torso = plr.Character.UpperTorso 
local flying = true
local deb = true 
local ctrl = {f = 0, b = 0, l = 0, r = 0} 
local lastctrl = {f = 0, b = 0, l = 0, r = 0} 
local maxspeed = 120 
local speed = 0 
 
function Fly() 
local bg = Instance.new("BodyGyro", torso) 
bg.P = 9e4 
bg.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
bg.cframe = torso.CFrame 
local bv = Instance.new("BodyVelocity", torso) 
bv.velocity = Vector3.new(0,0.1,0) 
bv.maxForce = Vector3.new(9e9, 9e9, 9e9) 
repeat wait() 
plr.Character.Humanoid.PlatformStand = true 
if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then 
speed = speed+.5+(speed/maxspeed) 
if speed > maxspeed then 
speed = maxspeed 
end 
elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then 
speed = speed-1 
if speed < 0 then 
speed = 0 
end 
end 
if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then 
bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r} 
elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then 
bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
else 
bv.velocity = Vector3.new(0,0.1,0) 
end 
bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0) 
until not flying 
ctrl = {f = 0, b = 0, l = 0, r = 0} 
lastctrl = {f = 0, b = 0, l = 0, r = 0} 
speed = 0 
bg:Destroy() 
bv:Destroy() 
plr.Character.Humanoid.PlatformStand = false 
end 
mouse.KeyDown:connect(function(key) 
if key:lower() == "e" then 
if flying then flying = false 
else 
flying = true 
Fly() 
end 
elseif key:lower() == "w" then 
ctrl.f = 1 
elseif key:lower() == "s" then 
ctrl.b = -1 
elseif key:lower() == "a" then 
ctrl.l = -1 
elseif key:lower() == "d" then 
ctrl.r = 1 
end 
end) 
mouse.KeyUp:connect(function(key) 
if key:lower() == "w" then 
ctrl.f = 0 
elseif key:lower() == "s" then 
ctrl.b = 0 
elseif key:lower() == "a" then 
ctrl.l = 0 
elseif key:lower() == "d" then 
ctrl.r = 0 
end 
end)
Fly()
end)

PlayerSection:NewToggle("InfJump", "On / Off", function(state)
    if state then
		infJumpOn()
        print("infJump On")
    else
		infJumpOff()
        print("infJump Off")
    end
end)

PlayerSection:NewToggle("Noclip", "On / Off", function(state)
    if state then
		noclip()
        print("Noclip On")
    else
		clip()
        print("Noclip Off")
    end
end)
-- MM2 Tab
MM2Section:NewButton("Tp to map", "Teleporter", function()
	for i, map in pairs(MapsTable) do
		if game:GetService("Workspace"):FindFirstChild(map) then
			local CFM = game:GetService("Workspace"):FindFirstChild(map).Spawns.Spawn.CFrame
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFM
		else
			print("Map is not found..")
			break
		end
	end
end)
MM2Section:NewButton("Tp to Lobby", "Teleporter", function()
	local CFM = CFrame.new(game:GetService("Workspace"):FindFirstChild("Lobby").Spawns.Spawn.Position + Vector3.new(0,2,0))
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFM
end)
MM2Section:NewButton("Teleport to gun [G]", "TP to gun", function()
	GrabGun()
end)
MM2Section:NewToggle("Esp [On/Off]", "Turn on/off", function(state)
	if state then
		_G.ESP = true
		coroutine.wrap(Enabl)() --// Don't forget to call it!
	else
		_G.ESP = false
		Clear()
	end
end)
-- Tool Tab
ToolsSection:NewButton("TpTool", "Teleport Tool", function()
	mouse = game.Players.LocalPlayer:GetMouse()
	tool = Instance.new("Tool")
	tool.RequiresHandle = false
	tool.Name = "Teleport Tool"
	tool.Activated:connect(function()
		local pos = mouse.Hit+Vector3.new(0,2.5,0)
		pos = CFrame.new(pos.X,pos.Y,pos.Z)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
	end)
	tool.Parent = game.Players.LocalPlayer.Backpack
end)
ToolsSection:NewButton("Btools", "Btools [Visual]", function()
	backpack = game:GetService("Players").LocalPlayer.Backpack

	hammer = Instance.new("HopperBin")
	hammer.Name = "Hammer"
	hammer.BinType = 4
	hammer.Parent = backpack

	cloneTool = Instance.new("HopperBin")
	cloneTool.Name = "Clone"
	cloneTool.BinType = 3
	cloneTool.Parent = backpack

	grabTool = Instance.new("HopperBin")
	grabTool.Name = "Grab"
	grabTool.BinType = 2
	grabTool.Parent = backpack
end)
-- More Tab
MoreSection:NewButton("Fuck Menu", "Fuck players!", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/vova999000333/Hubs/main/BangScript.lua"))()
end)
MoreSection:NewButton("Bhop [Need R15]", "Click to Execute", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/vova999000333/Hubs/main/Bhop.lua"))()
end)
MoreSection:NewButton("ReJoin", "Rejoin On the Server", function()
	TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)
-- KeyBind GUI
MoreSection:NewKeybind("Toggle Gui", "Show / Hide Gui", Enum.KeyCode.X, function()
	Library:ToggleUI()
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
