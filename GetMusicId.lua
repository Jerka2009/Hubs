local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Organic - Get Sound Id!", "Synapse")
local Control = Window:NewTab("Control")
local More = Window:NewTab("More")
local ControlSec = Control:NewSection("--Get Sound--")
local MoreSection = More:NewSection("More")
-- Variables
local ToolName = "BoomBox"
local PlayerSelected = ""
local IdSelected = 0
local plrsTable = {}
-- Control Tab
for i, plr in pairs(game:GetService("Players"):GetPlayers()) do
	table.insert(plrsTable, plr.Name)
end
local Label = ControlSec:NewLabel("{SoundID}")
local plrs = ControlSec:NewDropdown("Player", "PlayerList", plrsTable, function(currentOption)
    PlayerSelected = currentOption
end)
game:GetService("Players").PlayerAdded:Connect(function(plr)
	table.insert(plrsTable, plr.Name)
	plrs:Refresh(plrsTable)
end)
game:GetService("Players").PlayerRemoving:Connect(function(plr)
	local index = table.find(plrsTable, plr.Name) --get the index
	table.remove(plrsTable, index) --remove the index
	plrs:Refresh(plrsTable)
end)
ControlSec:NewButton("GetSound from player", "Get Sound ID", function()
	if game:GetService("Players"):FindFirstChild(PlayerSelected) then
		local player = game:GetService("Players"):FindFirstChild(PlayerSelected)
		if player.Character then
			local char = player.Character
			if char:FindFirstChild(ToolName) ~= nil then
			local Box = char:FindFirstChild(ToolName)
				local Sound = Box:WaitForChild("Handle"):WaitForChild("Sound")
				local id = Sound.SoundId
				local h = tostring(id)
				local PrintText = string.sub(h,14,30)
				IdSelected = PrintText
				Label:UpdateLabel(PrintText)
        setclipboard(PrintText)
			else
				game.StarterGui:SetCore("SendNotification", {
    				Title = "Error!";
    				Text = "Player "..PlayerSelected.." is not eqiup the "..ToolName.."!";
    				Icon = "4625478093";
    				Duration = 2;
				})
			end
		end
	else
		game.StarterGui:SetCore("SendNotification", {
    	Title = "Error!";
    	Text = "Player "..PlayerSelected.." is not found in Players!";
    	Icon = "4625478093";
    	Duration = 2;
    })
	end
end)
ControlSec:NewButton("Make message with ID", "message to send to chat", function()
	setclipboard("roblox.com/library/"..IdSelected)
end)
--More Tab
MoreSection:NewButton("ReJoin", "Rejoin On the Server", function()
	TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)
