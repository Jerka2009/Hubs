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

local Tab = Window:NewTab("Key")
local Sect = Tab:NewSection("Key system")

Tab:NewTextBox("Key", "kekekkek", function(txt)
	_G.KeyInput = txt
end)
Sect:NewButton("Check key", "button", function()
    if _G.KeyInput == _G.Key then
	wait(1)
	plr:FindFirstChild("HasKey").Value = true
	if plr:FindFirstChild("HasKey").Value == true then
		for i,v in pairs(game.CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name == kavName then
            v:Destroy()
		MakeScriptHub()
        end
    end
		end
	end
  end    
end)
Sect:NewButton("Get key", "button", function()
	setclipboard("https://discord.gg/4Kp6QkfNev")
end)
