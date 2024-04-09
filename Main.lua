
-- Created by Jerka2009!
 --[[
                               /$$                  /$$$$$$   /$$$$$$   /$$$$$$   /$$$$$$ 
                              | $$                 /$$__  $$ /$$$_  $$ /$$$_  $$ /$$__  $$
       /$$  /$$$$$$   /$$$$$$ | $$   /$$  /$$$$$$ |__/  \ $$| $$$$\ $$| $$$$\ $$| $$  \ $$
      |__/ /$$__  $$ /$$__  $$| $$  /$$/ |____  $$  /$$$$$$/| $$ $$ $$| $$ $$ $$|  $$$$$$$
       /$$| $$$$$$$$| $$  \__/| $$$$$$/   /$$$$$$$ /$$____/ | $$\ $$$$| $$\ $$$$ \____  $$
      | $$| $$_____/| $$      | $$_  $$  /$$__  $$| $$      | $$ \ $$$| $$ \ $$$ /$$  \ $$
      | $$|  $$$$$$$| $$      | $$ \  $$|  $$$$$$$| $$$$$$$$|  $$$$$$/|  $$$$$$/|  $$$$$$/
      | $$ \_______/|__/      |__/  \__/ \_______/|________/ \______/  \______/  \______/ 
 /$$  | $$                                                                                
|  $$$$$$/                                                                                
 \______/                                                                                 

]]
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/vova999000333/Hubs/main/UI-LibraryOrganic.lua"))()
local Window = Library.CreateLib("Organic - key system", "Synapse")
local plr = game:GetService("Players").LocalPlayer
local BlackList = {1234567890}
local FName = "Organic.JSON"
if BlackList[game:GetService("Players").LocalPlayer.UserId] then
	game:GetService("Players").LocalPlayer:Kick("You're in black list hehe!")
end
if plr:FindFirstChild("HasKey") == nil then
	local n = Instance.new("BoolValue")
	n.Name = "HasKey"
	n.Value = true
	n.Parent = plr
end
function MakeScriptHub()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/vova999000333/Hubs/main/LoaderHub.lua"))()
end
_G.Key = nil
loadstring(game:HttpGet("https://raw.githubusercontent.com/vova999000333/Hubs/main/key.lua"))()
_G.KeyInput = "string"

if pcall(function() readfile(FName) end) then
	if readfile(FName) == _G.Key then
		plr:FindFirstChild("HasKey").Value = true
		MakeScriptHub()
	else
				delfile(FName)
		game.StarterGui:SetCore("SendNotification", {
    Title = "Old key!";
    Text = "pls get new key, for login";
    Icon = "11745872952";
    Duration = "3";
})
	end
end

function Login()
	game.StarterGui:SetCore("SendNotification", {
    Title = "Log in";
    Text = "You're logged as "..plr.Name..". \n Please, enter your key.";
    Icon = "4625478093";
    Duration = "4";
})
end

function INcorrect()
	game.StarterGui:SetCore("SendNotification", {
    Title = "Incorrect key!";
    Text = "pls get key, for login";
    Icon = "11745872952";
    Duration = "3";
})
end
function COrrect()
	game.StarterGui:SetCore("SendNotification", {
    Title = "Correct key!";
    Text = "Enjoy the script!";
    Icon = "12690727261";
    Duration = "2";
})
end

local Tab = Window:NewTab("Key")
local Sect = Tab:NewSection("Key system")

Sect:NewTextBox("Key", "kekekkek", function(txt)
	_G.KeyInput = txt
	if _G.KeyInput == _G.Key then
		wait(1)
		plr:FindFirstChild("HasKey").Value = true
		if plr:FindFirstChild("HasKey").Value == true then
			COrrect()
			wait(1)
			writefile(FName, _G.Key)
			wait()
			MakeScriptHub()
			Window:Delete()
		end
  else
		INcorrect()
  end    
end)
Sect:NewButton("Get key [discord.gg/65DUwUVUgS]", "Copy", function()
	setclipboard("https://discord.gg/65DUwUVUgS")
end)
Login()
