shared.ranxUsers = {}

local customStore = {
    remotes = {
		shootEvent = game.ReplicatedStorage.Remotes.Shoot,
		throwStartEvent = game.ReplicatedStorage.Remotes.ThrowStart,
		throwHitEvent = game.ReplicatedStorage.Remotes.ThrowHit,
		stabEvent = game.ReplicatedStorage.Remotes.Stab,
		onMatchFinished = game.ReplicatedStorage.Remotes.OnMatchFinished,
		onRoundEnded = game.ReplicatedStorage.Remotes.OnRoundEnded,
		onPlayerKilled = game.ReplicatedStorage.Remotes.OnPlayerKilled,
		onRoleSelection = game.ReplicatedStorage.Remotes.OnRoleSelection
	},
	you = {
		lplr = game.Players.LocalPlayer,
		char = game.Players.LocalPlayer.Character,
		hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"),
		status = {
			matchId = 0,
			inMatch = false,
			gamemode = "classic",
			team = nil
		}
	},
	playersUsingRanxware = {}
}
local funcs = {
	calculateAngleBetweenPositions = function(pos1,pos2)
		local normal = Vector3.new()
		if pos1 and pos2 then
			normal = (pos1-pos2).Unit
		end
		return -normal
	end,
	getMouseLocation = function()
		return game:GetService("UserInputService"):GetMouseLocation()
	end,
	sayMessage = function(message)
		game:GetService("TextChatService").ChatInputBarConfiguration.TargetTextChannel:SendAsync(message)
	end,
	getEnemies = function()
		local enemies = {}
		if customStore.you.status.inMatch then
			for _,plr in next,game.Players:GetPlayers() do
				if plr ~= customStore.you.lplr and plr:GetAttribute("Match") and plr:GetAttribute("Match") == customStore.you.status.matchId and plr.Team ~= customStore.you.status.team then
					if plr.Character and plr.Character.Parent == workspace then -- excludes hidden players
						table.insert(enemies,plr)
					end
				end
			end
		end
		return enemies
	end,
	getAllies = function()
		local teammates = {}
		if customStore.you.status.inMatch then
			for _,plr in next,game.Players:GetPlayers() do
				if plr ~= customStore.you.lplr and plr:GetAttribute("Match") and plr:GetAttribute("Match") == customStore.you.status.matchId and plr.Team == customStore.you.status.team then
					if plr.Character and plr.Character.Parent == workspace then -- excludes hidden players
						table.insert(teammates,plr)
					end
				end
			end
		end
		return teammates
	end,
	getTeamStatus = function(plr)
		if plr ~= customStore.you.lplr and plr:GetAttribute("Match") == customStore.you.status.matchId then
			if plr.Team ~= customStore.you.status.team then
				return "Enemy"
			else
				return "Ally"
			end
		end
	end,
	getGamemode = function()
		return customStore.you.lplr:GetAttribute("Gamemode")
	end,
	isAlive = function(character)
		return character and character:FindFirstChildOfClass("Humanoid") and character:FindFirstChildOfClass("Humanoid").Health > 0
	end,
	getPlayerNearestCursor = function(size)
		local closest = size
		local target = nil
		for _,plr in next,game.Players:GetPlayers() do
			if plr ~= customStore.you.lplr and plr:GetAttribute("Match") == customStore.you.status.matchId then
				if plr.Team ~= customStore.you.status.team then
					if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
						local vector = workspace.CurrentCamera:WorldToScreenPoint(plr.Character.HumanoidRootPart.Position)
						if vector then
							local magnitude = (game:GetService("UserInputService"):GetMouseLocation() - Vector2.new(vector.X,vector.Y)).Magnitude
							if magnitude <= closest then
								closest = magnitude
								target = plr
							end
						end
					end
				end
			end
		end
		return target
	end,
	getKnife = function()
		local knife = nil
		for _,tool in next,customStore.you.lplr.Backpack:GetChildren() do
			if tool:IsA("Tool") then
				if tool:GetAttribute("EquipAnimation") and tool:GetAttribute("EquipAnimation") == "Knife_Equip" then
					knife = tool
				end
			end
		end
		for _,tool in next,customStore.you.char:GetChildren() do
			if tool:IsA("Tool") then
				if tool:GetAttribute("EquipAnimation") and tool:GetAttribute("EquipAnimation") == "Knife_Equip" then
					knife = tool
				end
			end
		end
		return knife
	end,
	getRevolver = function()
		local revolver = nil
		for _,tool in next,customStore.you.lplr.Backpack:GetChildren() do
			if tool:IsA("Tool") then
				if tool:GetAttribute("EquipAnimation") and (tool:GetAttribute("EquipAnimation") == "Gun_Equip" or tool:GetAttribute("EquipAnimation") == "Sniper_Equip") then
					revolver = tool
				end
			end
		end
		for _,tool in next,customStore.you.char:GetChildren() do
			if tool:IsA("Tool") then
				if tool:GetAttribute("EquipAnimation") and (tool:GetAttribute("EquipAnimation") == "Gun_Equip" or tool:GetAttribute("EquipAnimation") == "Sniper_Equip") then
					revolver = tool
				end
			end
		end
		return revolver
	end
}

local ranxConnections = {
    connections = {}
}

function ranxConnections:BindConnection(name,con)
    if not ranxConnections.connections[name] then
		ranxConnections.connections[name] = con
	else
		ranxConnections.connections[name]:Disconnect()
		ranxConnections.connections[name] = con
	end
end

function ranxConnections:BindToRenderStep(name,func)
	local con = game:GetService("RunService").RenderStepped:Connect(func)
	if not ranxConnections.connections[name] then
		ranxConnections.connections[name] = con
	else
		ranxConnections.connections[name]:Disconnect()
		ranxConnections.connections[name] = con
	end
end

function ranxConnections:BindToHeartbeat(name,func)
	local con = game:GetService("RunService").Heartbeat:Connect(func)
	if not ranxConnections.connections[name] then
		ranxConnections.connections[name] = con
	else
		ranxConnections.connections[name]:Disconnect()
		ranxConnections.connections[name] = con
	end
end

function ranxConnections:BindToStep(name,func)
	local con = game:GetService("RunService").Stepped:Connect(func)
	if not ranxConnections.connections[name] then
		ranxConnections.connections[name] = con
	else
		ranxConnections.connections[name]:Disconnect()
		ranxConnections.connections[name] = con
	end
end

function ranxConnections:UnbindConnection(name)
	if ranxConnections.connections[name] then
		ranxConnections.connections[name]:Disconnect()
	end
end

local currentlyRespawning = false

customStore.you.status.team = customStore.you.lplr.Team or game.Players.LocalPlayer.Team
customStore.you.status.matchId = game.Players.LocalPlayer:GetAttribute("Match") ~= nil and game.Players.LocalPlayer:GetAttribute("Match") or 0
customStore.you.status.inMatch = (customStore.you.status.matchId ~= 0)

customStore.you.lplr.CharacterAdded:Connect(function(nchar)
	currentlyRespawning = true
	task.wait(1.5) -- "long" respawn debug delay because the script recieves errors for some reason :skull:
	customStore.you.char = nchar
	customStore.you.hum = customStore.you.char:FindFirstChildOfClass("Humanoid") or nchar:FindFirstChildOfClass("Humanoid")
	customStore.you.status.team = customStore.you.lplr.Team or game.Players.LocalPlayer.Team
	customStore.you.status.matchId = game.Players.LocalPlayer:GetAttribute("Match") ~= nil and game.Players.LocalPlayer:GetAttribute("Match") or 0
	customStore.you.status.inMatch = (customStore.you.status.matchId ~= 0)
	task.wait()
	currentlyRespawning = false
end)

local lib = loadstring(game:HttpGet('https://codeberg.org/Jerka2009/Hubs/raw/branch/main/RexHub.lua'))()
local window = lib:CreateWindow({
	Name="Organic | MVS Duels",
	LoadingTitle="MVS Duels",
	LoadingSubtitle="Edited by: Ytim_Hub",
	ConfigurationSaving={
		Enabled = false, -- Very confused on why rayfield's config saving doesn't work on my script, so it'll be disabled forever now...
	}
})

local combatTab = window:CreateTab("Combat")
local playerTab = window:CreateTab("Player")
local visualsTab = window:CreateTab("Visuals")
local miscTab = window:CreateTab("Misc")

-- COMBAT --

combatTab:CreateSection("Hitbox Configs")
task.spawn(function()
	local hitboxes = {CurrentValue = false}
	local hitboxSize = {CurrentValue = 2}
	local hitboxTransparency = {CurrentValue = 0.8}
	hitboxes = combatTab:CreateToggle({
		Name = "Hitboxes",
		CurrentValue = false,
		Callback = function(value)
			if value then
				task.spawn(function()
					repeat
						if customStore.you.status.inMatch then
							for _,i in next,funcs.getEnemies() do
								local char = i.Character
								if funcs.isAlive(char) then
									local root = char:FindFirstChild("HumanoidRootPart")
									local hitbox = root and root:FindFirstChild("Part")
									if root and hitbox then
										local legitRootSize = math.clamp(hitboxSize.CurrentValue,2,5)
										root.Size = Vector3.new(2 * legitRootSize,2 * legitRootSize,0.92 * legitRootSize)
										hitbox.Size = Vector3.new(2.4 * hitboxSize.CurrentValue,2.4 * hitboxSize.CurrentValue,1.38 * hitboxSize.CurrentValue)
										hitbox.Transparency = hitboxTransparency.CurrentValue
									end
								end
							end
						end
						task.wait()
					until not hitboxes.CurrentValue
				end)
			else
				for _,i in next,funcs.getEnemies() do
					local char = i.Character
					if funcs.isAlive(char) then
						local root = char:FindFirstChild("HumanoidRootPart")
						local hitbox = root and root:FindFirstChild("Part")
						if root and hitbox then
							root.Size = Vector3.new(2,2,0.92)
							hitbox.Size = Vector3.new(2.4,2.4,1.38)
							hitbox.Transparency = 1
						end
					end
				end
			end
		end
	})
	hitboxSize = combatTab:CreateSlider({
		Name = "Hitbox Size",
		Range = {2,12},
		CurrentValue = 2,
		Increment = 1,
		Callback = function() end
	})
	hitboxTransparency = combatTab:CreateSlider({
		Name = "Hitbox Transparency",
		Range = {0.2,1},
		CurrentValue = 0.8,
		Increment = 0.1,
		Callback = function() end
	})
end)

combatTab:CreateSection("Aimbot Configs")
task.spawn(function()
	local silentAim = {CurrentValue = false}
	local silentAimFOVSize = {CurrentValue = 100}
	local silentAimFOVVisible = {CurrentValue = true}
	local silentAimWallbang = {CurrentValue = false}

	local silentAimParams = RaycastParams.new()
	silentAimParams.IgnoreWater = true
	silentAimParams.FilterType = Enum.RaycastFilterType.Exclude
	local circle = Drawing.new("Circle")
	circle.Color = Color3.new(1,0,0)
	circle.Thickness = 1
	circle.NumSides = 1e9
	circle.Radius = 100
	circle.Filled = false
	circle.Visible = false
	local silentAimHooker;silentAimHooker = hookmetamethod(game,"__namecall",function(self,...)
		local args = {...}
		if silentAim.CurrentValue and not checkcaller() and tostring(self) == "Shoot" and getnamecallmethod() == "FireServer" then
			local nearest = funcs.getPlayerNearestCursor(silentAimFOVSize.CurrentValue)
			if nearest then
				local hitbox = nearest.Character.HumanoidRootPart
				args[2] = hitbox.CFrame.Position
				silentAimParams.FilterDescendantsInstances = {customStore.you.char}
				table.insert(silentAimParams.FilterDescendantsInstances, funcs.getAllies())
				local result = workspace:Raycast(args[1],funcs.calculateAngleBetweenPositions(args[1],hitbox.CFrame.Position) * 9e9,silentAimParams)
				if result then
					args[3] = result.Instance 
					args[4] = result.Position
					if silentAimWallbang.CurrentValue then
						args[3] = hitbox:FindFirstChild("Part")
						args[4] = hitbox.CFrame.Position
					end
				else
					args[3] = hitbox:FindFirstChild("Part")
					args[4] = hitbox.CFrame.Position
				end
			end
			return self.FireServer(self,unpack(args))
		end
		return silentAimHooker(self,...)
	end)
	silentAim = combatTab:CreateToggle({
		Name = "Revolver Silent-Aim",
		CurrentValue = false,
		Callback = function(value)
			if value then
				ranxConnections:BindToRenderStep("FOVCircleLoop",function()
					circle.Visible = silentAim.CurrentValue and silentAimFOVVisible.CurrentValue
					circle.Radius = silentAimFOVSize.CurrentValue
					circle.Position = funcs.getMouseLocation()
				end)
			else
				ranxConnections:UnbindConnection("FOVCircleLoop")
				circle.Visible = false
			end
		end
	})
	silentAimFOVSize = combatTab:CreateSlider({
		Name = "FOV Size",
		Range = {10,1000},
		Increment = 10,
		CurrentValue = 100,
		Callback = function() end
	})
	silentAimFOVVisible = combatTab:CreateToggle({
		Name = "Show FOV Circle",
		CurrentValue = true,
		Callback = function() end
	})
	silentAimWallbang = combatTab:CreateToggle({
		Name = "Blatant Mode (Wallbang)",
		CurrentValue = false,
		Callback = function() end
	})
end)

combatTab:CreateSection("Weapon Spoofs")
task.spawn(function()
	local spoofGunCooldown = {CurrentValue = false}
	local cooldownDuration = {CurrentValue = 2.5}
	spoofGunCooldown = combatTab:CreateToggle({
		Name = "Spoof Gun Cooldown",
		CurentValue = false,
		Callback = function(value)
			if value then
				task.spawn(function()
					repeat
						local revolver = funcs.getRevolver()
						if revolver then
							revolver:SetAttribute("Cooldown",cooldownDuration.CurrentValue)
						end
						task.wait()
					until not spoofGunCooldown.CurrentValue
				end)
			else
				local revolver = funcs.getRevolver()
				if revolver then
					revolver:SetAttribute("Cooldown",2.5)
				end
			end
		end
	})
	cooldownDuration = combatTab:CreateSlider({
		Name = "Cooldown Duration",
		Range = {0,2.5},
		CurrentValue = 2.5,
		Increment = 0.1,
		Callback = function()
			if spoofGunCooldown.CurrentValue then
				local revolver = funcs.getRevolver()
				if revolver and revolver.Parent == customStore.you.char then
					revolver.Parent = customStore.you.lplr.Backpack
					revolver.Parent = customStore.you.char
				end
			end
		end
	})
end)
task.spawn(function()
	local lightSpeedKnife = {CurrentValue = false}
	lightSpeedKnife = combatTab:CreateToggle({
		Name = "Fast Knife",
		CurrentValue = false,
		Callback = function(value)
			if value then
				task.spawn(function()
					repeat
						local knife = funcs.getKnife()
						if knife then
							knife:SetAttribute("ThrowSpeed",1000)
						end
						task.wait()
					until not lightSpeedKnife.CurrentValue
				end)
			else
				local knife = funcs.getKnife()
				if knife then
					knife:SetAttribute("ThrowSpeed",125)
				end
			end
		end
	})
end)
task.spawn(function()
	local noCustomCrosshair = {CurrentValue = false}
	noCustomCrosshair = combatTab:CreateToggle({
		Name = "No Custom Crosshair",
		CurrentValue = false,
		Callback = function(value)
			if value then
				task.spawn(function()
					repeat
						local knife = funcs.getKnife()
						if knife then
							knife:SetAttribute("MouseId",0)
						end
						local revolver = funcs.getRevolver()
						if revolver then
							revolver:SetAttribute("MouseId",0)
						end
						task.wait()
					until not noCustomCrosshair.CurrentValue
				end)
			end
		end
	})
end)
task.spawn(function()
	local customGunAnimation = {CurrentValue = false}
	customGunAnimation = combatTab:CreateToggle({
		Name = "Custom Gun Animation",
		CurrentValue = false,
		Callback = function(value)
			if value then
				task.spawn(function()
					repeat
						local revolver = funcs.getRevolver()
						if revolver then
							revolver:SetAttribute("EquipAnimation","Sniper_Equip")
							revolver:SetAttribute("PulloutAnimation","Sniper_Pullout")
						end
						task.wait()
					until not customGunAnimation.CurrentValue
				end)
			end
		end
	})
end)

combatTab:CreateSection("Killaura Configs")

local usingKillAll = false
task.spawn(function()
	local rangepart = Instance.new("Part",workspace.CurrentCamera)
	rangepart.Transparency = 1
	rangepart.CanCollide = false
	rangepart.Size = Vector3.new(1,1,1)
	local rangevis = Instance.new("CylinderHandleAdornment",game.CoreGui)
	rangevis.Color3 = Color3.new(1,0,0)
	rangevis.Height = 0
	rangevis.CFrame = CFrame.new() * CFrame.fromEulerAnglesXYZ(math.rad(90),0,0)

	local killaura = {CurrentValue = false}
	local killauraRange = {CurrentValue = 12}
	local killauraShowRange = {CurrentValue = true}
	killaura = combatTab:CreateToggle({
		Name = "Killaura",
		CurrentValue = false,
		Callback = function(value)
			if value then
				ranxConnections:BindToHeartbeat("KillauraRangeVisualizer",function()
					if customStore.you.char and customStore.you.hum.Health > 0 then
						local root = customStore.you.char:FindFirstChild("HumanoidRootPart")
						if root then
							local suc,position = pcall(function() return customStore.you.char:FindFirstChild("HumanoidRootPart").Position end)
							rangepart.CFrame = CFrame.new(position.X,position.Y - 2.5,position.Z)
							rangevis.Adornee = rangepart
							rangevis.Visible = killauraShowRange.CurrentValue and killaura.CurrentValue
							rangevis.Radius = killauraRange.CurrentValue
							rangevis.InnerRadius = killauraRange.CurrentValue - 0.5
						end
					end
				end)
				task.spawn(function()
					repeat
						if not currentlyRespawning then
							if customStore.you.status.inMatch and customStore.you.hum.Health > 0 and not usingKillAll then
								local knife = funcs.getKnife()
								local revolver = funcs.getRevolver()
								for _,i in next,funcs.getEnemies() do
									local char = i.Character
									local hum = char and char:FindFirstChildOfClass("Humanoid")
									local root = char and char:FindFirstChild("HumanoidRootPart")
									if root and funcs.isAlive(char) then
										local suc,distance = pcall(function() return (customStore.you.char:WaitForChild("HumanoidRootPart").Position - root.Position).Magnitude end)
										if suc then
											if distance <= killauraRange.CurrentValue then
												if knife and knife.Parent == customStore.you.char then
													customStore.remotes.stabEvent:FireServer(unpack({
														[1] = char:FindFirstChild("Head")
													}))
												end
												if revolver and revolver.Parent == customStore.you.char then
													task.wait()
													customStore.remotes.shootEvent:FireServer(unpack({
														[1] = root.Position,
														[2] = root.Position,
														[3] = char:FindFirstChild("Head").Part,
														[4] = root.Position
													}))
												end
											end
										end
									end
								end
							end
						end
						task.wait()
					until not killaura.CurrentValue
				end)
			else
				ranxConnections:UnbindConnection("KillauraRangeVisualizer")
				rangevis.Adornee = nil
			end
		end
	})
	killauraRange = combatTab:CreateSlider({
		Name = "Killaura Range",
		Range = {4,35},
		CurrentValue = 12,
		Increment = 1,
		Suffix = "studs",
		Callback = function() end
	})
	killauraShowRange = combatTab:CreateToggle({
		Name = "Show Aura Range",
		CurrentValue = true,
		Callback = function() end
	})
end)

combatTab:CreateSection("Kill-All Configs")
task.spawn(function()
	local killAll = {CurrentValue = false}
	local killAllDelay = {CurrentValue = 0.1}

	killAll = combatTab:CreateToggle({
		Name = "Kill-All",
		CurrentValue = false,
		Callback = function(value)
			usingKillAll = value
			if value then
				task.spawn(function()
					repeat
						if not currentlyRespawning then
							task.wait(0.5)
							if customStore.you.status.inMatch and funcs.isAlive(customStore.you.char) then
								local knife = funcs.getKnife()
								local revolver = funcs.getRevolver()
								if knife then
									if knife.Parent == customStore.you.lplr.Backpack then
										pcall(function() knife.Parent = customStore.you.char end)
									end
								else
									if revolver then
										if revolver.Parent == customStore.you.lplr.Backpack then
											pcall(function() revolver.Parent = customStore.you.char end)
										end
									end
								end
								for _,i in next,funcs.getEnemies() do
									local char = i.Character
									local hum = char and char:FindFirstChildOfClass("Humanoid")
									local root = char and char:FindFirstChild("HumanoidRootPart")
									if root and funcs.isAlive(char) then
										if knife then
											task.wait()
											customStore.remotes.throwHitEvent:FireServer(unpack({
												[1] = char:FindFirstChild("Head").Part,
												[2] = Vector3.new()
											}))
										else
											if revolver then
												task.wait()
												customStore.remotes.shootEvent:FireServer(unpack({
													[1] = root.Position,
													[2] = root.Position,
													[3] = char:FindFirstChild("Head").Part,
													[4] = root.Position
												}))
											end
										end
										task.wait(killAllDelay.CurrentValue)
									end
								end
							end
						end
						task.wait()
					until not killAll.CurrentValue
				end)
			end
		end
	})
	killAllDelay = combatTab:CreateSlider({
		Name = "Kill-All Delay",
		Range = {0.1,0.8},
		CurrentValue = 0.1,
		Increment = 0.1,
		Callback = function() end
	})
end)

-- PLAYER --

playerTab:CreateSection("Speed Spoofs")
task.spawn(function()
	local walkspeed = {CurrentValue = false}
	local walkspeedValue = {CurrentValue = 16}

	walkspeed = playerTab:CreateToggle({
		Name = "Spoof Speed",
		CurrentValue = false,
		Callback = function(value)
			if value then
				ranxConnections:BindToHeartbeat("SpeedSpoofer",function(delta)
					if not currentlyRespawning then
						if funcs.isAlive(customStore.you.char) then
							local movevec = (customStore.you.hum.MoveDirection).Unit
							movevec = movevec == movevec and Vector3.new(movevec.X, 0, movevec.Z) or Vector3.new()
							local vel = movevec * walkspeedValue.CurrentValue
							customStore.you.char:WaitForChild("HumanoidRootPart").Velocity = Vector3.new(vel.X,customStore.you.char:WaitForChild("HumanoidRootPart").Velocity.Y,vel.Z)
						end
					end
				end)
			else
				ranxConnections:UnbindConnection("SpeedSpoofer")
			end
		end
	})
	walkspeedValue = playerTab:CreateSlider({
		Name = "Speed Value",
		Range = {16,100},
		CurrentValue = 16,
		Increment = 1,
		Callback = function() end
	})
end)

local usingFly = false
local usingInfiniteJump = false

playerTab:CreateSection("Fly Configs")
task.spawn(function()
	local flyingUp = false
	local flyingDown = false

	local fly = {CurrentValue = false}
	local flySpeed = {CurrentValue = 16}
	local flyVerticalSpeed = {CurrentValue = 50}
	local flyKeys = {CurrentOption = {"Space/LeftControl"}}

	fly = playerTab:CreateToggle({
		Name = "Fly [WIP]",
		CurrentValue = false,
		Callback = function(value)
			usingFly = value
			if value then
				ranxConnections:BindConnection("FlyMovmentBind1",game:GetService("UserInputService").InputBegan:Connect(function(input,gpe)
					if game:GetService("UserInputService"):GetFocusedTextBox() ~= nil then return end
					local division = string.split(flyKeys.CurrentOption[1],"/")
					if input.KeyCode == Enum.KeyCode[division[1]] then
						flyingUp = true
					elseif input.KeyCode == Enum.KeyCode[division[2]] then
						flyingDown = true
					end
				end))
				ranxConnections:BindConnection("FlyMovmentBind2",game:GetService("UserInputService").InputEnded:Connect(function(input,gpe)
					local division = string.split(flyKeys.CurrentOption[1],"/")
					if input.KeyCode == Enum.KeyCode[division[1]] then
						flyingUp = false
					elseif input.KeyCode == Enum.KeyCode[division[2]] then
						flyingDown = false
					end
				end))
				ranxConnections:BindToHeartbeat("FlyLoop",function(delta)
					if not currentlyRespawning then
						if funcs.isAlive(customStore.you.char) then
							customStore.you.hum:ChangeState(Enum.HumanoidStateType.Freefall)
							local movevec = (customStore.you.hum.MoveDirection).Unit
							movevec = movevec == movevec and Vector3.new(movevec.X, 0, movevec.Z) or Vector3.new()
							customStore.you.char:WaitForChild("HumanoidRootPart").Velocity = (movevec * flySpeed.CurrentValue) + Vector3.new(0, (flyingUp and flyVerticalSpeed.CurrentValue or 0) + (flyingDown and -flyVerticalSpeed.CurrentValue or 0), 0)
						end
					end
				end)
			else
				flyUp = false
				flyDown = false
				ranxConnections:UnbindConnection("FlyMovmentBind1")
				ranxConnections:UnbindConnection("FlyMovmentBind2")
				ranxConnections:UnbindConnection("FlyLoop")
			end
		end
	})
	flySpeed = playerTab:CreateSlider({
		Name = "Fly Speed",
		Range = {16,100},
		Increment = 1,
		CurrentValue = 16,
		Callback = function() end
	})
	flyVerticalSpeed = playerTab:CreateSlider({
		Name = "Fly Vertical Speed",
		Range = {20,150},
		Increment = 2,
		CurrentValue = 50,
		Callback = function() end
	})
	flyKeys = playerTab:CreateDropdown({
		Name = "Fly Keys",
		Options = {"Space/LeftControl","Space/LeftShift","E/Q","Space/Q"},
		CurrentOption = {"Space/LeftControl"},
		Callback = function() end
	})
end)

playerTab:CreateSection("Humanoid Misc Spoofs")
task.spawn(function()
	local infJump = {CurrentValue = false}
	infJump = playerTab:CreateToggle({
		Name = "Infinite Jump",
		CurrentValue = false,
		Callback = function(value)
			usingInfiniteJump = value
			if value then
				ranxConnections:BindConnection("Flyjump",game:GetService("UserInputService").JumpRequest:Connect(function()
					if not currentlyRespawning and funcs.isAlive(customStore.you.char) and not usingFly then
						customStore.you.hum:ChangeState(Enum.HumanoidStateType.Jumping)
					end
				end))
			else
				ranxConnections:UnbindConnection("Flyjump")
			end
		end
	})
end)

task.spawn(function()
	local spinbot = {CurrentValue = false}
	local spinbotSpeed = {CurrentValue = 10}
	spinbot = playerTab:CreateToggle({
		Name = "Spinbot",
		CurrentValue = false,
		Callback = function(value)
			if value then
				ranxConnections:BindToHeartbeat("SpinbotLoop",function()
					if not currentlyRespawning and funcs.isAlive(customStore.you.char) then
						local originalRot = customStore.you.char:WaitForChild("HumanoidRootPart").RotVelocity
						customStore.you.char:WaitForChild("HumanoidRootPart").RotVelocity = Vector3.new(originalRot.X,spinbotSpeed.CurrentValue,originalRot.Z)
					end
				end)
			else
				ranxConnections:UnbindConnection("SpinbotLoop")
			end
		end
	})
	spinbotSpeed = playerTab:CreateSlider({
		Name = "Spinbot Speed",
		Range = {2,100},
		Increment = 2,
		CurrentValue = 10,
		Callback = function() end
	})
end)

playerTab:CreateSection("BHop Configs")
task.spawn(function()
	local bhop = {CurrentValue = false}
	local bhopHeight = {CurrentValue = 25}
	local bhopLegit = {CurrentValue = false}

	bhop = playerTab:CreateToggle({
		Name = "BHop",
		CurrentValue = false,
		Callback = function(value)
			if value then
				ranxConnections:BindToHeartbeat("Spamjump",function()
					if not currentlyRespawning then
						if customStore.you.char and funcs.isAlive(customStore.you.char) then
							if customStore.you.hum.FloorMaterial ~= Enum.Material.Air and customStore.you.hum.MoveDirection ~= Vector3.new() and not usingInfiniteJump and not usingFly then
								if bhopLegit.CurrentValue then
									customStore.you.hum:ChangeState(Enum.HumanoidStateType.Jumping)
								else
									customStore.you.char:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(customStore.you.char:FindFirstChild("HumanoidRootPart").Velocity.X,bhopHeight.CurrentValue,customStore.you.char:FindFirstChild("HumanoidRootPart").Velocity.Z)
								end
							end
						end
					end
				end)
			else
				ranxConnections:UnbindConnection("Spamjump")
			end
		end
	})
	bhopHeight = playerTab:CreateSlider({
		Name = "BHop Height",
		Range = {15,40},
		CurrentValue = 25,
		Increment = 5,
		Callback = function() end
	})
	bhopLegit = playerTab:CreateToggle({
		Name = "Legit BHop",
		CurrentValue = false,
		Callback = function() end
	})
end)

local chatSpamBlockingAutoToxic = false
playerTab:CreateSection("Auto-Toxic Configs")
task.spawn(function()
	-- (vape v4 skid :skull:)
	local autoToxic = {CurrentValue = false}
	local autoGG = {CurentValue = true}
	local autoGGMode = {CurrentOption = {"gg"}}
	local autoToxicRoundEnded = {CurentValue = false}
	local autoToxicMatchEnded = {CurrentValue = true}
	local autoToxicPlayerKilled = {CurrentValue = false}
	local autoToxicRoundEndedPhrase = ""
	local autoToxicMatchEndedPhrase = ""
	local autoToxicPlayerKilledPhrase = ""

	autoToxic = playerTab:CreateToggle({
		Name = "Auto-Toxic",
		CurrentValue = false,
		Callback = function(value)
			if value then
				ranxConnections:BindConnection("AutoGG",customStore.remotes.onMatchFinished.OnClientEvent:Connect(function()
					if customStore.you.status.inMatch then
						if not chatSpamBlockingAutoToxic then
							if autoGG.CurrentValue then
								funcs.sayMessage(autoGGMode.CurrentOption[1])
							end
						end
					end
				end))
				ranxConnections:BindConnection("AutoToxicRoundEnded",customStore.remotes.onRoundEnded.OnClientEvent:Connect(function(result)
					if customStore.you.status.inMatch then
						if not chatSpamBlockingAutoToxic then
							if autoToxicRoundEnded.CurrentValue and string.lower(result) == "won" then
								funcs.sayMessage(autoToxicRoundEndedPhrase ~= "" and autoToxicRoundEndedPhrase or "ez win LLL | Organic Hub")
							end
						end
					end
				end))
				ranxConnections:BindConnection("AutoToxicMatchEnded",customStore.remotes.onMatchFinished.OnClientEvent:Connect(function(result)
					if customStore.you.status.inMatch then
						if not chatSpamBlockingAutoToxic then
							if autoToxicMatchEnded.CurrentValue and string.lower(result) == "won" then
								funcs.sayMessage(autoToxicMatchEndedPhrase ~= "" and autoToxicMatchEndedPhrase or "EZZZZZ | Organic Hub")
							end
						end
					end
				end))
				ranxConnections:BindConnection("AutoToxicPlayerKilled",customStore.remotes.onPlayerKilled.OnClientEvent:Connect(function(player,owner)
					if owner == customStore.you.lplr and customStore.you.status.inMatch then
						if not chatSpamBlockingAutoToxic then
							if autoToxicPlayerKilled.CurrentValue and funcs.getTeamStatus(player) == "Enemy" then
								local message = autoToxicPlayerKilledPhrase ~= "" and autoToxicPlayerKilledPhrase or "L <name> | Organic Hub"
								if message then
									message = string.gsub(message,"<name>",player.Name)
								end
								funcs.sayMessage(message)
							end
						end
					end
				end))
			else
				ranxConnections:UnbindConnection("AutoGG")
				ranxConnections:UnbindConnection("AutoToxicRoundEnded")
				ranxConnections:UnbindConnection("AutoToxicMatchEnded")
				ranxConnections:UnbindConnection("AutoToxicPlayerKilled")
			end
		end
	})
	autoGG = playerTab:CreateToggle({
		Name = "Auto-GG",
		CurrentValue = true,
		Callback = function() end
	})
	autoGGMode = playerTab:CreateDropdown({
		Name = "Auto-GG Phrase",
		Options = {"gg","ggs","GG","wp","good game","well played","EZ","ez"},
		CurrentOption = {"gg"},
		Callback = function() end
	})
	autoToxicRoundEnded = playerTab:CreateToggle({
		Name = "Auto-Toxic | Round Ended",
		CurrentValue = false,
		Callback = function() end
	})
	playerTab:CreateInput({
		Name = "Round Ended Phrase",
		PlaceholderText = "phrase if you won the round",
		RemoveTextAfterFocusLost = false,
		Callback = function(value)
			autoToxicRoundEndedPhrase = value
		end
	})
	autoToxicMatchEnded = playerTab:CreateToggle({
		Name = "Auto-Toxic | Match Finished",
		CurrentValue = true,
		Callback = function() end
	})
	playerTab:CreateInput({
		Name = "Match Finished Phrase",
		PlaceholderText = "phrase if you won the match",
		RemoveTextAfterFocusLost = false,
		Callback = function(value)
			autoToxicRoundEndedPhrase = value
		end
	})
	autoToxicPlayerKilled = playerTab:CreateToggle({
		Name = "Auto-Toxic | Player Killed",
		CurrentValue = false,
		Callback = function() end
	})
	playerTab:CreateInput({
		Name = "Player Killed Phrase",
		PlaceholderText = "use <name> for recently killed players",
		RemoveTextAfterFocusLost = false,
		Callback = function(value)
			autoToxicPlayerKilledPhrase = value
		end
	})
end)

playerTab:CreateSection("Chat-Spammer Configs")
task.spawn(function()
	local chatSpammer = {CurrentValue = false}
	local chatSpammerMessage = ""
	local chatSpammerDelay = {CurrentValue = 0.01}
	
	chatSpammer = playerTab:CreateToggle({
		Name = "Spam Chat",
		CurrentValue = false,
		Callback = function(value)
			chatSpamBlockingAutoToxic = value
			if value then
				task.spawn(function()
					repeat
						funcs.sayMessage(chatSpammerMessage or "ranxware v2 on top W")
						task.wait(chatSpammerDelay.CurrentValue)
					until not chatSpammer.CurrentValue
				end)
			end
		end
	})
	chatSpammerMessage = playerTab:CreateInput({
		Name = "Message",
		PlaceholderText = "message to spam",
		RemoveTextAfterFocusLost = false,
		Callback = function(value)
			chatSpammerMessage = value
		end
	})
	chatSpammerDelay = playerTab:CreateSlider({
		Name = "Delay",
		Range = {0.01,1},
		Increment = 0.01,
		CurrentValue = 0.01,
		Callback = function() end
	})
end)

-- VISUALS --

local espOnlyOnEnemies = true
local allyColor = Color3.new(0,1,0)
local enemyColor = Color3.new(1,0,0)

local function WorldToViewportPoint(position)
	local npos,vis = workspace.CurrentCamera:WorldToViewportPoint(workspace.CurrentCamera.CFrame:pointToWorldSpace(workspace.CurrentCamera.CFrame:pointToObjectSpace(position)))
	return npos,vis
end
local function WorldToScreenPoint(position)
	local npos,vis = workspace.CurrentCamera:WorldToScreenPoint(workspace.CurrentCamera.CFrame:pointToWorldSpace(workspace.CurrentCamera.CFrame:pointToObjectSpace(position)))
	return npos,vis
end

visualsTab:CreateSection("Bounding Box ESP")
task.spawn(function()
	local boxTable = {}

	local boxESP = {CurrentValue = false}
	local function EstimatePosition(pos)
		return Vector2.new(math.floor(pos.X), math.floor(pos.Y))
	end
	local function updateBoxColor(box,color)
		if box then
			box.color = color
			box.nodes.Quad1.Color = box.color or color
		end
	end
	local function updateBoxVisibility(box,visible)
		if box then
			box.visible = visible
			box.nodes.Quad1.Visible = box.visible or visible
			box.nodes.QuadLine2.Visible = box.visible or visible
			box.nodes.QuadLine3.Visible = box.visible or visible
		end
	end
	local function drawBox(player)
		local box = {
			visible = true,
			color = Color3.new(),
			nodes = {}
		}
		box.nodes.Quad1 = Drawing.new("Square")
		box.nodes.Quad1.Visible = box.visible
		box.nodes.Quad1.ZIndex = 2
		box.nodes.Quad1.Filled = false
		box.nodes.Quad1.Thickness = 1
		box.nodes.Quad1.Transparency = 1
		box.nodes.Quad1.Color = box.color
		box.nodes.QuadLine2 = Drawing.new("Square")
		box.nodes.QuadLine2.ZIndex = 1
		box.nodes.QuadLine2.Thickness = 1
		box.nodes.QuadLine2.Filled = false
		box.nodes.QuadLine2.Transparency = 0.5
		box.nodes.QuadLine2.Visible = box.visible
		box.nodes.QuadLine2.Color = Color3.new()
		box.nodes.QuadLine3 = Drawing.new("Square")
		box.nodes.QuadLine3.ZIndex = 1
		box.nodes.QuadLine3.Thickness = 1
		box.nodes.QuadLine3.Filled = false
		box.nodes.QuadLine3.Transparency = 0.5
		box.nodes.QuadLine3.Visible = box.visible
		box.nodes.QuadLine3.Color = Color3.new()
		box.Destroy = function()
			for _,i in next,box.nodes do
				i:Remove()
			end
		end
		boxTable[player.Name] = box
	end
	local function MoveBoxes()
		for username,box in next,boxTable do
			local player = game.Players:FindFirstChild(username)
			if player and player.Character and player.Character.Parent == workspace then
				local root = player.Character:FindFirstChild("HumanoidRootPart")
				if root then
					local rootPosition, rootVisible = WorldToViewportPoint(root.Position)
					if not rootVisible then
						updateBoxVisibility(box,false)
						continue
					end
					if not player:GetAttribute("Match") or player:GetAttribute("Match") ~= customStore.you.status.matchId or not funcs.isAlive(player.Character) then
						updateBoxVisibility(box,false)
						continue
					end
					local topPosition = WorldToViewportPoint((CFrame.new(root.Position, root.Position + workspace.CurrentCamera.CFrame.LookVector) * CFrame.new(2,3,0)).Position)
					local bottomPosition = WorldToViewportPoint((CFrame.new(root.Position, root.Position + workspace.CurrentCamera.CFrame.LookVector) * CFrame.new(-2,-3.5,0)).Position)
					local relSizeX, relSizeY = (topPosition.X - bottomPosition.X), (topPosition.Y - bottomPosition.Y)
					local relPositionX, relPositionY = (rootPosition.X - relSizeX / 2), (rootPosition.Y - relSizeY / 2)
					box.nodes.Quad1.Position = EstimatePosition(Vector2.new(relPositionX,relPositionY))
					box.nodes.Quad1.Size = EstimatePosition(Vector2.new(relSizeX,relSizeY))
					box.nodes.QuadLine2.Position = EstimatePosition(Vector2.new(relPositionX - 1,relPositionY + 1))
					box.nodes.QuadLine2.Size = EstimatePosition(Vector2.new(relSizeX + 2,relSizeY - 2))
					box.nodes.QuadLine3.Position = EstimatePosition(Vector2.new(relPositionX + 1,relPositionY - 1))
					box.nodes.QuadLine3.Size = EstimatePosition(Vector2.new(relSizeX - 2,relSizeY + 2))
					updateBoxVisibility(box,true)
					if customStore.you.status.inMatch then
						if funcs.getTeamStatus(player) == "Enemy" then
							updateBoxVisibility(box,true)
							updateBoxColor(box,enemyColor)
						elseif funcs.getTeamStatus(player) == "Ally" then
							if espOnlyOnEnemies then
								updateBoxVisibility(box,false)
							else
								updateBoxVisibility(box,true)
							end
							updateBoxColor(box,allyColor)
						end
					else
						updateBoxVisibility(box,false)
					end
				end
			end
		end
	end

	boxESP = visualsTab:CreateToggle({
		Name = "Box ESP",
		CurrentValue = false,
		Callback = function(value)
			if value then
				task.spawn(function()
					for _,i in next,game.Players:GetPlayers() do
						if i ~= customStore.you.lplr then
							drawBox(i)
						end
					end
					ranxConnections:BindConnection("DrawBoxOnEntityAdded",game.Players.PlayerAdded:Connect(function(plr)
						if not boxTable[plr.Name] then drawBox(plr) end
					end))
					ranxConnections:BindConnection("RemoveBoxOnEntityRemoval",game.Players.PlayerRemoving:Connect(function(plr)
						if boxTable[plr.Name] then boxTable[plr.Name].Destroy() end
					end))
					ranxConnections:BindToRenderStep("BoxMoveLoop",function()
						MoveBoxes()
					end)
				end)
			else
				task.spawn(function()
					ranxConnections:UnbindConnection("DrawBoxOnEntityAdded")
					ranxConnections:UnbindConnection("RemoveBoxOnEntityRemoval")
					ranxConnections:UnbindConnection("BoxMoveLoop")
					for _,box in next,boxTable do
						box.Destroy()
					end
				end)
			end
		end
	})
end)

visualsTab:CreateSection("Chams ESP")
task.spawn(function()
	local chamsTable = {}

	local function drawHighlight(player)
		local highlight = Instance.new("Highlight",game.CoreGui)
		highlight.Adornee = player.Character
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		chamsTable[player.Name] = highlight
	end
	local function renewAdornee(player)
		local cham = chamsTable[player.Name]
		if cham then cham.Adornee = player.Character end
	end
	local function renewHighlights()
		for username,cham in next,chamsTable do
			local player = game.Players:FindFirstChild(username)
			if player and player.Character and player.Character.Parent == workspace then
				renewAdornee(player)
				local root = player.Character:FindFirstChild("HumanoidRootPart")
				if root then
					local _,rootVisible = WorldToViewportPoint(root.Position)
					if not rootVisible then
						cham.Enabled = false
						continue
					end
					if not player:GetAttribute("Match") or player:GetAttribute("Match") ~= customStore.you.status.matchId or not funcs.isAlive(player.Character) then
						cham.Enabled = false
						continue
					end
					cham.Enabled = true
					if customStore.you.status.inMatch then
						if funcs.getTeamStatus(player) == "Enemy" then
							cham.Enabled = true
							cham.FillColor = enemyColor
							cham.OutlineColor = enemyColor
						elseif funcs.getTeamStatus(player) == "Ally" then
							if espOnlyOnEnemies then
								cham.Enabled = false
							else
								cham.Enabled = true
							end
							cham.FillColor = allyColor
							cham.OutlineColor = allyColor
						end
					else
						cham.Enabled = false
					end
				end
			end
		end
	end

	local chamsESP = {CurrentValue = false}
	chamsESP = visualsTab:CreateToggle({
		Name = "Chams ESP",
		CurrentValue = false,
		Callback = function(value)
			if value then
				task.spawn(function()
					for _,i in next,game.Players:GetPlayers() do
						if i ~= customStore.you.lplr then
							drawHighlight(i)
						end
					end
					ranxConnections:BindConnection("DrawChamsOnEntityAdded",game.Players.PlayerAdded:Connect(function(plr)
						if not chamsTable[plr.Name] then drawHighlight(plr) end
					end))
					ranxConnections:BindConnection("RemoveChamsOnEntityRemoval",game.Players.PlayerRemoving:Connect(function(plr)
						if chamsTable[plr.Name] then chamsTable[plr.Name]:Destroy() end
					end))
					ranxConnections:BindToRenderStep("ChamsUpdateLoop",function()
						renewHighlights()
					end)
				end)
			else
				task.spawn(function()
					for _,highlight in next,chamsTable do
						ranxConnections:UnbindConnection("DrawChamsOnEntityAdded")
						ranxConnections:UnbindConnection("RemoveChamsOnEntityRemoval")
						ranxConnections:UnbindConnection("ChamsUpdateLoop")
						highlight:Destroy()
					end
				end)
			end
		end
	})
end)

visualsTab:CreateSection("Tracer ESP")
task.spawn(function()
	local tracersTable = {}
	local tracersESP = {CurrentValue = false}
	local tracerOrigin = {CurrentOption = {"Bottom"}}

	local function drawTracer(player)
		local tracer = Drawing.new("Line")
		tracer.Thickness = 2
		tracersTable[player.Name] = tracer
	end
	local function renewTracers()
		for username,tracer in next,tracersTable do
			local player = game.Players:FindFirstChild(username)
			if player and player.Character and player.Character.Parent == workspace then
				local root = player.Character:FindFirstChild("HumanoidRootPart")
				if root then
					local rootPosition,rootVisible = WorldToViewportPoint(root.Position)
					if not rootVisible then
						tracer.Visible = false
						continue
					end
					if not player:GetAttribute("Match") or player:GetAttribute("Match") ~= customStore.you.status.matchId or not funcs.isAlive(player.Character) then
						tracer.Visible = false
						continue
					end
					local resolution = workspace.CurrentCamera.ViewportSize
					if tracerOrigin.CurrentOption[1] == "Bottom" then
						tracer.From = Vector2.new(resolution.X / 2,resolution.Y)
					elseif tracerOrigin.CurrentOption[1] == "Top" then
						tracer.From = Vector2.new(resolution.X / 2,0)
					elseif tracerOrigin.CurrentOption[1] == "Mouse" then
						tracer.From = funcs.getMouseLocation()
					elseif tracerOrigin.CurrentOption[1] == "Center" then
						tracer.From = Vector2.new(resolution.X / 2,resolution.Y / 2)
					end
					tracer.To = rootPosition
					tracer.Visible = true
					if customStore.you.status.inMatch then
						if funcs.getTeamStatus(player) == "Enemy" then
							tracer.Visible = true
							tracer.Color = enemyColor
						elseif funcs.getTeamStatus(player) == "Ally" then
							if espOnlyOnEnemies then
								tracer.Visible = false
							else
								tracer.Visible = true
							end
							tracer.Color = allyColor
						end
					else
						tracer.Visible = false
					end
				end
			end
		end
	end

	tracersESP = visualsTab:CreateToggle({
		Name = "Tracers ESP",
		CurrentValue = false,
		Callback = function(value)
			if value then
				task.spawn(function()
					for _,i in next,game.Players:GetPlayers() do
						if i ~= customStore.you.lplr then
							drawTracer(i)
						end
					end
					ranxConnections:BindConnection("DrawTracersOnEntityAdded",game.Players.PlayerAdded:Connect(function(plr)
						if not tracersTable[plr.Name] then drawTracer(plr) end
					end))
					ranxConnections:BindConnection("RemoveTracersOnEntityRemoval",game.Players.PlayerRemoving:Connect(function(plr)
						if tracersTable[plr.Name] then tracersTable[plr.Name]:Destroy() end
					end))
					ranxConnections:BindToRenderStep("TracerUpdateLoop",function()
						renewTracers()
					end)
				end)
			else
				task.spawn(function()
					for _,tracer in next,tracersTable do
						ranxConnections:UnbindConnection("DrawTracersOnEntityAdded")
						ranxConnections:UnbindConnection("RemoveTracersOnEntityRemoval")
						ranxConnections:UnbindConnection("TracerUpdateLoop")
						tracer:Destroy()
					end
				end)
			end
		end
	})
	tracerOrigin = visualsTab:CreateDropdown({
		Name = "Tracer Origin",
		Options = {"Bottom","Top","Mouse","Center"},
		CurrentOption = {"Bottom"},
		Callback = function() end
	})
end)

visualsTab:CreateSection("Nametag ESP")
task.spawn(function()
	local nametagsTable = {}
	local tagTexts = {}
	local nametagsESP = {CurrentValue = false}
	local nametagsDisplayNames = {CurrentValue = true}
	local nametagsScale = {CurrentValue = 10}
	local nametagsDistance = {CurrentValue = false}

	local nametagsUI = Instance.new("ScreenGui",game.CoreGui)
	nametagsUI.Name = "RanxwareNametagsUI"

	local function drawNametag(player)
		local tag = Instance.new("TextLabel",nametagsUI)
		tag.BackgroundColor3 = Color3.new()
		tag.Visible = false
		tag.RichText = true
		tag.AnchorPoint = Vector2.new(0.5,1)
		tag.Font = Enum.Font.GothamMedium
		tag.BackgroundTransparency = 0.5
		tagTexts[player.Name] = player.Name
		nametagsTable[player.Name] = tag
	end
	local function updateNametags()
		for username,tag in next,nametagsTable do
			local player = game.Players:FindFirstChild(username)
			if player and player.Character and player.Character.Parent == workspace then
				local root = player.Character:FindFirstChild("HumanoidRootPart")
				if root then
					local rootPosition,rootVisible = WorldToViewportPoint(root.Position)
					local headPosition = WorldToScreenPoint((player.Character.Head:GetRenderCFrame() * CFrame.new(0,player.Character.Head.Size.Y + root.Size.Y,0)).Position)
					if not rootVisible then
						tag.Visible = false
						continue
					end
					if not player:GetAttribute("Match") or player:GetAttribute("Match") ~= customStore.you.status.matchId or not funcs.isAlive(player.Character) then
						tag.Visible = false
						continue
					end
					tagTexts[player.Name] = nametagsDisplayNames.CurrentValue and player.DisplayName or player.Name
					if nametagsDistance.CurrentValue then
						local suc,distance = pcall(function() return (customStore.you.char:FindFirstChild("HumanoidRootPart").Position - root.Position).Magnitude end)
						if suc then
							tagTexts[player.Name] = tagTexts[player.Name] .. ' <font color="rgb(100,255,100)">[</font><font color="rgb(255,255,255)">'..math.floor(distance)..'</font><font color="rgb(100,255,100)">]</font>'
						end
					end
					local relativeSize = game:GetService("TextService"):GetTextSize(string.gsub(string.gsub(tagTexts[player.Name],"<br%s*/>","\n"),"<[^<>]->",""),14 * (nametagsScale.CurrentValue / 10),Enum.Font.GothamMedium,Vector2.new(1e5,1e5))
					tag.TextSize = 14 * (nametagsScale.CurrentValue / 10)
					tag.Size = UDim2.new(0,relativeSize.X + 4,0,relativeSize.Y)
					tag.Position = UDim2.new(0,headPosition.X,0,headPosition.Y)
					tag.Visible = true
					if customStore.you.status.inMatch then
						if funcs.getTeamStatus(player) == "Enemy" then
							tag.Visible = true
							tag.TextColor3 = enemyColor
						elseif funcs.getTeamStatus(player) == "Ally" then
							if espOnlyOnEnemies then
								tag.Visible = false
							else
								tag.Visible = true
							end
							tag.TextColor3 = allyColor
						end
					else
						tag.Visible = false
					end
					tag.Text = tagTexts[player.Name]
				end
			end
		end
	end

	nametagsESP = visualsTab:CreateToggle({
		Name = "Nametags ESP",
		CurrentValue = false,
		Callback = function(value)
			if value then
				task.spawn(function()
					for _,i in next,game.Players:GetPlayers() do
						if i ~= customStore.you.lplr then
							drawNametag(i)
						end
					end
					ranxConnections:BindConnection("DrawNametagsOnEntityAdded",game.Players.PlayerAdded:Connect(function(plr)
						if not nametagsTable[plr.Name] then drawNametag(plr) end
					end))
					ranxConnections:BindConnection("RemoveNametagsOnEntityRemoval",game.Players.PlayerRemoving:Connect(function(plr)
						if nametagsTable[plr.Name] then nametagsTable[plr.Name]:Destroy() end
					end))
					ranxConnections:BindToRenderStep("NamtagUpdateLoop",function()
						updateNametags()
					end)
				end)
			else
				task.spawn(function()
					ranxConnections:UnbindConnection("DrawNametagsOnEntityAdded")
					ranxConnections:UnbindConnection("RemoveNametagsOnEntityRemoval")
					ranxConnections:UnbindConnection("NamtagUpdateLoop")
					for _,tracer in next,nametagsTable do
						tracer:Destroy()
					end
				end)
			end
		end
	})
	nametagsDisplayNames = visualsTab:CreateToggle({
		Name = "Use Display Names",
		CurrentValue = true,
		Callback = function() end
	})
	nametagsDistance = visualsTab:CreateToggle({
		Name = "Distance ESP",
		CurrentValue = false,
		Callback = function() end
	})
	nametagsScale = visualsTab:CreateSlider({
		Name = "Nametags Scale",
		Range = {4,18},
		CurrentValue = 10,
		Increment = 1,
		Callback = function() end
	})
end)

visualsTab:CreateSection("Visual Settings")
task.spawn(function()
	local espEnemyColor = {Color = Color3.new(1,0,0)}
	local espAllyColor = {Color = Color3.new(0,1,0)}
	local espTeamCheck = {CurrentValue = true}
	espEnemyColor = visualsTab:CreateColorPicker({
		Name = "Enemy Color",
		Color = Color3.new(1,0,0),
		Callback = function(value)
			enemyColor = value
		end
	})
	espAllyColor = visualsTab:CreateColorPicker({
		Name = "Ally Color",
		Color = Color3.new(0,1,0),
		Callback = function(value)
			allyColor = value
		end
	})
	espTeamCheck = visualsTab:CreateToggle({
		Name = "Team Check",
		CurrentValue = true,
		Callback = function(value)
			espOnlyOnEnemies = value
		end
	})
end)

visualsTab:CreateSection("World Rendering")
task.spawn(function()
	local oldLighting = {
		Brightness = 3,
		Ambient = Color3.fromRGB(70,70,70),
		OutdoorAmbient = Color3.fromRGB(70,70,70),
		GlobalShadows = true,
		ClockTime = 14.5
	}

	local fullbright = {CurrentValue = false}
	fullbright = visualsTab:CreateToggle({
		Name = "Fullbright",
		CurrentValue = false,
		Callback = function(value)
			if value then
				task.spawn(function()
					oldLighting.Brightness = game.Lighting.Brightness
					oldLighting.Ambient = game.Lighting.Ambient
					oldLighting.OutdoorAmbient = game.Lighting.OutdoorAmbient
					oldLighting.GlobalShadows = game.Lighting.GlobalShadows
					oldLighting.ClockTime = game.Lighting.ClockTime
					repeat
						game.Lighting.Brightness = 3
						game.Lighting.Ambient = Color3.fromRGB(120,120,120)
						game.Lighting.OutdoorAmbient = Color3.fromRGB(120,120,120)
						game.Lighting.GlobalShadows = false
						game.Lighting.ClockTime = 12
						task.wait()
					until not fullbright.CurrentValue
				end)
			else
				task.spawn(function()
					for property,value in next,oldLighting do
						game.Lighting[property] = value
					end
				end)
			end
		end
	})
end)

-- MISC --
miscTab:CreateSection("Auto-Choose Configs")
task.spawn(function()
	local autoChoose = {CurrentValue = false}
	local autoChooseWeapon = {CurrentOption = {"Murderer"}}
	local roleSelectionUI = customStore.you.lplr.PlayerGui.RoleSelection
	autoChoose = miscTab:CreateToggle({
		Name = "Auto-Choose Role",
		CurrentValue = false,
		Callback = function(value)
			if value then
				task.spawn(function()
					repeat
						if roleSelectionUI and roleSelectionUI.Enabled then
							if customStore.you.status.inMatch and funcs.getGamemode() == "Classic" then
								task.wait(0.3)
								customStore.remotes.onRoleSelection:FireServer(unpack({
									[1] = autoChooseWeapon.CurrentOption[1]
								}))
								task.wait()
								roleSelectionUI.Enabled = false
							end
						end
						task.wait()
					until not autoChoose.CurrentValue
				end)
			end
		end
	})
	autoChooseWeapon = miscTab:CreateDropdown({
		Name = "Role Type",
		Options = {"Murderer","Sheriff"},
		CurrentOption = {"Murderer"},
		Callback = function() end
	})
end)

-- moderator detection: [testing]
ranxConnections:BindToHeartbeat("RanxwareModeratorDetection",function()
	for _,plr in next,game.Players:GetPlayers() do
		if plr ~= customStore.you.lplr then
			local suc,rank = pcall(function() return plr:GetRankInGroup(32445464) end)
			if suc then
				if rank >= 10 and not table.find(customStore.gameModerators,plr) then -- role (in group) is moderator+
					table.insert(customStore.gameModerators,plr)
					funcs.warning({
						Title = "Moderator Detected!",
						Content = "@" .. plr.Name .. " has been detected as a moderator in MVS Duels! Please use a closet-cheating config instead or else a ban to your account will occur!",
						Duration = 8,
						Image = 7733658504
					})
				end
			end
		end
	end
end)
