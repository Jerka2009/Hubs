local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Organic - key system", "Synapse")
local plr = game:GetService("Players").LocalPlayer
local kavName = "Organic - key system"
if plr:FindFirstChild("HasKey") == nil then
	local n = Instance.new("BoolValue")
	n.Name = "HasKey"
	n.Value = false
	n.Parent = plr
end

_G.Key = nil
loadstring(game:HttpGet("https://raw.githubusercontent.com/vova999000333/Hubs/main/key.lua"))()
_G.KeyInput = "string"

function MakeScriptHub()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/vova999000333/Hubs/main/LoaderHub.lua"))()
end

local FName = "Organic.JSON"

pcall(function()

if pcall(function() readfile(FName) end) then
	plr:FindFirstChild("HasKey").Value = true
	MakeScriptHub()
end

Settings = game:service'HttpService':JSONEncode(readfile(Name))
end)

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
			writefile(FName, game:service'HttpService':JSONEncode(_G.Key))
			for i,v in pairs(game.CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name == kavName then
            v:Destroy()
        end
    end
			wait()
			MakeScriptHub()
		end
  else
		INcorrect()
  end    
end)
Sect:NewButton("Get key [discord.gg/4Kp6QkfNe]", "button", function()
	setclipboard("https://discord.gg/4Kp6QkfNev")
end)
Login()
