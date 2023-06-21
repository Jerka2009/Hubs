local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Key System", HidePremium = false, SaveConfig = true, IntroEnabled = false})

OrionLib:MakeNotification({
	Name = "Key system loaded",
	Content = "You're logged in as "..game:GetService("Players").LocalPlayer.Name..".",
	Image = "rbxassetid://4483345998",
	Time = 5
})

_G.Key = loadstring(game:HttpGet("https://raw.githubusercontent.com/vova999000333/Hubs/main/key.lua"))()
_G.KeyInput = "string"
_G.HasKey = false

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
	Default = "Key",
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
			MakeScriptHub()
			game.CoreGui.Orion:Destroy()
			_G.HasKey = true
		else
			_G.HasKey = false
			IncorrectKeyNotification()
		end
  	end    
})
