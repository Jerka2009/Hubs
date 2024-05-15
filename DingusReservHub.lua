local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local Plr = Players.LocalPlayer
local Char = Plr.Character
local Rep = game:GetService("ReplicatedStorage")
local TaskTable = {{20,19,16,18},{6,7,8,9}}
local ChangeColorTable = {17,10}
function GetMap()
	if game.Workspace.LoadedMap:FindFirstChild("Bank") then
		return 2
	else
		return 1
	end
end
function Notify(Title,Content,Dur,Img)
	Rayfield:Notify({Title = Title,Content = Content,Duration = Dur,Image = Img})
end

function RoundStarted()
	return Rep.RoundActive.Value
end

function PlayerTeam()
	if RoundStarted() then
		if game.Players.LocalPlayer.Character.FancyHat.Transparency == 0 then
			return 2
		else
			return 1
		end
	end
end
local Window = Rayfield:CreateWindow({Name = "Window for: "..Plr.DisplayName,LoadingTitle = "By blackassniger",LoadingSubtitle = "Loading...",})
local Misc = Window:CreateTab("Misc", 12120687742)
local Troll = Window:CreateTab("Troll", 7258918524)
Notify("Loaded!","This script is Open Source!",3,111291109)
-- Misc
local Win = Misc:CreateButton({
   Name = "Win",
   Callback = function()
   		if PlayerTeam() == 1 then
   			for i=1,25,1 do
   				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("InvokeTaskCompleted"):InvokeServer(i)
   			end
   		else
   			for i,v in pairs(Players:GetChildren()) do
   				if v ~= Plr then
   					game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("KillCharacter"):InvokeServer(game.Workspace:FindFirstChild(v.Name))
   				end
   			end
   		end
   end,
})
local KillPlayer = Misc:CreateInput({
   Name = "Kill Player",
   PlaceholderText = "Name",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   		if Text ~= "" then
   			if PlayerTeam() == 2 then
   				asdasd = false
				for i,v in pairs(game:FindService("Players"):GetPlayers()) do
					if v.Name:lower():sub(1, #Text) == Text:lower() then
						Notify("Killed",v.Name,3,5726383102)
						asdasd = true
						game:GetService("ReplicatedStorage").Remotes.KillCharacter:InvokeServer(game.Workspace:FindFirstChild(v.Name))
					end
				end 
				if asdasd ~= true then
					Notify("Player: "..Text.." Not Found","",3,11786143762)
				end
			else
				Notify("You Not Sheriff","",3,11786143762)
			end
		end
   end,
})
local ESP = Misc:CreateToggle({
   Name = "Esp",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
  		if PlayerTeam() == 2 then
   				if Value == true then
   					for i,v in pairs(game.Players:GetChildren()) do
						if v.Character:FindFirstChild("FancyHat") then
   							if v.Character.FancyHat.Transparency ~= 0 then
   								v.Character.PlayerOutline.Enabled = true
   							end
   						end
					end
   				else
   				for i,v in pairs(game.Players:GetChildren()) do
					if v.Character:FindFirstChild("FancyHat") then
   						if v.Character.FancyHat.Transparency ~= 0 then
   							v.Character.PlayerOutline.Enabled = false
   						end
   					end
				end
   			end
   		end
   end,
})
local LoopWin = Misc:CreateToggle({
   Name = "Loop Win",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
   		getgenv().LoopWin = Value
   		while getgenv().LoopWin == true do
   			wait(0) -- Kinda anticrash
   			if RoundStarted() then
   				if PlayerTeam() == 1 then
   					for i=1,25,1 do
   						game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("InvokeTaskCompleted"):InvokeServer(i)
   					end
   				else
   					for i,v in pairs(Players:GetChildren()) do
   						if v ~= Plr then
   							game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("KillCharacter"):InvokeServer(game.Workspace:FindFirstChild(v.Name))
   						end
   					end
   				end
   			end
   		end
   end,
})
-- Troll
local ChangeColor = Troll:CreateButton({
   Name = "Change Color",
   Callback = function()
   game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("InvokeTaskCompleted"):InvokeServer(ChangeColorTable[GetMap()])
   end,
})
local LoopChangeColor = Troll:CreateToggle({
   Name = "Loop Change Color",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
   	getgenv().LoopChangeColor = Value
   		while getgenv().LoopChangeColor == true do
   			wait(0)
   			game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("InvokeTaskCompleted"):InvokeServer(ChangeColorTable[GetMap()])
   		end
   end,
})
local SmokeSafeZone = Troll:CreateToggle({
   Name = "Smoke Safe Zone",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
	   getgenv().SmokeSafeZone = Value
	   while true do
	   		while getgenv().SmokeSafeZone == true do
	   			wait(0)
	   			for i,v in pairs(TaskTable[GetMap()]) do
	   				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("InvokeTaskCompleted"):InvokeServer(v)
	   			end
	   		end
	   	end
   end,
})
