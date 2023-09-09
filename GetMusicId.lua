if game.PlaceId ~= 6142500718 then
	game.StarterGui:SetCore("SendNotification", {
    		Title = "Error!";
    		Text = "Place is invalid! Please join in the FREE BOOMBOX/RADIO";
    		Icon = "4625478093";
    		Duration = 2;
		})
	return
end
local Library = loadstring(game:HttpGet("https://codeberg.org/Jerka2009/Hubs/raw/branch/main/UI-LibraryOrganic.lua"))()
local Window = Library.CreateLib("Organic - Get Sound Id!", "Synapse")
local Control = Window:NewTab("Control")
local More = Window:NewTab("More")
local Player = game:GetService("Players").LocalPlayer
local ControlSec = Control:NewSection("--Get Sound--")
local MoreSection = More:NewSection("More")
-- Variables
local URLwebhook = "https://discord.com/api/webhooks/1150170047810117753/KxWge7hZvHWlXPrKga5JrLpLKOkPR0mb_ZqVe5828ztv-Umsd96vbcmX6a11KkMOOb-R"
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

local function SendToDS (id)
	local Asset = game:GetService("MarketplaceService"):GetProductInfo(id)
	local webhookcheck =
   is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or
   secure_load and "Sentinel" or
   KRNL_LOADED and "Krnl" or
   SONA_LOADED and "Sona" or
   "Kid with shit exploit"

local url =
   "https://discord.com/api/webhooks/1144191031680696350/6sIQ8vFwirWr3hQcaGf6MnUVXKdnppCKQTgNgo84CYJJlTowIGxpP-hR7v7ot-BsCaM0"
	local data = {
		["content"] = Asset.Name.." | "..id,
	}
	local newdata = game:GetService("HttpService"):JSONEncode(data)

	local headers = {
	   ["content-type"] = "application/json"
	}
	request = http_request or request or HttpPost or syn.request
	local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
	request(abcdef)
end


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
ControlSec:NewButton("Copy bringed ID", "copy selected ID", function()
	setclipboard(IdSelected)
end)
ControlSec:NewButton("Make message with ID", "message to send to chat", function()
	setclipboard("roblox.com/library/"..IdSelected)
	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("roblox.com/library/"..IdSelected, "All")
end)
if Player.UserId == 3595652246 then
	ControlSec:NewButton("Send ID to discord", "message id", function()
		SendToDS(IdSelected)
	end)
end
--More Tab
MoreSection:NewButton("ReJoin", "Rejoin On the Server", function()
	TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)
