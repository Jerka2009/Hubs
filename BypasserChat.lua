--[[ Made by ArasOfficial#8439 and tav#8870.
	Remake by Jerka2009

loadstring(game:HttpGet(("https://raw.githubusercontent.com/legitimate0x1/ChatBypasser/main/Loader"), true))()
--]]

if getgenv().CB_LU ~= true then return loadstring(game:HttpGet(("https://raw.githubusercontent.com/yenil140/ChatBypasser/main/Loader"), true))() end
if getgenv().CB_LOADED then return game:GetService("StarterGui"):SetCore("SendNotification",{Title="Chat Bypasser",Text="Chat Bypasser is already running.",Icon="rbxassetid://6238540373",Duration=5}) end

if pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/yenil140/ChatBypasser/main/Version'))() end) then
	if Version == "PATCHED" then
		return game.Players.LocalPlayer:Kick("[Chat Bypasser]: PATCHED!")
	end
end

getgenv().CB_LOADED = true

local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local SoundsFolder = game.CoreGui.RobloxGui.Sounds
local ButtonClick = Instance.new("Sound", SoundsFolder)

ButtonClick.Name = "ButtonClick" ButtonClick.SoundId = "rbxassetid://9113649171"

local CG = game.Players.LocalPlayer.PlayerGui.Chat

local Bypasses = {
	["ass"] = "as{{axdaxdaxd:s}}",
	["asshole"] = "as{{asdasdasd:shole}}",
	["bitch"] = "bit{{asdasdasd:ch}}",
	["cock"] = "co{{asdasdasd:ck}}",
	["cunt"] = "cu{{asdasdasd:nt}}",
	["dick"] = "dic{{zczxczvz:k}}",
	["dyke"] = "dy{{asdasdasd:ke}}",
	["faggot"] = "fa{{asdasdasd:ggot}}",
	["fuck"] = "fu{{asdasdasd:ck}}",
	["gaylord"] = "gayl{{asdasdasd:ord}}",
	["kike"] = "ki{{asdasdasd:ke}}",
	["motherfucker"] = "motherf{{asdasdasd:ucker}}",
	["nigga"] = "ni{{asdasdasd:gga}}",
	["nigger"] = "ni{{asdasdasd:gger}}",
	["niggers"] = "ni{{asdasdasd:ggers}}",
	["piss"] = "p{{asdasdasd:iss}}",
	["penis"] = "pe{{asdasdasd:nis}}",
	["pussy"] = "pu{{asdasdasd:ssy}}",
	["shit"] = "sh{{asdasdasd:it}}",
	["shitty"] = "sh{{asdasdasd:itty}}",
	["slut"] = "sl{{asdasdasd:ut}}",
	["whore"] = "who{{asdasdasd:re}}",
	["discord"] = "disco{{asdasdasd:rd}}",
	["kys"] = "k{{asdasdasd:ys}}",
	["kill"] = "ki{{asdasdasd:ll}}",
	["sperm"] = "sper{{asdasdasd:m}}",
	["bastard"] = "bastar{{asdasdasd:d}}",
	["sex"] = "se{{asdasdasd:x}}",
	["sexual"] = "se{{asdasdasd:xual}}",
	["wtf"] = "w{{asdasdasd:tf}}",
	["rape"] = "ra{{asdasdasd:pe}}",
	["naked"] = "na{{asdasdasd:ked}}",
	["queer"] = "qu{{asdasdasd:eer}}",
	["boob"] = "boo{{asdasdasd:b}}",
	["boobs"] = "boo{{asdasdasd:bs}}",
	["gay"] = "g{{axdaxdaxd:ay}}",
	["fucked"] = "fu{{asdasdasd:cked}}",
	["fucking"] = "fvc{{asdasdasd:king}}",
	["cum"] = "cu{{asdasdasd:m}}",
	["vagina"] = "va{{asdasdasd:gina}}",
	["hitler"] = "hit{{asdasdasd:ler}}",
	["horny"] = "h{{asdasdasd:orny}}",
	["shag"] = "sh{{asdasdasd:ag}}",
	["shitmagnet"] = "sh{{asdasdasd:itmagnet}}",
	["arse"] = "ar{{asdasdasd:se}}",
	["arsebadger"] = "ars{{asdasdasd:ebadger}}",
	["dildo"] = "d{{asdasdasd:ildo}}",
	["lmao"] = "l{{asdasdasd:mao}}",
	["lmfao"] = "lm{{asdasdasd:fao}}",
	["fanny"] = "fan{{asdasdasd:ny}}",
	["fuckwit"] = "fvc{{asdasdasd:kwit}}",
	["dating"] = "dat{{asdasdasd:ing}}",
	["porn"] = "po{{asdasdasd:rn}}",
	["smack"] = "sm{{asdasdasd:ack}}"
}

local Remote = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents"):FindFirstChild("SayMessageRequest")

if getgenv().CB_ChatType ~= nil then
	if getgenv().CB_ChatType ~= "Default" then
		Remote = getgenv().CB_RemoteEvent
	elseif not game:GetService("ReplicatedStorage"):FindFirstChild("SayMessageRequest", true) then
		game.Players.LocalPlayer:Kick("[Chat Bypasser]: RemoteEvent not found! Use custom chat.")
	end	
end

local ChatBypass; ChatBypass = hookmetamethod(Remote, "__namecall", function(self, ...)
	local Method = getnamecallmethod()
	local Arguments = {...}

	if self == Remote and Method == "FireServer" then
		local Message = Arguments[1]
		local Split = Message:split(" ")
		local FinalMessage = ""

		for _, x in next, Split do
			for _, Bypass in next, Bypasses do
				if x:lower() == _ then
					if x:upper() ~= x then
						Message = Message:gsub(x, Bypass)
						FinalMessage = Message .. getgenv().CB_Symbol
					else
						Message = Message:gsub(x, Bypass):upper()
						FinalMessage = Message:gsub(x, Bypass):upper() .. getgenv().CB_Symbol
					end
				end
			end
		end

		if FinalMessage ~= "" and getgenv().CB_AutoBypass then
			Arguments[1] = FinalMessage
		end

		return ChatBypass(self, unpack(Arguments))
	end

	return ChatBypass(self, ...)
end)

local X = Material.Load({
	Title = "Origane - Bypasser",
	Style = 2,
	SizeX = 275,
	SizeY = 295,
	Theme = "Dark",
})

local Page1 = X.New({
	Title = "Pre-Made"
})

local Page2 = X.New({
	Title = "Settings"
})

local Page3 = X.New({
	Title = "Script"
})

local Page4 = X.New({
	Title = "Others"
})

local MyButton = Page1.Button({
	Text = "Fuck",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Fu{{%s:ck}}! " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Fucking",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Fvc{{%s:king}}... " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Fucked",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Fu{{%s:cked}}! " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})



local MyButton = Page1.Button({
	Text = "Fuck You",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Fu{{%s:ck}} You! " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Rape",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Ra{{%s:pe}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "I'll rape you",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("I'll ra{{%s:pe}} you. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "I'll rape your mom",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("I'll ra{{%s:pe}} your mom. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Bitch",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Bit{{%s:ch}}! " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Bitches",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Bit{{%s:ches}}! " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Be my wife",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Be my w{{%s:ife}}! " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Nigga",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Ni{{%s:gga}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Nigger",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Ni{{%s:gger}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Niggers",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Ni{{%s:ggers}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Piss",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Pi{{%s:ss}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Go down. I will piss to your face.",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Go down. I will pi{{%s:ss}} to your face. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Bastard",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Bastar{{%s:d}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Discord",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Disco{{%s:rd}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Shit",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Sh{{%s:it}}! " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Shitty",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Sh{{%s:itty}}! " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Shitmagnet",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Sh{{%s:itmagnet}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})


local MyButton = Page1.Button({
	Text = "WTF",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("W{{%s:TF}}!? " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Sex",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Se{{%s:x}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Sexual",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("S{{%s:exual}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Gay",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("G{{%s:ay.}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Fuck Roblox",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Fu{{%s:ck}} Roblox! " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Gaylord",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("G{{%s:aylord}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Hitler",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Hit{{%s:ler}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Porn",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Po{{%s:rn}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Porn Hub",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Po{{%s:rn}} Hub. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})


local MyButton = Page1.Button({
	Text = "Visit Porn Hub to get free bobux",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Visit Po{{%s:rn}} Hub to get free bobux! " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Cum",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Cu{{%s:m}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "LMAO",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("L{{%s:MAO}}! " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "LMFAO",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("LM{{%s:FAO}}! " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Arse",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Ar{{%s:se}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Arsebadger",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Ars{{%s:ebadger}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Fanny",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Fan{{%s:ny}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Horny",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("H{{%s:orny}}! " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Fuckwit",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Fvc{{%s:kwit}}! " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Boob",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Boo{{%s:b}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Boobs",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Boo{{%s:bs}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Shag",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Sh{{%s:ag}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Nice vagina",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Nice va{{%s:gina}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Pussy",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Pu{{%s:ssy}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Cunt",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Cu{{%s:nt}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Slut",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Sl{{%s:ut}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Kike",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Ki{{%s:ke}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Kys",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Ky{{%s:s}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Cock",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Co{{%s:ck}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Ass",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("A{{%s:ss}}! " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Asshole",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("As{{%s:shole}}! " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Faggot",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Fa{{%s:ggot}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Queer",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Qu{{%s:eer}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Penis",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Pe{{%s:nis}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Sperm",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Sper{{%s:m}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Whore",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Who{{%s:re}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Naked",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Na{{%s:ked}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Dyke",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Dy{{%s:ke}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Smack to your own ass",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Smack to your own a{{%s:ss}}! " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyButton = Page1.Button({
	Text = "Dating",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		Remote:FireServer(("Dat{{%s:ing}}. " .. getgenv().CB_Symbol):format(getgenv().CB_Bytecode), "All")
	end
})

local MyToggle = Page2.Toggle({
	Text = "Anti Mute",
	Callback = function()
		if getgenv().CB_AntiMute == false then
			getgenv().CB_AntiMute = true
		else
			getgenv().CB_AntiMute = false
		end
	end
})

local MyToggle = Page2.Toggle({
	Text = "Auto Bypass",
	Callback = function()
		if getgenv().CB_AutoBypass == false then
			getgenv().CB_AutoBypass = true
		else
			getgenv().CB_AutoBypass = false
		end
	end
})

local MyButton = Page3.Button({
	Text = "Reload Script",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		wait(0.5)
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Destroy()
		
		getgenv().CB_Symbol = nil
		getgenv().CB_Bytecode = nil
		getgenv().CB_ChatType = nil
		getgenv().CB_AntiMute = nil
		getgenv().CB_AutoBypass = nil
		getgenv().CB_LU = nil
		getgenv().CB_LOADED = nil

		loadstring(game:HttpGet(("https://raw.githubusercontent.com/yenil140/ChatBypasser/main/Loader"), true))()
		game.CoreGui["Chat Bypasser"]:Destroy()
	end
})

local MyButton = Page3.Button({
	Text = "Remove Script",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		wait(0.5)
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Destroy()
		
		getgenv().CB_Symbol = nil
		getgenv().CB_Bytecode = nil
		getgenv().CB_ChatType = nil
		getgenv().CB_AntiMute = nil
		getgenv().CB_AutoBypass = nil
		getgenv().CB_LU = nil
		getgenv().CB_LOADED = nil

		game.CoreGui["Chat Bypasser"]:Destroy()
	end
})

local MyTextField = Page4.TextField({
	Text = "Kaid#0001's Chat Bypass",
	Callback = function(a)
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()

		local Message= a

		math.randomseed(tick())
		local ChatMain = require(game:GetService("Players").LocalPlayer.PlayerScripts.ChatScript.ChatMain)

		local function bypass()
			ChatMain.MessagePosted:fire("dffhdfshfd"..math.random(100000,1000000))
			ChatMain.MessagesChanged:fire(math.random(100000,1000000))
		end

		for v in Message:gmatch"." do
			wait(.5)
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(v, "All")
			wait(.5)
			bypass()
		end
	end
})

local MyButton = Page4.Button({
	Text = "Shed's Bypasser",
	Callback = function()
		game.CoreGui.RobloxGui.Sounds.ButtonClick:Play()
		loadstring(game:HttpGet("https://the-shed.dev/scripts/sbp.lua", true))()
	end
})

while wait(0.5) do
	if CG.Enabled ~= true and getgenv().CB_AntiMute then CG.Enabled = true end
	if getgenv().CB_AntiMute and game:GetService("StarterGui"):GetCoreGuiEnabled(Enum.CoreGuiType.Chat) ~= true then game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true) end

	for i,v in pairs(CG:GetDescendants()) do
		if v:IsA("Frame") and v.Name ~= "ChannelsBarParentFrame"  then
			if v.Visible ~= true and getgenv().CB_AntiMute then
				v.Visible = true
			end 
		end
	end
end
