local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jerka2009/Hubs/main/UI-LibraryOrganic.lua"))()
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
local Players = game:GetService("Players"):GetPlayers()
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local infjumpenabled = false
local ESP = false
local PlayersList = {}
local printvar = false
local murderer = "None"
local sheriff = "None"
local ControlPlayerNick = ""
local player = game:GetService("Players").LocalPlayer
local Noclip = nil
local Clip = nil
local themes = {
    SchemeColor = Color3.fromRGB(74, 99, 135),
    Background = Color3.fromRGB(36, 37, 43),
    Header = Color3.fromRGB(28, 29, 34),
    TextColor = Color3.fromRGB(255,255,255),
    ElementColor = Color3.fromRGB(32, 32, 38)
}
-- Starting
local plr = game:GetService("Players").LocalPlayer

local function SendNotify(title, message, duration)
	game:GetService("StarterGui"):SetCore("SendNotification", {Title = title,Text = message,Duration = duration;})
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
		if Clip == false and game:GetService("Players").LocalPlayer.Character ~= nil then
			for _,v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
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
	if workspace.GunDrop.CFrame ~= nil then
		local lastCF = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
		wait(0.1)
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").GunDrop.CFrame
		wait(0.5)
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = lastCF
	else
		SendNotifi("Warning", "Gun is not dropped!", 3)
		if printvar == true then
			print("Gun not currently dropped")
		end
	end 
end

function KillAll()
	local Players = game:GetService("Players")	
	if plr.Character:FindFirstChild("Knife") then
		for i, Victim in pairs(Players:GetPlayers()) do
			if Victim.Name ~= Players.LocalPlayer.Name then
				repeat wait(0.1)
					Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Victim.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
					plr.Character:FindFirstChild("Knife"):Activate()
				until
					Victim.Character.Humanoid.Health == 0
			end
		end
	else
		SendNotify("Organic MM2","You're not a murderer",3)
	end
end

function getRoleColor(plr)
	if (plr.Backpack:FindFirstChild("Knife") or plr.Character:FindFirstChild("Knife")) then
		return Color3.new(255, 0, 0)
	elseif (plr.Backpack:FindFirstChild("Gun") or plr.Character:FindFirstChild("Gun")) then
		return Color3.new(0, 0, 255)
	elseif (plr.Backpack:FindFirstChild("Gun") or plr.Character:FindFirstChild("Gun")) and plr.Name ~= sheriff then
		return Color3.new(255, 255, 0)
	else
		return Color3.new(0, 255, 0)
	end
 end

function Clear() --Clears all the esps
	for _, g in pairs(game:GetService("Players"):GetChildren()) do
		if g.Character:FindFirstChild("TadachiisESPTags") and g.Character:FindFirstChild("Highlight") then
			g.Character:FindFirstChild("TadachiisESPTags"):Destroy()
			g.Character:FindFirstChild("Highlight"):Destroy()
		end
	end
end

function UpdateESP()
	for _, v in pairs(game:GetService("Players"):GetChildren()) do
		if v ~= game:GetService("Players").LocalPlayer and v.Character and not v.Character:FindFirstChild("TadachiisESPTags") and not v.Character:FindFirstChild("Highlight") then
            local billboardGui = Instance.new("BillboardGui")
            billboardGui.Name = "TadachiisESPTags" -- Use the correct name for the BillboardGui
            billboardGui.Adornee = v.Character.Head
            billboardGui.Size = UDim2.new(0, 100, 0, 50) -- fixed size for the BillboardGui
            billboardGui.StudsOffset = Vector3.new(0, 2, 0) -- adjust the vertical offset as needed
            billboardGui.AlwaysOnTop = true
            billboardGui.LightInfluence = 1
            billboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            billboardGui.Parent = v.Character
	
            local textLabel = Instance.new("TextLabel")
            textLabel.Name = "NameLabel" -- Use the correct name for the label
            textLabel.Text = "@"..v.Name.." ( "..v.DisplayName.." )"
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1 -- transparent background
            textLabel.TextColor3 = getRoleColor(v)
            textLabel.TextScaled = true
            textLabel.TextStrokeColor3 = Color3.new(0, 0, 0) -- black text stroke
            textLabel.TextStrokeTransparency = 0 -- fully opaque text stroke (visible through walls)
            textLabel.Visible = true -- ESP is always visible without a GUI
            textLabel.Parent = billboardGui

			Instance.new("Highlight", v.Character)
           	v.Character.Highlight.FillTransparency = 0.9
           	v.Character.Highlight.OutlineTransparency = 0.9
           	v.Character.Highlight.FillColor = getRoleColor(v)

        elseif (v ~= game:GetService("Players").LocalPlayer and v.Character and v.Character:FindFirstChild("TadachiisESPTags") and v.Character:FindFirstChild("Highlight")) then
			v.Character:FindFirstChild("TadachiisESPTags").NameLabel.TextColor3 = getRoleColor(v)
			v.Character.Highlight.FillColor = getRoleColor(v)
        end
	end
end
game:GetService("ReplicatedStorage").Remotes.Gameplay.RoundEndFade.OnClientEvent:Connect(function()
	murderer = "None"
	sheriff = "None"
end)

game:GetService("ReplicatedStorage").Remotes.Gameplay.RoundStart.OnClientEvent:Connect(function()
	print("Round started!")
	print("Finding a murder with sheriff...")
	for _, v in pairs(game:GetService("Players"):GetPlayers()) do
		if (v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife")) then
			murderer = v.Name
		elseif (v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun")) then
			sheriff = v.Name
		end
	end
	if murderer ~= "None" and sheriff ~= "None" then
		print("All founded!")
	end
end)

UserInputService.InputBegan:Connect(function(key, busy)
	if key.KeyCode == Enum.KeyCode.G and not busy then
		GrabGun()
	end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
	if infjumpenabled == true then
		game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid"):ChangeState("Jumping")
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
    game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = v
end)
 
PlayerSection:NewSlider("Jumppower", "Changes the jumppower", 250, 50, function(v)
    game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = v
end)

PlayerSection:NewSlider("Spin Speed", "Changes the speed", 120, 100, function(v)
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
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:WaitForChild("Spinning"):Destroy()
    end
end)

for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
	table.insert(PlayersList, plr.Name)
end
local dropPlayer = PlayerSection:NewDropdown("Player", "PlayerList", PlayersList, function(currentOption)
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

PlayerSection:NewButton("Teleport to player", "tp to player", function()
	local ptp = game:GetService("Players"):FindFirstChild(ControlPlayerNick)
	local char = ptp.Character
	local humRoot = char:WaitForChild("HumanoidRootPart")
	local plrw = LocalPlayer
	local char1 = plrw.Character
	local humRoot1 = char1:WaitForChild("HumanoidRootPart")
	humRoot1.CFrame = humRoot.CFrame
end)

PlayerSection:NewButton("Fly [E]", "Press 'E' to fly", function()
	repeat wait() 
	until game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:findFirstChild("UpperTorso") and game:GetService("Players").LocalPlayer.Character:findFirstChild("Humanoid") 
	local mouse = game:GetService("Players").LocalPlayer:GetMouse() 
	repeat wait() until mouse
	local plr = game:GetService("Players").LocalPlayer 
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
	local Workplace = workspace:GetChildren()
	for i, Thing in pairs(Workplace) do
		local ThingChildren = Thing:GetChildren()
		for i, Child in pairs(ThingChildren) do
			if Child.Name == "Spawns" then
				game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = Child.Spawn.CFrame
			end
		end
	end
end)
MM2Section:NewButton("Tp to Lobby", "Teleporter", function()
	local CFM = CFrame.new(game:GetService("Workspace").Lobby.VotePads.Detector2.Position + Vector3.new(0,2,0))
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFM
end)
MM2Section:NewButton("Teleport to gun [G]", "TP to gun", function()
	GrabGun()
end)
MM2Section:NewButton("Kill all", "Only for murderer", function()
	KillAll()
end)
MM2Section:NewButton("Blurt Roles", "message roles", function()
	if murderer ~= "" and sheriff ~= "" then
		game.StarterGui:SetCore("SendNotification", {
			Title = "Murder!";
			Text = "Player "..murderer.." is murder!";
			Icon = "11745872952";
			Duration = "3";
		})
		game.StarterGui:SetCore("SendNotification", {
			Title = "Sheriff!";
			Text = "Player "..sheriff.." is sheriff!";
			Icon = "11745872952";
			Duration = "3";
		})
	end
end)
MM2Section:NewToggle("Esp [On/Off]", "Turn on/off", function(state)
	if state then
		ESP = true
	else
		ESP = false
		Clear()
	end
end)
-- Tool Tab
ToolsSection:NewButton("TpTool", "Teleport Tool", function()
	mouse = game:GetService("Players").LocalPlayer:GetMouse()
	tool = Instance.new("Tool")
	tool.RequiresHandle = false
	tool.Name = "Teleport Tool"
	tool.Activated:connect(function()
		local pos = mouse.Hit+Vector3.new(0,2.5,0)
		pos = CFrame.new(pos.X,pos.Y,pos.Z)
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = pos
	end)
	tool.Parent = game:GetService("Players").LocalPlayer.Backpack
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
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Jerka2009/Hubs/main/BangScript.lua"))()
end)
MoreSection:NewButton("Bhop [Need R15]", "Click to Execute", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Jerka2009/Hubs/main/Bhop.lua"))()
end)
MoreSection:NewButton("ReJoin", "Rejoin On the Server", function()
	TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)
MoreSection:NewButton("Radio Gui", "Play your own sounds [Visual]", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Jerka2009/Hubs/main/MusicGui.lua"))()
end)
-- KeyBind GUI
MoreSection:NewKeybind("Toggle Gui", "Show / Hide Gui", Enum.KeyCode.X, function()
	Library:ToggleUI()
end)
-- Color Picker
local PickerTheme = More:NewSection("Custom Theme")
for theme, color in pairs(themes) do
    PickerTheme:NewColorPicker(theme, "Change your "..theme, color, function(color3)
        Library:ChangeColor(theme, color3)
    end)
end
-- Credits
CreditSection:NewButton("Created by : HomeWorkUSAFakeReal2022#1572", "Click to copy", function()
	setclipboard("HomeWorkUSAFakeReal2022#1572")
end)
CreditSection:NewButton("Idea by : Niky#8422", "Click to copy", function()
	setclipboard("Niky#8422")
end)
CreditSection:NewButton("ChatMessageIntro", "Click to send in rbx chat", function()
	local args = {[1] = "[Organic hub] Functional made by Jere2009",[2] = "All"}
	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
end)

game:GetService("RunService").Heartbeat:Connect(function()
	if ESP == true then
		UpdateESP()
		wait(0.1)
	end
	wait(0.1)
end)
