local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Origane - Jailbreak", "Synapse")
local Player = Window:NewTab("Player")
local Tools = Window:NewTab("Tools")
local JBTab = Window:NewTab("Jailbreak")
local ESPtab = Window:NewTab("ESP")
local More = Window:NewTab("More")
local Credit = Window:NewTab("Credit")
local CreditSection = Credit:NewSection("Credit")
local JbSection = JBTab:NewSection("Jailbreak")
local ESPsection = ESPtab:NewSection("Esp Settings")
local MoreSection = More:NewSection("More")
local PlayerSection = Player:NewSection("Player")
local ToolsSection = Tools:NewSection("Tools")
-- Variables
local Players = game.Players:GetPlayers()
local h = game:GetService("ReplicatedStorage").Game.GunShop.GunShopUI
local UserInputService = game:GetService("UserInputService")
local runservice = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
--//Toggle\\--
getgenv().Toggle = false -- This toggles the esp, turning it to false will turn it off
getgenv().TC = true -- This toggles team check, turning it on will turn on team check
local PlayerName = "DisplayName" -- You can decide if you want the Player's name to be a display name which is "DisplayName", or username which is "Name"

--//Variables\\--
local P = game:GetService("Players")
local LP = P.LocalPlayer

--//Debounce\\--
local DB = false
local infjumpenabled = false
local Noclip = nil
local Clip = nil
local HoldEBypass = false
local moduleui = require(game.ReplicatedStorage.Module.UI)
local themes = {
    SchemeColor = Color3.fromRGB(74, 99, 135),
    Background = Color3.fromRGB(36, 37, 43),
    Header = Color3.fromRGB(28, 29, 34),
    TextColor = Color3.fromRGB(255,255,255),
    ElementColor = Color3.fromRGB(32, 32, 38)
}
--/ max distance is 600 studs
getgenv().toggled = false--/ true & false

getgenv().old = getgenv().old or require(game:GetService("ReplicatedStorage").Module.RayCast).RayIgnoreNonCollideWithIgnoreList
-- Functions
function randomString()
	local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end
local function Aim()
    if getgenv().toggled then
		require(game:GetService("ReplicatedStorage").Module.RayCast).RayIgnoreNonCollideWithIgnoreList = function(...)
		local nearestDistance, nearestEnemy = 600, nil
     for i,v in pairs(game:GetService("Players"):GetPlayers()) do
      if v.Team ~= game:GetService("Players").LocalPlayer.Team and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
          if (v.Character.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < nearestDistance then
           nearestDistance, nearestEnemy = (v.Character.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude, v
          end
      end
     end
     local arg = {old(...)}
     if (tostring(getfenv(2).script) == "BulletEmitter" or tostring(getfenv(2).script) == "Taser") and nearestEnemy then
      arg[1] = nearestEnemy.Character.HumanoidRootPart
      arg[2] = nearestEnemy.Character.HumanoidRootPart.Position
  end
     return unpack(arg)
 end
else
 require(game:GetService("ReplicatedStorage").Module.RayCast).RayIgnoreNonCollideWithIgnoreList = getgenv().old
end
end
--//Function\\--
local ESP = function(PLR)
	local ESP = Instance.new("Highlight")

	ESP.Parent = PLR.Character
	ESP.Name = "Totally NOT Esp"
	ESP.Adornee = PLR.Character
	ESP.Archivable = true
	ESP.Enabled = true
	ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	ESP.FillColor = PLR.TeamColor.Color
	ESP.FillTransparency = 0.5
	ESP.OutlineColor = Color3.fromRGB(255, 255, 255)
	ESP.OutlineTransparency = 0
end

local ESPT = function(PLR)
	--//ESP-Text\\--
	local Icon = Instance.new("BillboardGui")
	local ESPText = Instance.new("TextLabel")

	Icon.Parent = PLR.Character
	Icon.Name = "Icon"
	Icon.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Icon.Active = true
	Icon.AlwaysOnTop = true
	Icon.ExtentsOffset = Vector3.new(0, 1, 0)
	Icon.LightInfluence = 1.000
	Icon.Size = UDim2.new(0, 800, 0, 50)

	ESPText.Name = "ESP Text"
	ESPText.Parent = Icon
	ESPText.BackgroundColor3 = PLR.TeamColor.Color
	ESPText.BackgroundTransparency = 1.000
	ESPText.Size = UDim2.new(0, 800, 0, 50)
	ESPText.Font = Enum.Font.SciFi
	--ESPText.Text = "Name: "..PLR[PlayerName].." | Health: "..PLR.Character:FindFirstChildOfClass("Humanoid").Health
	ESPText.Text = "NIL"
	ESPText.TextColor3 = PLR.TeamColor.Color
	ESPText.TextSize = 18.000
	ESPText.TextWrapped = true
end

local ESPTF = function(PLR, ICON)
	local ESPText = Instance.new("TextLabel")

	ESPText.Name = "ESP Text"
	ESPText.Parent = ICON
	ESPText.BackgroundColor3 = PLR.TeamColor.Color
	ESPText.BackgroundTransparency = 1.000
	ESPText.Size = UDim2.new(0, 800, 0, 50)
	ESPText.Font = Enum.Font.SciFi
	--ESPText.Text = "Name: "..PLR[PlayerName].." | Health: "..PLR.Character:FindFirstChildOfClass("Humanoid").Health
	ESPText.Text = "NIL"
	ESPText.TextColor3 = PLR.TeamColor.Color
	ESPText.TextSize = 18.000
	ESPText.TextWrapped = true
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
-- Player Tab

PlayerSection:NewSlider("Walkspeed", "Changes the walkspeed", 250, 16, function(v)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)
 
PlayerSection:NewSlider("Jumppower", "Changes the jumppower", 250, 50, function(v)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
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

PlayerSection:NewButton("Godmode", "Inf Health", function()
	local Player = game.Players.LocalPlayer
	local Character = Player.Character
	local Humanoid = Character.Humanoid
 
	print('Godmode working.')
 
	Humanoid.MaxHealth = 999999
	Humanoid.Health = Humanoid.MaxHealth / 2
 
	Humanoid.HealthChanged:connect(function()
    if Humanoid.Health < 10 then
        Humanoid.Health = Humanoid.MaxHealth
    end
end)
    print("GodMode Enabled")
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
-- Jailbreak Tab
JbSection:NewButton("Free Keycard", "Open keycard's doors", function()
	local plrUtils = game:GetService("ReplicatedStorage").Game.PlayerUtils
	require(plrUtils).hasKey = function() 
		return true
	end
end)
JbSection:NewToggle("No E Wait", "Bypass colldown [Except : AirDrop, Gas Station, Donut Shop]", function(state)
    if state then
		for i,a in pairs(moduleui.CircleAction.Specs) do
			if a.Duration ~= false and a.Name ~= "Rob" and a.Name ~= "Open Crate" then
				a.Timed = false;
			end
		end
    else
		for i,a in pairs(moduleui.CircleAction.Specs) do
			if a.Duration ~= false and a.Name ~= "Rob" and a.Name ~= "Open Crate" then
				a.Timed = true;
			end
		end
    end
end)
JbSection:NewButton("Get All weapons [Only Owned]", "Get owned weapons", function()
    for i,v in pairs(workspace:GetDescendants()) do
        if v:IsA("ClickDetector") then
        fireclickdetector(v)
        end
    end
end)
JbSection:NewToggle("GunShop UI [Soon]", "On / Off", function(state)
    if state then
		--require(h).open()
    else
		--require(h).close()
    end
end)
JbSection:NewToggle("Silent Aim", "Work ONLY 600 studs", function(state)
	if state then
		getgenv().toggled = true
        Aim()
	else
		getgenv().toggled = false
        Aim()
	end
end)
local texXt = JbSection:NewLabel("Casino Code [Here]")
JbSection:NewButton("Get Casino Code", "Casino Code", function()
	local codes = workspace.Casino.RobberyDoor.Codes
	local code
	for i,v in pairs(codes:GetChildren()) do
		if v:FindFirstChildOfClass("Part").SurfaceGui.TextLabel.Text ~= "" then
		    code = v
		    break
		end
	end
	
	local txt = ""
	if code then
		local c = {}
		
		for i,v in pairs(code:GetChildren()) do
		    table.insert(c, v.Position.Magnitude)
		end
		
		table.sort(c)
		for i,v in pairs(c) do
			for i, cpart in pairs(code:GetChildren()) do
				if v == cpart.Position.Magnitude then
					txt = txt..cpart.SurfaceGui.TextLabel.Text
				end
			end
		end
		texXt:UpdateLabel(txt.." (or "..txt:reverse()..")")
		wait(2)
		texXt:UpdateLabel("Copied to clipboard!")
		setclipboard(txt.." (or "..txt:reverse()..")")
		wait(2)
		texXt:UpdateLabel("Casino Code [Here]")
	else
		texXt:UpdateLabel("code non-existent")
		wait(2)
		texXt:UpdateLabel("Casino Code [Here]")
	end
	
	delay(5,function()
		texXt:UpdateLabel(ctxt)
	end)
end)
-- Esp Tab
ESPsection:NewToggle("Esp Enabled", "On / Off", function(state)
    if state then 
        getgenv().Toggle = true
    else
        getgenv().Toggle = false
    end
end)
ESPsection:NewToggle("Team Check", "On / Off", function(state)
    if state then 
        _G.TeamCheck = true
    else
        _G.TeamCheck = false
    end
end)
ESPsection:NewSlider("TextSize", "Changes the size text", 30, 14, function(v)
    _G.TextSize = v
end)
ESPsection:NewSlider("TextTransparency", "Changes the Transparency text", 1, 0.1, function(v)
    _G.TextTransparency = v
end)
-- More Tab
MoreSection:NewButton("ReJoin", "Rejoin On the Server", function()
	TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)
-- KeyBind GUI
MoreSection:NewKeybind("Toggle Gui", "Show / Hide Gui", Enum.KeyCode.LeftAlt, function()
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
print("Loaded Gui")
end)
-- Color Picker
local PickerTheme = More:NewSection("Custom Theme")
for theme, color in pairs(themes) do
    PickerTheme:NewColorPicker(theme, "Change your "..theme, color, function(color3)
        Library:ChangeColor(theme, color3)
    end)
end
-- Credits
CreditSection:NewButton("Created by : LA_Jere2009#0067", "Click to copy", function()
	setclipboard("LA_Jere2009#0067")
end)
CreditSection:NewButton("Idea by : LA_???#8974", "Click to copy", function()
	setclipboard("LA_???#8974")
end)
-- Esp Loop --
while task.wait() do
	if not getgenv().Toggle then
		break
	end
	if DB then 
		return 
	end
	DB = true

	pcall(function()
		for i,v in pairs(P:GetChildren()) do
			if v:IsA("Player") then
				if v ~= game:GetService("Players").LocalPlayer then
					if v.Character ~= nil then

						if getgenv().TC == false and v.Character:FindFirstChild("Totally NOT Esp") == nil then
							ESP(v)
						else
							if getgenv().TC == false and v.Character:FindFirstChild("Icon") == nil then
								ESPT(v)
							else
								if getgenv().TC == false and v.Character.Icon:FindFirstChild("ESP Text") == nil then
									ESPTF(v, v.Character.Icon)
								else
									if v.Character:FindFirstChild("Totally NOT Esp").Enabled == false then
										v.Character:FindFirstChild("Totally NOT Esp").Enabled = true
									else
										if v.Character:FindFirstChild("Icon").Enabled == false then
											v.Character:FindFirstChild("Icon").Enabled = true
										else
											if v.Character:FindFirstChild("Icon") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") ~= nil then
												local pos = math.floor(((game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")).Position - (v.Character:FindFirstChild("HumanoidRootPart")).Position).magnitude)
												-- Credits to Infinite Yield for this part (pos) ^^^^^^
												v.Character.Icon["ESP Text"].Text = "Name: "..v[PlayerName].." | Health: "..v.Character:FindFirstChildOfClass("Humanoid").Health.." | Distance: "..pos
											else
												if v.Character:FindFirstChild("Icon") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil then
													v.Character.Icon["ESP Text"].Text = "Name: "..v[PlayerName].." | Health: "..v.Character:FindFirstChildOfClass("Humanoid").Health
												else
													if getgenv().TC == true and v.TeamColor ~= game.Players.LocalPlayer.TeamColor and v.Character:FindFirstChild("Totally NOT Esp") == nil then
														ESP(v)
													else
														if getgenv().TC == true and v.TeamColor ~= game.Players.LocalPlayer.TeamColor and v.Character:FindFirstChild("Icon") == nil then
															ESPT(v)
														else
															if getgenv().TC == true and v.TeamColor ~= game.Players.LocalPlayer.TeamColor and v.Character.Icon:FindFirstChild("ESP Text") == nil then
																ESPTF(v, v.Character.Icon)
															else
																if getgenv().TC == true and v.Character:FindFirstChild("Totally NOT Esp").FillColor ~= v.TeamColor.Color then
																	v.Character:FindFirstChild("Totally NOT Esp").FillColor = v.TeamColor.Color
																else
																	if getgenv().TC == true and v.Character.Icon:FindFirstChild("ESP Text").TextColor3 ~= v.TeamColor.Color then
																		v.Character.Icon["ESP Text"].TextColor3 = v.TeamColor.Color
																	end
																end
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end)

	wait()

	DB = false
end
