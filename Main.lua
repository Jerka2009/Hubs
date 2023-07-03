local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Organic - key system", "Synapse")
local plr = game:GetService("Players").LocalPlayer

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

Tab:AddTextbox({
	Name = "Enter Key",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		_G.KeyInput = Value
	end	  
})
Tab:AddButton({
	Name = "Check Key!",
	Callback = function()
      	if _G.KeyInput == _G.Key then
			wait(1)
			plr:FindFirstChild("HasKey").Value = true
			if plr:FindFirstChild("HasKey").Value == true then
				CorrectKeyNotification()
				MakeScriptHub()
				OrionLib:Destroy()
			end
		else
			IncorrectKeyNotification()
		end
  	end    
})
Tab:AddButton({
	Name = "Get Key!",
	Callback = function()
		setclipboard("https://discord.gg/4Kp6QkfNev")
		CopiedDS()
  	end    
})
