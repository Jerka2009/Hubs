local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Light = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local httprequest = (syn and syn.request) or (http and http.request) or http_request or request

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/vova999000333/Hubs/main/UI-LibraryOrganic.lua"))()
local Window = Library.CreateLib("Organic - Ragdoll Engine", "Serpent")
-- Tabs --
local Player = Window:NewTab("Player")
local REMenu = Window:NewTab("Ragdoll")
local TpMenu = Window:NewTab("Teleports")
local TargetTab = Window:NewTab("Target [BETA]")
local AnimMenu = Window:NewTab("Animations")
local Credit = Window:NewTab("Credits")
-- Sections --
local CreditSection = Credit:NewSection("Credits")
local RESection = REMenu:NewSection("Menu")
local TpSection = TpMenu:NewSection("Teleports")
local TargetSection = TargetTab:NewSection("--- Target ---")
local AnimSection = AnimMenu:NewSection("Animation packages")
local PlayerSection = Player:NewSection("Player")

local lab = TargetSection:NewLabel("Target : None")
local lab1 = TargetSection:NewLabel("UserId : None")
local lab2 = TargetSection:NewLabel("Age : None")

local plr = game:GetService("Players").LocalPlayer
local Players = game:GetService("Players")

local Chatmsg = ""

local Tfling = false
local Tview = false
local Tfocus = false
local Tbenx = false
local Theadsit = false
local Tstand = false
local tbp = false
local Tdoggy = false

local mouse = plr:GetMouse()
local ScriptWhitelist = {}
local ForceWhitelist = {}
local TargetedPlayer = nil
local FlySpeed = 50
local infjumpenabled = false
local PotionTool = nil
local SavedCheckpoint = nil
local MinesFolder = nil
local floatName;
local FreeEmotesEnabled = false
local CannonsFolders = {}

AntiRagdollFunction = nil
AntiMinesFunction = nil

IsSpammingMines = false

local LocalPlayer = game:GetService("Players").LocalPlayer
_G.SpinSpeedy = 0
local Clip = nil
local TouchFlingEnable = false

local function RandomChar()
	local length = math.random(1,5)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

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

local function GetPing()
	return (game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())/1000
end

local function GetPlayer(UserDisplay)
	if UserDisplay ~= "" then
		for i,v in pairs(Players:GetPlayers()) do
			if v.Name:lower():match(UserDisplay) or v.DisplayName:lower():match(UserDisplay) then
				return v
			end
		end
		return nil
	else
		return nil
	end
end

local function GetCharacter(Player)
	if Player.Character then
		return Player.Character
	end
end

local function GetRoot(Player)
	if GetCharacter(Player):FindFirstChild("HumanoidRootPart") then
		return GetCharacter(Player).HumanoidRootPart
	end
end

local function TeleportTO(posX,posY,posZ,player,method)
	pcall(function()
		if method == "safe" then
			task.spawn(function()
				for i = 1,30 do
					task.wait()
					GetRoot(plr).Velocity = Vector3.new(0,0,0)
					if player == "pos" then
						GetRoot(plr).CFrame = CFrame.new(posX,posY,posZ)
					else
						GetRoot(plr).CFrame = CFrame.new(GetRoot(player).Position)+Vector3.new(0,2,0)
					end
				end
			end)
		else
			GetRoot(plr).Velocity = Vector3.new(0,0,0)
			if player == "pos" then
				GetRoot(plr).CFrame = CFrame.new(posX,posY,posZ)
			else
				GetRoot(plr).CFrame = CFrame.new(GetRoot(player).Position)+Vector3.new(0,2,0)
			end
		end
	end)
end

local function UpdateTarget(player)
	pcall(function()
		if table.find(ForceWhitelist,player.UserId) then
			SendNotify("Organic hub","You cant target this player: @"..player.Name.." / "..player.DisplayName,5)
			player = nil
		end
	end)
	if (player ~= nil) then
		TargetedPlayer = player.Name
		lab:UpdateLabel("Target: @"..player.Name.."("..player.DisplayName..")")
		lab1:UpdateLabel("UserId: "..player.UserId)
		lab2:UpdateLabel("Age: "..player.AccountAge)
	else
		lab:UpdateLabel("Target: None")
		lab1:UpdateLabel("UserId: None")
		lab2:UpdateLabel("Age: None")
		TargetedPlayer = nil
		local Tfling = false
		local Tview = false
		local Tfocus = false
		local Tbenx = false
		local Theadsit = false
		local Tstand = false
		local tbp = false
		local Tdoggy = false
	end
end

local function PredictionTP(player,method)
	local root = GetRoot(player)
	local pos = root.Position
	local vel = root.Velocity
	GetRoot(plr).CFrame = CFrame.new((pos.X)+(vel.X)*(GetPing()*3.5),(pos.Y)+(vel.Y)*(GetPing()*2),(pos.Z)+(vel.Z)*(GetPing()*3.5))
	if method == "safe" then
		task.wait()
		GetRoot(plr).CFrame = CFrame.new(pos)
		task.wait()
		GetRoot(plr).CFrame = CFrame.new((pos.X)+(vel.X)*(GetPing()*3.5),(pos.Y)+(vel.Y)*(GetPing()*2),(pos.Z)+(vel.Z)*(GetPing()*3.5))
	end
end

local function Touch(x,root)
	pcall(function()
		x = x:FindFirstAncestorWhichIsA("Part")
		if x then
			if firetouchinterest then
				task.spawn(function()
					firetouchinterest(x, root, 1)
					task.wait()
					firetouchinterest(x, root, 0)
				end)
			end
		end
	end)
end


local function GetPush()
	local TempPush = nil
	pcall(function()
		if plr.Backpack:FindFirstChild("Push") then
			PushTool = plr.Backpack.Push
			PushTool.Parent = plr.Character
			TempPush = PushTool
		end
		for i,v in pairs(Players:GetPlayers()) do
			if v.Character:FindFirstChild("Push") then
				TempPush = v.Character.Push
			end
		end
	end)
	return TempPush
end

local function CheckPotion()
	if plr.Backpack:FindFirstChild("potion") then
		PotionTool = plr.Backpack:FindFirstChild("potion")
		return true
	elseif plr.Character:FindFirstChild("potion") then
		PotionTool = plr.Character:FindFirstChild("potion")
		return true
	else
		return false
	end
end

local function Push(Target)
	local Push = GetPush()
	local FixTool = nil
	if Push ~= nil then
		local args = {[1] = Target.Character}
		GetPush().PushTool:FireServer(unpack(args))
	end
	if plr.Character:FindFirstChild("Push") then
		plr.Character.Push.Parent = plr.Backpack
	end
	if plr.Character:FindFirstChild("ModdedPush") then
		FixTool = plr.Character:FindFirstChild("ModdedPush")
		FixTool.Parent = plr.Backpack
		FixTool.Parent = plr.Character
	end
	if plr.Character:FindFirstChild("ClickTarget") then
		FixTool = plr.Character:FindFirstChild("ClickTarget")
		FixTool.Parent = plr.Backpack
		FixTool.Parent = plr.Character
	end
	if plr.Character:FindFirstChild("potion") then
		FixTool = plr.Character:FindFirstChild("potion")
		FixTool.Parent = plr.Backpack
		FixTool.Parent = plr.Character
	end
end

local function ToggleFling(bool)
	task.spawn(function()
		if bool then
			TouchFlingEnable = true
			local RVelocity = nil
			repeat
				pcall(function()
					RVelocity = GetRoot(plr).Velocity 
					GetRoot(plr).Velocity = Vector3.new(math.random(-150,150),-25000,math.random(-150,150))
					RunService.RenderStepped:wait()
					GetRoot(plr).Velocity = RVelocity
				end)
				RunService.Heartbeat:wait()
			until TouchFlingEnable == false
		else
			TouchFlingEnable = false
		end
	end)
end

local function ToggleRagdoll(bool)
	pcall(function()
		plr.Character["Falling down"].Disabled = bool
		plr.Character["Swimming"].Disabled = bool
		plr.Character["StartRagdoll"].Disabled = bool
		plr.Character["Pushed"].Disabled = bool
		plr.Character["RagdollMe"].Disabled = bool
	end)
end

local function ToggleVoidProtection(bool)
	if bool then
		game:GetService("Workspace").FallenPartsDestroyHeight = 0/0
	else
		game:GetService("Workspace").FallenPartsDestroyHeight = -500
	end
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


local function PlayAnim(id,time,speed)
	pcall(function()
		plr.Character.Animate.Disabled = false
		local hum = plr.Character.Humanoid
		local animtrack = hum:GetPlayingAnimationTracks()
		for i,track in pairs(animtrack) do
			track:Stop()
		end
		plr.Character.Animate.Disabled = true
		local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://"..id
		local loadanim = hum:LoadAnimation(Anim)
		loadanim:Play()
		loadanim.TimePosition = time
		loadanim:AdjustSpeed(speed)
		loadanim.Stopped:Connect(function()
			plr.Character.Animate.Disabled = false
			for i, track in pairs (animtrack) do
				track:Stop()
			end
		end)
	end)
end

local function StopAnim()
	plr.Character.Animate.Disabled = false
	local animtrack = plr.Character.Humanoid:GetPlayingAnimationTracks()
	for i, track in pairs (animtrack) do
		track:Stop()
	end
end

local function SendNotify(title, message, duration)
	game:GetService("StarterGui"):SetCore("SendNotification", {Title = title,Text = message,Duration = duration;})
end

game:GetService("UserInputService").JumpRequest:Connect(function()
	if infjumpenabled == true then
		game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid"):ChangeState("Jumping")
	end
end)

-- Buttons, Labels, GUI and etc.

-- Player --
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
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Spinning"):Destroy()
	end
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

PlayerSection:NewButton("Send message", "Textbox should not be empty", function()
	if Chatmsg ~= "" and Chatmsg ~= nil then
		local sucess, err = pcall(function()
			local args = {[1] = Chatmsg,[2] = "All"}
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
		end)
			if err then
				local s, er = pcall(function()
				game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(Chatmsg)
			end)
		end
	end
end)
PlayerSection:NewTextBox("message...", "Type message to send in chat", function(txt)
	Chatmsg = txt
end)

-- Ragdoll

RESection:NewToggle("Anti ragdoll", "On / Off", function(state)
	ToggleRagdoll(true)
	if state then
		AntiRagdollFunction = GetRoot(plr).ChildAdded:Connect(function(Force)
			if Force.Name == "PushForce" then
				Force.MaxForce = Vector3.new(0,0,0)
				Force.Velocity = Vector3.new(0,0,0)
			end
		end)
	else
		ToggleRagdoll(false)
		AntiRagdollFunction:Disconnect()
	end
end)
RESection:NewButton("Remove LocalRagdoll", "Use every time after spawning", function()
	local ragdoll1 = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Local Ragdoll")
	if ragdoll1 then
		ragdoll1:Remove()
	end
end)
RESection:NewToggle("TouchFling", "On / Off", function(state)
	if state then
		local fixpos = GetRoot(plr).Position
		ToggleVoidProtection(true)
		ToggleFling(true)
		TeleportTO(fixpos.X,fixpos.Y,fixpos.Z,"pos","safe")
		ToggleVoidProtection(false)
	else
		ToggleFling(false)
	end
end)
RESection:NewToggle("Spam mines", "On / Off", function(state)
	if state then
		IsSpammingMines = true
		AntiMinesFunction = plr.Character.Head.ChildAdded:Connect(function(Force)
			if Force.Name == "BodyVelocity" then
				Force.MaxForce = Vector3.new(0,0,0)
				Force.Velocity = Vector3.new(0,0,0)
			end
		end)
		repeat task.wait(1)
			for i,v in pairs(MinesFolder:GetChildren()) do
				if v.Name == "Landmine" and v:FindFirstChild("HitPart") then
					pcall(function()
						Touch(v.HitPart.TouchInterest,GetRoot(plr))
					end)
				end
			end
		until IsSpammingMines == false
	else
		IsSpammingMines = false
		AntiMinesFunction:Disconnect()
	end
end)
RESection:NewButton("Break Cannons", "hahahah, dont sit in cannon", function()
	ToggleVoidProtection(true)
	TeleportTO(0,-10000,0,"pos")
	task.wait(GetPing()+0.1)
	ToggleVoidProtection(false)
	task.wait(GetPing()+0.1)
	for i,v in pairs(CannonsFolders[1]:GetChildren()) do
		if v.Name == "Cannon" then
			pcall(function()
				fireclickdetector(v.Cannon_Part.ClickDetector)
			end)
		end
	end
	for i,v in pairs(CannonsFolders[2]:GetChildren()) do
		if v.Name == "Cannon" then
			pcall(function()
				fireclickdetector(v.Cannon_Part.ClickDetector)
			end)
		end
	end
end)
RESection:NewButton("Push all", "Teleporting to all and pushing", function()
	local oldpos = GetRoot(plr).Position
	for i,v in pairs(Players:GetPlayers()) do
		pcall(function()
			if (v ~= plr) and (not table.find(ScriptWhitelist,v.UserId)) and (not table.find(ForceWhitelist,v.UserId)) then
				PredictionTP(v)
				task.wait(GetPing()+0.05)
				Push(v)
			end
		end)
	end
	TeleportTO(oldpos.X,oldpos.Y,oldpos.Z,"pos","safe")
end)
local flying = true
local deb = true
local ctrl = {f = 0, b = 0, l = 0, r = 0}
local lastctrl = {f = 0, b = 0, l = 0, r = 0}
local KeyDownFunction = nil
local KeyUpFunction = nil
RESection:NewToggle("Fly", "On / Off", function(state)
	if state then
		flying = true
		local UpperTorso = plr.Character.UpperTorso
		local speed = 0
		local function Fly()
			local bg = Instance.new("BodyGyro", UpperTorso)
			bg.P = 9e4
			bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
			bg.cframe = UpperTorso.CFrame
			local bv = Instance.new("BodyVelocity", UpperTorso)
			bv.velocity = Vector3.new(0,0.1,0)
			bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
			PlayAnim(10714347256,4,0)
			repeat task.wait()
				plr.Character.Humanoid.PlatformStand = true
				if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
					speed = speed+FlySpeed*0.10
					if speed > FlySpeed then
						speed = FlySpeed
					end
				elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
					speed = speed-FlySpeed*0.10
					if speed < 0 then
						speed = 0
					end
				end
				if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
					bv.velocity = ((game:GetService("Workspace").CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game:GetService("Workspace").CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game:GetService("Workspace").CurrentCamera.CoordinateFrame.p))*speed
					lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
				elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
					bv.velocity = ((game:GetService("Workspace").CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game:GetService("Workspace").CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game:GetService("Workspace").CurrentCamera.CoordinateFrame.p))*speed
				else
					bv.velocity = Vector3.new(0,0.1,0)
				end
				bg.cframe = game:GetService("Workspace").CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/FlySpeed),0,0)
			until not flying
			ctrl = {f = 0, b = 0, l = 0, r = 0}
			lastctrl = {f = 0, b = 0, l = 0, r = 0}
			speed = 0
			bg:Destroy()
			bv:Destroy()
			plr.Character.Humanoid.PlatformStand = false
		end

		KeyDownFunction = mouse.KeyDown:connect(function(key)
			if key:lower() == "w" then
				ctrl.f = 1
				PlayAnim(10714177846,4.65,0)
			elseif key:lower() == "s" then
				ctrl.b = -1
				PlayAnim(10147823318,4.11,0)
			elseif key:lower() == "a" then
				ctrl.l = -1
				PlayAnim(10147823318,3.55,0)
			elseif key:lower() == "d" then
				ctrl.r = 1
				PlayAnim(10147823318,4.81,0)
			end
		end)

		KeyUpFunction = mouse.KeyUp:connect(function(key)
			if key:lower() == "w" then
				ctrl.f = 0
				PlayAnim(10714347256,4,0)
			elseif key:lower() == "s" then
				ctrl.b = 0
				PlayAnim(10714347256,4,0)
			elseif key:lower() == "a" then
				ctrl.l = 0
				PlayAnim(10714347256,4,0)
			elseif key:lower() == "d" then
				ctrl.r = 0
				PlayAnim(10714347256,4,0)
			end
		end)
		Fly()
	else
		flying = false
		KeyDownFunction:Disconnect()
		KeyUpFunction:Disconnect()
		StopAnim()
	end
end)
RESection:NewSlider("Fly speed", "Changes the speed", 500, 50, function(v)
	FlySpeed = v
end)
-- Teleports --
TpSection:NewButton("CannonTP1", "Tp", function()
	TeleportTO(-61, 34, -228,"pos","safe")
end)
TpSection:NewButton("CannonTP2", "Tp", function()
	TeleportTO(50, 34, -228,"pos","safe")
end)
TpSection:NewButton("CannonTP3", "Desc", function()
	TeleportTO(-6, 35, -106,"pos","safe")
end)
TpSection:NewButton("MinefieldTP", "Desc", function()
	TeleportTO(-65, 23, -151,"pos","safe")
end)
TpSection:NewButton("BallonTP", "Desc", function()
	TeleportTO(-118, 23, -126,"pos","safe")
end)
TpSection:NewButton("NormalStairsTP", "Desc", function()
	TeleportTO(-6, 203, -496,"pos","safe")
end)
TpSection:NewButton("MovingStairsTP", "Desc", function()
	TeleportTO(-210, 87, -224,"pos","safe")
end)
TpSection:NewButton("SpiralStairsTP", "Desc", function()
	TeleportTO(151, 847, -306,"pos","safe")
end)
TpSection:NewButton("SkyscraperTP", "Desc", function()
	TeleportTO(142, 1033, -192,"pos","safe")
end)
TpSection:NewButton("PoolTP", "Desc", function()
	TeleportTO(-133, 65, -321,"pos","safe")
end)
-- Target tab

TargetSection:NewButton("Target tool", "Equip and click to player to select", function()
	local GetTargetTool = Instance.new("Tool")
	GetTargetTool.Name = "ClickTarget"
	GetTargetTool.RequiresHandle = false
	GetTargetTool.TextureId = "rbxassetid://2716591855"
	GetTargetTool.ToolTip = "Select Target"

	local function ActivateTool()
		local root = GetRoot(plr)
		local hit = mouse.Target
		local person = nil
		if hit and hit.Parent then
			if hit.Parent:IsA("Model") then
				person = Players:GetPlayerFromCharacter(hit.Parent)
			elseif hit.Parent:IsA("Accessory") then
				person = Players:GetPlayerFromCharacter(hit.Parent.Parent)
			end
			if person then
				UpdateTarget(person)
			end
		end
	end

	GetTargetTool.Activated:Connect(function()
		ActivateTool()
	end)
	GetTargetTool.Parent = plr.Backpack
end)

TargetSection:NewToggle("Fling target", "Flinging target", function(state)
	if state then
		if TargetedPlayer ~= nil then
			Tfling = true
			local OldPos = GetRoot(plr).Position
			ToggleFling(true)
			repeat task.wait()
				pcall(function()
					PredictionTP(Players[TargetedPlayer],"safe")
				end)
				task.wait()
			until Tfling == false
			TeleportTO(OldPos.X,OldPos.Y,OldPos.Z,"pos","safe")
		end
	else
		Tfling = false
		ToggleFling(false)
	end
end)
TargetSection:NewToggle("View target", "v at target", function(state)
	if state then
		if TargetedPlayer ~= nil then
			Tview = true
			repeat
				pcall(function()
					game:GetService("Workspace").CurrentCamera.CameraSubject = Players[TargetedPlayer].Character.Humanoid
				end)
				task.wait(0.5)
			until Tview == false
			game:GetService("Workspace").CurrentCamera.CameraSubject = plr.Character.Humanoid
		end
	else
		Tview = false
	end
end)
TargetSection:NewToggle("Focus target", "f target", function(state)
	if state then
		if TargetedPlayer ~= nil then
			if Tfocus == false then
				Tfocus = true
				repeat
					pcall(function()
						local target = Players[TargetedPlayer]
						TeleportTO(0,0,0,target)
						Push(Players[TargetedPlayer])
					end)
					task.wait(0.2)
				until Tfocus == false
			end
		end
	else
		Tfocus = false
	end
end)
TargetSection:NewToggle("Bang target", "b target", function(state)
	if state then
		if TargetedPlayer ~= nil then
			Tbenx = true
			PlayAnim(5918726674,0,1)
				repeat
					pcall(function()
						if not GetRoot(plr):FindFirstChild("BreakVelocity") then
							pcall(function()
								local TempV = Velocity_Asset:Clone()
								TempV.Parent = GetRoot(plr)
							end)
						end
						local otherRoot = GetRoot(Players[TargetedPlayer])
						GetRoot(plr).CFrame = otherRoot.CFrame * CFrame.new(0,0,1.1)
						GetRoot(plr).Velocity = Vector3.new(0,0,0)
					end)
					task.wait()
				until Tbenx == false
				StopAnim()
				if GetRoot(plr):FindFirstChild("BreakVelocity") then
					GetRoot(plr).BreakVelocity:Destroy()
				end
		end
	else
		Tbenx = false
	end
end)
TargetSection:NewToggle("Headsit target", "hs target", function(state)
	if state then
		if TargetedPlayer ~= nil then
			Theadsit = true
			repeat
				pcall(function()
					if not GetRoot(plr):FindFirstChild("BreakVelocity") then
						pcall(function()
							local TempV = Velocity_Asset:Clone()
							TempV.Parent = GetRoot(plr)
						end)
					end
					local targethead = Players[TargetedPlayer].Character.Head
					plr.Character.Humanoid.Sit = true
					GetRoot(plr).CFrame = targethead.CFrame * CFrame.new(0,2,0)
					GetRoot(plr).Velocity = Vector3.new(0,0,0)
				end)
				task.wait()
			until Theadsit == false
			if GetRoot(plr):FindFirstChild("BreakVelocity") then
				GetRoot(plr).BreakVelocity:Destroy()
			end
		end
	else
		Theadsit = false
	end
end)
TargetSection:NewToggle("Stand target", "s target", function(state)
	if state then
		if TargetedPlayer ~= nil then
			Tstand = true
			PlayAnim(13823324057,4,0)
				repeat
					pcall(function()
						if not GetRoot(plr):FindFirstChild("BreakVelocity") then
							pcall(function()
								local TempV = Velocity_Asset:Clone()
								TempV.Parent = GetRoot(plr)
							end)
						end
						local root = GetRoot(Players[TargetedPlayer])
						GetRoot(plr).CFrame = root.CFrame * CFrame.new(-3,1,0)
						GetRoot(plr).Velocity = Vector3.new(0,0,0)
					end)
					task.wait()
				until Tstand == false
				StopAnim()
				if GetRoot(plr):FindFirstChild("BreakVelocity") then
					GetRoot(plr).BreakVelocity:Destroy()
				end
		end
	else
		Tstand = false
	end
end)
TargetSection:NewToggle("Backpack target", "b target", function(state)
	if state then
		if TargetedPlayer ~= nil then
			tbp = true
			repeat
				pcall(function()
					if not GetRoot(plr):FindFirstChild("BreakVelocity") then
						pcall(function()
							local TempV = Velocity_Asset:Clone()
							TempV.Parent = GetRoot(plr)
						end)
					end
					local root = GetRoot(Players[TargetedPlayer])
					plr.Character.Humanoid.Sit = true
					GetRoot(plr).CFrame = root.CFrame * CFrame.new(0,0,1.2) * CFrame.Angles(0, -3, 0)
					GetRoot(plr).Velocity = Vector3.new(0,0,0)
				end)
				task.wait()
			until tbp == false
			if GetRoot(plr):FindFirstChild("BreakVelocity") then
				GetRoot(plr).BreakVelocity:Destroy()
			end
		end
	else
		tbp = false
	end
end)
TargetSection:NewToggle("Doggy target", "d target", function(state)
	if state then
		if TargetedPlayer ~= nil then
			Tdoggy = true
			PlayAnim(13694096724,3.4,0)
				repeat
					pcall(function()
						if not GetRoot(plr):FindFirstChild("BreakVelocity") then
							pcall(function()
								local TempV = Velocity_Asset:Clone()
								TempV.Parent = GetRoot(plr)
							end)
						end
						local root = Players[TargetedPlayer].Character.LowerTorso or Players[TargetedPlayer].Character.Torso
						GetRoot(plr).CFrame = root.CFrame * CFrame.new(0,0.23,0)
						GetRoot(plr).Velocity = Vector3.new(0,0,0)
					end)
					task.wait()
				until Tdoggy == false
				StopAnim()
				if GetRoot(plr):FindFirstChild("BreakVelocity") then
					GetRoot(plr).BreakVelocity:Destroy()
				end
		end
	else
		Tdoggy = false
	end
end)

-- Anims --
AnimSection:NewButton("Vampire (500R$)", "Anim", function()
	local Animate = plr.Character.Animate
	Animate.Disabled = true
	StopAnim()
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1083445855"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1083450166"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1083473930"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083462077"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083455352"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083439238"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1083443587"
	plr.Character.Humanoid:ChangeState(3)
	Animate.Disabled = false
end)
AnimSection:NewButton("Hero (250R$)", "Anim", function()
	local Animate = plr.Character.Animate
	Animate.Disabled = true
	StopAnim()
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616111295"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616113536"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616122287"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616117076"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616115533"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616104706"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616108001"
	plr.Character.Humanoid:ChangeState(3)
	Animate.Disabled = false
end)
AnimSection:NewButton("Zombie Classic (500R$)", "Anim", function()
	local Animate = plr.Character.Animate
	Animate.Disabled = true
	StopAnim()
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616158929"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616160636"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616168032"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616161997"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616156119"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616157476"
	plr.Character.Humanoid:ChangeState(3)
	Animate.Disabled = false
end)
AnimSection:NewButton("Mage (250R$)", "Anim", function()
	local Animate = plr.Character.Animate
	Animate.Disabled = true
	StopAnim()
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=707742142"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=707855907"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=707897309"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=707861613"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=707853694"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=707826056"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=707829716"
	plr.Character.Humanoid:ChangeState(3)
	Animate.Disabled = false
end)
AnimSection:NewButton("Ghost (?R$)", "Anim", function()
	local Animate = plr.Character.Animate
	Animate.Disabled = true
	StopAnim()
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616006778"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616008087"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616010382"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616013216"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616008936"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616003713"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616005863"
	plr.Character.Humanoid:ChangeState(3)
	Animate.Disabled = false
end)
AnimSection:NewButton("Elder (250 R$)", "Anim", function()
	local Animate = plr.Character.Animate
	Animate.Disabled = true
	StopAnim()
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=845397899"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=845400520"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=845403856"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=845386501"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=845398858"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=845392038"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=845396048"
	plr.Character.Humanoid:ChangeState(3)
	Animate.Disabled = false
end)
AnimSection:NewButton("Levitation (1000R$)", "Anim", function()
	local Animate = plr.Character.Animate
	Animate.Disabled = true
	StopAnim()
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616006778"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616008087"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616013216"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616010382"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616008936"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616003713"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616005863"
	plr.Character.Humanoid:ChangeState(3)
	Animate.Disabled = false
end)
AnimSection:NewButton("Astronaut (500R$)", "Anim", function()
	local Animate = plr.Character.Animate
	Animate.Disabled = true
	StopAnim()
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=891621366"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=891633237"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=891667138"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=891636393"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=891627522"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=891609353"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=891617961"
	plr.Character.Humanoid:ChangeState(3)
	Animate.Disabled = false
end)
AnimSection:NewButton("Ninja (750R$)", "Anim", function()
	local Animate = plr.Character.Animate
	Animate.Disabled = true
	StopAnim()
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=656117400"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=656118341"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=656121766"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=656118852"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=656117878"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=656114359"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=656115606"
	plr.Character.Humanoid:ChangeState(3)
	Animate.Disabled = false
end)
AnimSection:NewButton("Werewolf (500R$)", "Anim", function()
	local Animate = plr.Character.Animate
	Animate.Disabled = true
	StopAnim()
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1083195517"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1083214717"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1083178339"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083216690"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083218792"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083182000"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1083189019"
	plr.Character.Humanoid:ChangeState(3)
	Animate.Disabled = false
end)
AnimSection:NewButton("Sneaky (Limited ????)", "Anim", function()
	local Animate = plr.Character.Animate
	Animate.Disabled = true
	StopAnim()
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1132473842"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1132477671"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1132510133"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1132494274"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1132489853"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1132461372"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1132469004"
	plr.Character.Humanoid:ChangeState(3)
	Animate.Disabled = false
end)
AnimSection:NewButton("Zombie FE (Limited ????)", "Anim", function()
	local Animate = plr.Character.Animate
	Animate.Disabled = true
	StopAnim()
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=3489171152"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=3489171152"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=3489174223"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=3489173414"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616161997"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616156119"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616157476"
	plr.Character.Humanoid:ChangeState(3)
	Animate.Disabled = false
end)

Players.PlayerRemoving:Connect(function(player)
	pcall(function()
		if player.Name == TargetedPlayer then
			UpdateTarget(nil)
			SendNotify("Organic hub","Targeted player left/rejoined.",5)
		end
	end)
end)

-- Credits
CreditSection:NewKeybind("Toggle Gui", "Show / Hide Gui", Enum.KeyCode.X, function()
	Library:ToggleUI()
end)
CreditSection:NewButton("Radio Gui", "Play your own sounds [Visual]", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Jerka2009/Hubs/main/MusicGui.lua"))()
end)
CreditSection:NewButton("Created by : @Jerkaa2009", "Click to copy", function()
	setclipboard("anti__furry")
end)
CreditSection:NewButton("Idea by : Niky#8422", "Click to copy", function()
	setclipboard("Niky#8422")
end)
CreditSection:NewButton("ChatMessageIntro", "Click to send in rbx chat", function()
	game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("[Organic hub] functions made by Jere2009")
end)
