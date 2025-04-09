--====================================================================--
--||					   SCRIPT BY: BARTVANM                      ||--
--====================================================================--


-- Variables:
moneyToggle = false
AimbotToggle = false
espToggle = false
plr, dist = nil,1
tpKillToggle = false
FastToggle = false
-- Instances:
local KnifeSimulatorGUI = Instance.new("ScreenGui")
local main = Instance.new("Frame")
local OpenMoney = Instance.new("TextButton")
local header = Instance.new("TextLabel")
local footer = Instance.new("TextLabel")
local CloseMoney = Instance.new("TextButton")
local CloseAimbot = Instance.new("TextButton")
local OpenAimbot = Instance.new("TextButton")
local CloseESP = Instance.new("TextButton")
local OpenTPKILL = Instance.new("TextButton")
local CloseTPKILL = Instance.new("TextButton")
local OpenTP = Instance.new("TextButton")
local OpenFAST = Instance.new("TextButton")
local CloseFAST = Instance.new("TextButton")
local OpenESP = Instance.new("TextButton")
local open = Instance.new("Frame")
local OpenMain = Instance.new("TextButton")
local CLOSEBUTTON = Instance.new("TextButton")
local CloseMain = Instance.new("TextButton")
--Properties:
KnifeSimulatorGUI.Name = "Knife Simulator GUI"
KnifeSimulatorGUI.Parent = game.CoreGui

main.Active = true
main.Draggable = true

main.Name = "main"
main.Parent = KnifeSimulatorGUI
main.BackgroundColor3 = Color3.new(0.0901961, 0.65098, 1)
main.BackgroundTransparency = 0.40000000596046
main.BorderColor3 = Color3.new(1, 1, 1)
main.BorderSizePixel = 8
main.Position = UDim2.new(0.408839792, 0, 0.260442257, 0)
main.Size = UDim2.new(0, 241, 0, 475)
main.Visible = false

OpenMoney.Name = "OpenMoney"
OpenMoney.Parent = main
OpenMoney.BackgroundColor3 = Color3.new(0.0117647, 0.576471, 0.0784314)
OpenMoney.BackgroundTransparency = 0.40000000596046
OpenMoney.BorderColor3 = Color3.new(1, 1, 1)
OpenMoney.BorderSizePixel = 2
OpenMoney.Position = UDim2.new(0.0699058324, 0, 0.122530729, 0)
OpenMoney.Size = UDim2.new(0, 207, 0, 50)
OpenMoney.Font = Enum.Font.SciFi
OpenMoney.Text = "MONEY FARM"
OpenMoney.TextColor3 = Color3.new(1, 1, 1)
OpenMoney.TextSize = 27
OpenMoney.TextStrokeColor3 = Color3.new(0.156863, 0.470588, 0)
OpenMoney.TextStrokeTransparency = 0
OpenMoney.MouseButton1Click:connect(function()
	OpenMoney.Visible = false
	CloseMoney.Visible = true	
	moneyToggle = true
	while moneyToggle == true do
		wait()
		game.ReplicatedStorage.forhackers:InvokeServer("hit", {})
		game.ReplicatedStorage.forhackers:InvokeServer("throw", {})
	end
end)

header.Name = "header"
header.Parent = main
header.BackgroundColor3 = Color3.new(0.0901961, 0.65098, 1)
header.BorderSizePixel = 0
header.Size = UDim2.new(0, 241, 0, 38)
header.Font = Enum.Font.SciFi
header.Text = "Knife Sim UI"
header.TextColor3 = Color3.new(1, 1, 1)
header.TextSize = 32
header.TextStrokeColor3 = Color3.new(0.0196078, 0.458824, 1)
header.TextStrokeTransparency = 0

footer.Name = "footer"
footer.Parent = main
footer.BackgroundColor3 = Color3.new(0.0901961, 0.65098, 1)
footer.BorderSizePixel = 0
footer.Position = UDim2.new(-0.00414937781, 0, 0.919406235, 0)
footer.Size = UDim2.new(0, 241, 0, 38)
footer.Font = Enum.Font.SciFi
footer.Text = "Made By: Bartvanm"
footer.TextColor3 = Color3.new(1, 1, 1)
footer.TextSize = 28
footer.TextStrokeColor3 = Color3.new(0.0196078, 0.458824, 1)
footer.TextStrokeTransparency = 0

CloseMoney.Name = "CloseMoney"
CloseMoney.Parent = main
CloseMoney.BackgroundColor3 = Color3.new(0.905882, 0.0196078, 0.0352941)
CloseMoney.BackgroundTransparency = 0.40000000596046
CloseMoney.BorderColor3 = Color3.new(1, 1, 1)
CloseMoney.BorderSizePixel = 2
CloseMoney.Position = UDim2.new(0.0699058324, 0, 0.122530729, 0)
CloseMoney.Size = UDim2.new(0, 207, 0, 50)
CloseMoney.Visible = false
CloseMoney.Font = Enum.Font.SciFi
CloseMoney.Text = "MONEY FARM"
CloseMoney.TextColor3 = Color3.new(1, 1, 1)
CloseMoney.TextSize = 27
CloseMoney.TextStrokeColor3 = Color3.new(0.792157, 0.0352941, 0.0470588)
CloseMoney.TextStrokeTransparency = 0
CloseMoney.MouseButton1Click:connect(function()
	OpenMoney.Visible = true
	CloseMoney.Visible = false
	moneyToggle = false	
end)

CloseAimbot.Name = "CloseAimbot"
CloseAimbot.Parent = main
CloseAimbot.BackgroundColor3 = Color3.new(0.905882, 0.0196078, 0.0352941)
CloseAimbot.BackgroundTransparency = 0.40000000596046
CloseAimbot.BorderColor3 = Color3.new(1, 1, 1)
CloseAimbot.BorderSizePixel = 2
CloseAimbot.Position = UDim2.new(0.0699058324, 0, 0.248468667, 0)
CloseAimbot.Size = UDim2.new(0, 207, 0, 50)
CloseAimbot.Visible = false
CloseAimbot.Font = Enum.Font.SciFi
CloseAimbot.Text = "AIMBOT"
CloseAimbot.TextColor3 = Color3.new(1, 1, 1)
CloseAimbot.TextSize = 27
CloseAimbot.TextStrokeColor3 = Color3.new(0.792157, 0.0352941, 0.0470588)
CloseAimbot.TextStrokeTransparency = 0
CloseAimbot.MouseButton1Click:connect(function()
	CloseAimbot.Visible = false
	OpenAimbot.Visible = true
	AimbotToggle = false
	if AimbotToggle == false then
		warn("Deactivated Aimbot")
		local plrs = game:service("Players")
		local ms = plrs.LocalPlayer:GetMouse()
		local nearest = function()
		plr,dist = nil,1
		for k,l in pairs(plrs:GetPlayers()) do
		local pos = l.Character:GetPrimaryPartCFrame().p
		local len = (ms.Hit.p - pos).Magnitude
		if len <= dist then
		plr = l
		dist = len
		end
		end
		return plr.Character:GetPrimaryPartCFrame().p
		end
		workspace.CurrentCamera.trash.ChildAdded:connect(function(c)
		c.CFrame = CFrame.new(nearest())
		end)
	end
end)

OpenAimbot.Name = "OpenAimbot"
OpenAimbot.Parent = main
OpenAimbot.BackgroundColor3 = Color3.new(0.0117647, 0.576471, 0.0784314)
OpenAimbot.BackgroundTransparency = 0.40000000596046
OpenAimbot.BorderColor3 = Color3.new(1, 1, 1)
OpenAimbot.BorderSizePixel = 2
OpenAimbot.Position = UDim2.new(0.0699058324, 0, 0.248468667, 0)
OpenAimbot.Size = UDim2.new(0, 207, 0, 50)
OpenAimbot.Font = Enum.Font.SciFi
OpenAimbot.Text = "AIMBOT"
OpenAimbot.TextColor3 = Color3.new(1, 1, 1)
OpenAimbot.TextSize = 27
OpenAimbot.TextStrokeColor3 = Color3.new(0.156863, 0.470588, 0)
OpenAimbot.TextStrokeTransparency = 0
OpenAimbot.MouseButton1Click:connect(function()
	OpenAimbot.Visible = false
	CloseAimbot.Visible = true
	AimbotToggle = true
	
	if AimbotToggle then
		warn("Activated Aimbot")
		local plrs = game:service("Players")
		local ms = plrs.LocalPlayer:GetMouse()
		local nearest = function()
		plr,dist = nil,5000
		for k,l in pairs(plrs:GetPlayers()) do
		local pos = l.Character:GetPrimaryPartCFrame().p
		local len = (ms.Hit.p - pos).Magnitude
		if len <= dist then
		plr = l
		dist = len
		end
		end
		return plr.Character:GetPrimaryPartCFrame().p
		end
		workspace.CurrentCamera.trash.ChildAdded:connect(function(c)
		c.CFrame = CFrame.new(nearest())
		end)
	end
	
		
end)
CloseESP.Name = "CloseESP"
CloseESP.Parent = main
CloseESP.BackgroundColor3 = Color3.new(0.905882, 0.0196078, 0.0352941)
CloseESP.BackgroundTransparency = 0.40000000596046
CloseESP.BorderColor3 = Color3.new(1, 1, 1)
CloseESP.BorderSizePixel = 2
CloseESP.Position = UDim2.new(0.0699058324, 0, 0.37478447, 0)
CloseESP.Size = UDim2.new(0, 207, 0, 50)
CloseESP.Visible = false
CloseESP.Font = Enum.Font.SciFi
CloseESP.Text = "ESP"
CloseESP.TextColor3 = Color3.new(1, 1, 1)
CloseESP.TextSize = 27
CloseESP.TextStrokeColor3 = Color3.new(0.792157, 0.0352941, 0.0470588)
CloseESP.TextStrokeTransparency = 0
CloseESP.MouseButton1Click:connect(function()
	espToggle = false
	CloseESP.Visible = false
	OpenESP.Visible = true
	
	local localPlayer=game.Players.LocalPlayer
	
	
function highlightModel(objObject)
	for i,v in pairs(objObject:children())do
		if v:IsA'BasePart'and v.Name~='HumanoidRootPart'then
			local bHA=Instance.new('BoxHandleAdornment',v)
			bHA.Adornee=v
			bHA.Size= v.Name=='Head' and Vector3.new(1.25,1.25,1.25) or v.Size
			bHA.Color3=v.Name=='Head'and Color3.new(1,0,0)or v.Name=='Torso'and Color3.new(0,1,0)or Color3.new(0,0,1)
			bHA.Transparency=0
			bHA.ZIndex=1
			bHA.AlwaysOnTop=true
		end
		if #v:children()>0 then
			highlightModel(v)
			unHighlightModel(v)
		else
			unHighlightModel(v)
		end
	end
end

function unHighlightModel(objObject)
	for i,v in pairs(objObject:children())do
		unHighlightModel(v)
		v.BoxHandleAdornment:Destroy()
		if v:IsA'BasePart' and v:findFirstChild'BoxHandleAdornment' then
			v.BoxHandleAdornment:Destroy()
		end
		if #v:children()>0 then
			unHighlightModel(v)
			warn("biem")
		end
	end
end

function sortTeamHighlights(objPlayer)
	repeat wait() until objPlayer.Character
	if objPlayer.TeamColor~=localPlayer.TeamColor then
		highlightModel(objPlayer.Character)
	else
		unHighlightModel(objPlayer.Character)
	end
	if objPlayer~=localPlayer then
		objPlayer.Changed:connect(function(strProp)
			if strProp=='TeamColor'then
				if objPlayer.TeamColor~=localPlayer.TeamColor then
					unHighlightModel(objPlayer.Character)
					highlightModel(objPlayer.Character)
				else
					unHighlightModel(objPlayer.Character)
				end
			end
		end)
	else
		objPlayer.Changed:connect(function(strProp)
			if strProp=='TeamColor'then
				wait(.5)
				for i,v in pairs(game.Players:GetPlayers())do
					unHighlightModel(v)
					if v.TeamColor~=localPlayer.TeamColor then
						highlightModel(v.Character)
					end
				end
			end
		end)
	end
end

for i,v in pairs(game.Players:GetPlayers())do
	v.CharacterAdded:connect(function()
		sortTeamHighlights(v)
	end)
	sortTeamHighlights(v)
end
game.Players.PlayerAdded:connect(function(objPlayer)
	objPlayer.CharacterAdded:connect(function(objChar)
		sortTeamHighlights(objPlayer)
	end)
end)

end)

OpenTPKILL.Name = "OpenTPKILL"
OpenTPKILL.Parent = main
OpenTPKILL.BackgroundColor3 = Color3.new(0.0117647, 0.576471, 0.0784314)
OpenTPKILL.BackgroundTransparency = 0.40000000596046
OpenTPKILL.BorderColor3 = Color3.new(1, 1, 1)
OpenTPKILL.BorderSizePixel = 2
OpenTPKILL.Position = UDim2.new(0.0657564551, 0, 0.504285157, 0)
OpenTPKILL.Size = UDim2.new(0, 207, 0, 50)
OpenTPKILL.Font = Enum.Font.SciFi
OpenTPKILL.Text = "TP KILL"
OpenTPKILL.TextColor3 = Color3.new(1, 1, 1)
OpenTPKILL.TextSize = 27
OpenTPKILL.TextStrokeColor3 = Color3.new(0.156863, 0.470588, 0)
OpenTPKILL.TextStrokeTransparency = 0
OpenTPKILL.MouseButton1Click:connect(function()
	tpKillToggle = true
	OpenTPKILL.Visible = false
	CloseTPKILL.Visible = true
	while tpKillToggle do
		wait()
		for i,v in pairs(game:GetService'Players':GetPlayers()) do
		  if v.Name ~= game:GetService'Players'.LocalPlayer.Name then
		      repeat
		          wait()
		          game:GetService'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
		          game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass'Tool':Activate()
		      until v.Character.Humanoid.Health == 0 or tpKillToggle == false
		  end
		end
	end
	
		local plrs = game:service("Players")
		local ms = plrs.LocalPlayer:GetMouse()
		local nearest = function()
		plr,dist = nil,5000
		for k,l in pairs(plrs:GetPlayers()) do
		local pos = l.Character:GetPrimaryPartCFrame().p
		local len = (ms.Hit.p - pos).Magnitude
		if len <= dist then
		plr = l
		dist = len
		end
		end
		return plr.Character:GetPrimaryPartCFrame().p
		end
		workspace.CurrentCamera.trash.ChildAdded:connect(function(c)
		c.CFrame = CFrame.new(nearest())
		end)
end)

CloseTPKILL.Name = "CloseTPKILL"
CloseTPKILL.Parent = main
CloseTPKILL.BackgroundColor3 = Color3.new(0.905882, 0.0196078, 0.0352941)
CloseTPKILL.BackgroundTransparency = 0.40000000596046
CloseTPKILL.BorderColor3 = Color3.new(1, 1, 1)
CloseTPKILL.BorderSizePixel = 2
CloseTPKILL.Position = UDim2.new(0.0699058324, 0, 0.505310774, 0)
CloseTPKILL.Size = UDim2.new(0, 207, 0, 50)
CloseTPKILL.Visible = false
CloseTPKILL.Font = Enum.Font.SciFi
CloseTPKILL.Text = "TP KILL"
CloseTPKILL.TextColor3 = Color3.new(1, 1, 1)
CloseTPKILL.TextSize = 27
CloseTPKILL.TextStrokeColor3 = Color3.new(0.792157, 0.0352941, 0.0470588)
CloseTPKILL.TextStrokeTransparency = 0
CloseTPKILL.MouseButton1Click:connect(function()
	tpKillToggle = false
	OpenTPKILL.Visible = true
	CloseTPKILL.Visible = false
end)

OpenTP.Name = "OpenTP"
OpenTP.Parent = main
OpenTP.BackgroundColor3 = Color3.new(0, 0.666667, 1)
OpenTP.BackgroundTransparency = 0.40000000596046
OpenTP.BorderColor3 = Color3.new(1, 1, 1)
OpenTP.BorderSizePixel = 2
OpenTP.Position = UDim2.new(0.0699058324, 0, 0.639021993, 0)
OpenTP.Size = UDim2.new(0, 207, 0, 50)
OpenTP.Font = Enum.Font.SciFi
OpenTP.Text = "CLICK TO TP"
OpenTP.TextColor3 = Color3.new(1, 1, 1)
OpenTP.TextSize = 27
OpenTP.TextStrokeColor3 = Color3.new(0.168627, 0.501961, 1)
OpenTP.TextStrokeTransparency = 0
OpenTP.MouseButton1Click:connect(function()
game.StarterGui:SetCoreGuiEnabled(2, true)
wait()
mouse = game.Players.LocalPlayer:GetMouse()
local tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Click Teleport"
tool.Activated:connect(function()
local pos = mouse.Hit+Vector3.new(0,2.5,0)
pos = CFrame.new(pos.X,pos.Y,pos.Z)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
end)
tool.Parent = game.Players.LocalPlayer.Backpack
local idols = game.Workspace.Misc.Idols:GetChildren()
local lp = game.Players.LocalPlayer.Character

end)

OpenFAST.Name = "OpenFAST"
OpenFAST.Parent = main
OpenFAST.BackgroundColor3 = Color3.new(0.0117647, 0.576471, 0.0784314)
OpenFAST.BackgroundTransparency = 0.40000000596046
OpenFAST.BorderColor3 = Color3.new(1, 1, 1)
OpenFAST.BorderSizePixel = 2
OpenFAST.Position = UDim2.new(0.0699058324, 0, 0.761127234, 0)
OpenFAST.Size = UDim2.new(0, 207, 0, 50)
OpenFAST.Font = Enum.Font.SciFi
OpenFAST.Text = "SPEED+JUMP"
OpenFAST.TextColor3 = Color3.new(1, 1, 1)
OpenFAST.TextSize = 27
OpenFAST.TextStrokeColor3 = Color3.new(0.156863, 0.470588, 0)
OpenFAST.TextStrokeTransparency = 0
OpenFAST.MouseButton1Click:connect(function()
	game:GetService'Players'.LocalPlayer.Character.Humanoid.JumpPower = 150
	game:GetService'Players'.LocalPlayer.Character.Humanoid.WalkSpeed = 80
	CloseFAST.Visible = true
	OpenFAST.Visible = false
end)

CloseFAST.Name = "CloseFAST"
CloseFAST.Parent = main
CloseFAST.BackgroundColor3 = Color3.new(0.905882, 0.0196078, 0.0352941)
CloseFAST.BackgroundTransparency = 0.40000000596046
CloseFAST.BorderColor3 = Color3.new(1, 1, 1)
CloseFAST.BorderSizePixel = 2
CloseFAST.Position = UDim2.new(0.0699058324, 0, 0.76215291, 0)
CloseFAST.Size = UDim2.new(0, 207, 0, 50)
CloseFAST.Visible = false
CloseFAST.Font = Enum.Font.SciFi
CloseFAST.Text = "SPEED+JUMP"
CloseFAST.TextColor3 = Color3.new(1, 1, 1)
CloseFAST.TextSize = 27
CloseFAST.TextStrokeColor3 = Color3.new(0.792157, 0.0352941, 0.0470588)
CloseFAST.TextStrokeTransparency = 0
CloseFAST.MouseButton1Click:connect(function()
	game:GetService'Players'.LocalPlayer.Character.Humanoid.JumpPower = 50
	game:GetService'Players'.LocalPlayer.Character.Humanoid.WalkSpeed = 16
	CloseFAST.Visible = false
	OpenFAST.Visible = true
end)

OpenESP.Name = "OpenESP"
OpenESP.Parent = main
OpenESP.BackgroundColor3 = Color3.new(0.0117647, 0.576471, 0.0784314)
OpenESP.BackgroundTransparency = 0.40000000596046
OpenESP.BorderColor3 = Color3.new(1, 1, 1)
OpenESP.BorderSizePixel = 2
OpenESP.Position = UDim2.new(0.0699058324, 0, 0.375864089, 0)
OpenESP.Size = UDim2.new(0, 207, 0, 50)
OpenESP.Font = Enum.Font.SciFi
OpenESP.Text = "ESP"
OpenESP.TextColor3 = Color3.new(1, 1, 1)
OpenESP.TextSize = 27
OpenESP.TextStrokeColor3 = Color3.new(0.156863, 0.470588, 0)
OpenESP.TextStrokeTransparency = 0
OpenESP.MouseButton1Click:connect(function()
	OpenESP.Visible = false
	CloseESP.Visible = true
	espToggle = true
	-- Made by Clifford from Intriga Discord -- Edited by Foxxy#2439/Bartvanm --

local localPlayer=game.Players.LocalPlayer

function highlightModel(objObject)
	for i,v in pairs(objObject:children())do
		if v:IsA'BasePart'and v.Name~='HumanoidRootPart'then
			local bHA=Instance.new('BoxHandleAdornment',v)
			bHA.Adornee=v
			bHA.Size= v.Name=='Head' and Vector3.new(1.25,1.25,1.25) or v.Size
			bHA.Color3=v.Name=='Head'and Color3.new(1,0,0)or v.Name=='Torso'and Color3.new(0,1,0)or Color3.new(0,0,1)
			bHA.Transparency=.5
			bHA.ZIndex=1
			bHA.AlwaysOnTop=true
		end
		if #v:children()>0 and espToggle then
			highlightModel(v)
		else
			unHighlightModel(v)
		end
	end
end

function unHighlightModel(objObject)
	for i,v in pairs(objObject:children())do
		if v:IsA'BasePart' and v:findFirstChild'BoxHandleAdornment' then
			v.BoxHandleAdornment:Destroy()
		end
		if #v:children()>0 then
			unHighlightModel(v)
		end
	end
end

function sortTeamHighlights(objPlayer)
	repeat wait() until objPlayer.Character
	if objPlayer.TeamColor~=localPlayer.TeamColor then
		highlightModel(objPlayer.Character)
	else
		unHighlightModel(objPlayer.Character)
	end
	if objPlayer~=localPlayer then
		objPlayer.Changed:connect(function(strProp)
			if strProp=='TeamColor'then
				if objPlayer.TeamColor~=localPlayer.TeamColor then
					unHighlightModel(objPlayer.Character)
					highlightModel(objPlayer.Character)
				else
					unHighlightModel(objPlayer.Character)
				end
			end
		end)
	else
		objPlayer.Changed:connect(function(strProp)
			if strProp=='TeamColor'then
				wait(.5)
				for i,v in pairs(game.Players:GetPlayers())do
					unHighlightModel(v)
					if v.TeamColor~=localPlayer.TeamColor then
						highlightModel(v.Character)
					end
				end
			end
		end)
	end
end

for i,v in pairs(game.Players:GetPlayers())do
	v.CharacterAdded:connect(function()
		sortTeamHighlights(v)
	end)
	sortTeamHighlights(v)
end
game.Players.PlayerAdded:connect(function(objPlayer)
	objPlayer.CharacterAdded:connect(function(objChar)
		sortTeamHighlights(objPlayer)
	end)
end)
end)

open.Name = "open"
open.Parent = KnifeSimulatorGUI
open.BackgroundColor3 = Color3.new(0.0901961, 0.65098, 1)
open.BackgroundTransparency = 0.40000000596046
open.BorderColor3 = Color3.new(1, 1, 1)
open.BorderSizePixel = 8
open.Position = UDim2.new(0.353591174, 0, 0.0122850118, 0)
open.Size = UDim2.new(0, 370, 0, 39)

OpenMain.Name = "OpenMain"
OpenMain.Parent = open
OpenMain.BackgroundColor3 = Color3.new(1, 1, 1)
OpenMain.BackgroundTransparency = 0.75
OpenMain.BorderColor3 = Color3.new(1, 1, 1)
OpenMain.BorderSizePixel = 2
OpenMain.Position = UDim2.new(0, 0, 0.0366177671, 0)
OpenMain.Size = UDim2.new(0, 369, 0, 37)
OpenMain.Font = Enum.Font.SciFi
OpenMain.Text = "OPEN UI"
OpenMain.TextColor3 = Color3.new(1, 1, 1)
OpenMain.TextSize = 27
OpenMain.TextStrokeColor3 = Color3.new(0.0196078, 0.458824, 1)
OpenMain.TextStrokeTransparency = 0
OpenMain.MouseButton1Click:connect(function()
	OpenMain.Visible = false
	CloseMain.Visible = true
	main.Visible = true
end)

CLOSEBUTTON.Name = "CLOSEBUTTON"
CLOSEBUTTON.Parent = open
CLOSEBUTTON.BackgroundColor3 = Color3.new(1, 0, 0)
CLOSEBUTTON.BackgroundTransparency = 0.25
CLOSEBUTTON.BorderColor3 = Color3.new(1, 0, 0)
CLOSEBUTTON.Position = UDim2.new(0.888678432, 0, 0, 0)
CLOSEBUTTON.Size = UDim2.new(0, 41, 0, 38)
CLOSEBUTTON.ZIndex = 2
CLOSEBUTTON.Font = Enum.Font.SourceSansBold
CLOSEBUTTON.Text = "X"
CLOSEBUTTON.TextColor3 = Color3.new(1, 1, 1)
CLOSEBUTTON.TextSize = 30
CLOSEBUTTON.MouseButton1Click:connect(function()
	main.Visible = false
	open.Visible = false
end)

CloseMain.Name = "CloseMain"
CloseMain.Parent = open
CloseMain.BackgroundColor3 = Color3.new(1, 1, 1)
CloseMain.BackgroundTransparency = 0.75
CloseMain.BorderColor3 = Color3.new(1, 1, 1)
CloseMain.BorderSizePixel = 2
CloseMain.Position = UDim2.new(0, 0, 0.0366177671, 0)
CloseMain.Size = UDim2.new(0, 369, 0, 37)
CloseMain.Visible = false
CloseMain.Font = Enum.Font.SciFi
CloseMain.Text = "CLOSE UI"
CloseMain.TextColor3 = Color3.new(1, 1, 1)
CloseMain.TextSize = 27
CloseMain.TextStrokeColor3 = Color3.new(0.0196078, 0.458824, 1)
CloseMain.TextStrokeTransparency = 0
CloseMain.MouseButton1Click:connect(function()
	OpenMain.Visible = true
	CloseMain.Visible = false
	main.Visible = false
end)

-- Thank you for using one of my scripts!
-- https://v3rmillion.net/member.php?action=profile&uid=695311
