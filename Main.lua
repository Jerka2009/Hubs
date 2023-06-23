local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local plr = game:GetService("Players").LocalPlayer
local Window = OrionLib:MakeWindow({Name = "Key System", HidePremium = false, SaveConfig = true, IntroEnabled = false})

if plr:FindFirstChild("HasKey") == nil then
	local n = Instance.new("BoolValue")
	n.Name = "HasKey"
	n.Value = false
	n.Parent = plr
end

OrionLib:MakeNotification({
	Name = "Key system loaded",
	Content = "You're logged in as "..game:GetService("Players").LocalPlayer.Name..".",
	Image = "rbxassetid://4483345998",
	Time = 5
})

_G.Key = "Z9BNMQ*FCbtY"
_G.KeyInput = "string"

function MakeScriptHub()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/vova999000333/Hubs/main/LoaderHub.lua"))()
end

function CorrectKeyNotification()
	OrionLib:MakeNotification({
	Name = "Correct key!",
	Content = "Enjoy the script!",
	Image = "rbxassetid://4483345998",
	Time = 3
})
end

function IncorrectKeyNotification()
	OrionLib:MakeNotification({
	Name = "Invalid key!",
	Content = "Please retry!",
	Image = "rbxassetid://4483345998",
	Time = 3
})
end

local Tab = Window:MakeTab({
	Name = "Key",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

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
			CorrectKeyNotification()
			wait(1)
			plr:FindFirstChild("HasKey").Value = true
			if plr:FindFirstChild("HasKey").Value == true then
				MakeScriptHub()
				game.CoreGui.Orion:Destroy()
			end
		else
			IncorrectKeyNotification()
		end
  	end    
})
