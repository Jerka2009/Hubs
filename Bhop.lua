loadstring(game:HttpGet("https://raw.githubusercontent.com/Jerka2009/Hubs/main/intro.lua"))()

--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
--script by Novik#5516 feel free to edit



local mv = {}
local player
local character
local collider
local camera
local input
local collider
local playerGrounded
local playerVelocity
local jumping
local moveInputSum
local dt = 1/60
local partYRatio
local partZRatio
local cameraYaw
local cameraLook
local movementPosition
local movementVelocity
local gravityForce

local airAccelerate
local airMaxSpeed --only limits projection of velocity onto acceleration
local groundAccelerate
local groundMaxVelocity --only limits projection of velocity onto acceleration
local friction
local playerTorsoToGround
local movementStickDistance
local jumpVelocity
local movementPositionForce
local movementVelocityForce
local maxMovementPitch
local rayYLength
local movementPositionD
local movementPositionP
local movementVelocityP
local gravity



function mv.init(Player, Camera, Input)
	player = Player
	character = player.Character
	collider = character.UpperTorso
	camera = Camera
	input = Input
	playerVelocity = 0
	playerGrounded = false
	moveInputSum = {
	["forward"] = 0,
	["side"] 	= 0 --left is positive
	}
	
	airAccelerate 			= 5000
	airMaxSpeed 			= 20
	groundAccelerate 		= 25
	groundMaxVelocity 		= 400
	friction			 	= 10
	playerTorsoToGround 	= 3
	movementStickDistance 	= 0.5
	jumpVelocity 			= 80
	movementPositionForce	= 400000
	movementVelocityForce	= 3000000
	maxMovementPitch		= 0.6
	rayYLength				= playerTorsoToGround + movementStickDistance
	movementPositionD		= 125
	movementPositionP		= 14000
	movementVelocityP		= 15000
	gravity					= 0.4
	
end

function mv.initBodyMovers()
	movementPosition = Instance.new("BodyPosition", collider)
	movementPosition.Name = "movementPosition"
	movementPosition.D = movementPositionD
	movementPosition.P = movementPositionP
	movementPosition.maxForce = Vector3.new()
	movementPosition.position = Vector3.new()
	
	movementVelocity = Instance.new("BodyVelocity", collider)
	movementVelocity.Name = "movementVelocity"
	movementVelocity.P = movementVelocityP
	movementVelocity.maxForce = Vector3.new()
	movementVelocity.velocity = Vector3.new()
	
	gravityForce = Instance.new("BodyForce", collider)
	gravityForce.Name = "gravityForce"
	gravityForce.force = Vector3.new(0, (1-gravity)*196.2, 0) * getCharacterMass()
end

function mv.update(deltaTime)
	dt = deltaTime
	updateMoveInputSum()
	cameraYaw = getYaw()
	cameraLook = cameraYaw.lookVector	
	if cameraLook == nil then
		return
	end
	local hitPart, hitPosition, hitNormal, yRatio, zRatio = findCollisionRay()
	partYRatio = yRatio
	partZRatio = zRatio
	
	playerGrounded = hitPart ~= nil and true or false
	playerVelocity = collider.Velocity - Vector3.new(0, collider.Velocity.y, 0)
	if playerGrounded and (input["Space"] or jumping) then
		jumping = true
	else
		jumping = false
	end
	
	setCharacterRotation()
	if jumping then
		jump()
		print(math.random())
	elseif playerGrounded then
		run(hitPosition)
	else
		air()		
	end
	
end

function updateMoveInputSum()
	moveInputSum["forward"] = input["W"] == true and 1 or 0
	moveInputSum["forward"] = input["S"] == true and moveInputSum["forward"] - 1 or moveInputSum["forward"]
	moveInputSum["side"] = input["A"] == true and 1 or 0
	moveInputSum["side"] = input["D"] == true and moveInputSum["side"] - 1 or moveInputSum["side"]
end

function findCollisionRay()
	local torsoCFrame = character.UpperTorso.CFrame
	local ignoreList = {character, camera}
	local rays = {
		Ray.new(character.UpperTorso.Position, Vector3.new(0, -rayYLength, 0)),
		Ray.new((torsoCFrame * CFrame.new(-0.8,0,0)).p, Vector3.new(0, -rayYLength, 0)),
		Ray.new((torsoCFrame * CFrame.new(0.8,0,0)).p, Vector3.new(0, -rayYLength, 0)),
		Ray.new((torsoCFrame * CFrame.new(0,0,0.8)).p, Vector3.new(0, -rayYLength, 0)),
		Ray.new((torsoCFrame * CFrame.new(0,0,-0.8)).p, Vector3.new(0, -rayYLength, 0))
	}
	local rayReturns  = {}
	
	local i
	for i = 1, #rays do
		local part, position, normal = game.Workspace:FindPartOnRayWithIgnoreList(rays[i],ignoreList)
		if part == nil then
			position = Vector3.new(0,-3000000,0)
		end
		if i == 1 then
			table.insert(rayReturns, {part, position, normal})
		else
			local yPos = position.y
			if yPos <= rayReturns[#rayReturns][2].y then
				table.insert(rayReturns, {part, position, normal})
			else 
				local j
				for j = 1, #rayReturns do
					if yPos >= rayReturns[j][2].y then
						table.insert(rayReturns, j, {part, position, normal})
					end
				end
			end
		end
	end
	
	i = 1
	local yRatio, zRatio = getPartYRatio(rayReturns[i][3])
	while magnitude2D(yRatio, zRatio) > maxMovementPitch and i<#rayReturns do
		i = i + 1
		if rayReturns[i][1] then
			yRatio, zRatio = getPartYRatio(rayReturns[i][3])
		end
	end
	
	return rayReturns[i][1], rayReturns[i][2], rayReturns[i][3], yRatio, zRatio
end

function setCharacterRotation()
	local rotationLook = collider.Position + camera.CoordinateFrame.lookVector
	collider.CFrame = CFrame.new(collider.Position, Vector3.new(rotationLook.x, collider.Position.y, rotationLook.z))
	collider.RotVelocity = Vector3.new()
end

function jump()
	collider.Velocity = Vector3.new(collider.Velocity.x, jumpVelocity, collider.Velocity.z)
	air()
end

function air()
	movementPosition.maxForce = Vector3.new()
	movementVelocity.velocity = getMovementVelocity(collider.Velocity, airAccelerate, airMaxSpeed)
	movementVelocity.maxForce = getMovementVelocityAirForce()
end

function run(hitPosition)
	local playerSpeed = collider.Velocity.magnitude
	local mVelocity = collider.Velocity
	
	if playerSpeed ~= 0 then
		local drop = playerSpeed * friction * dt;
		mVelocity = mVelocity * math.max(playerSpeed - drop, 0) / playerSpeed;
	end
	
	movementPosition.position = hitPosition + Vector3.new(0,playerTorsoToGround,0)
	movementPosition.maxForce = Vector3.new(0,movementPositionForce,0)
	movementVelocity.velocity = getMovementVelocity(mVelocity, groundAccelerate, groundMaxVelocity)
	local VelocityForce = getMovementVelocityForce()
	movementVelocity.maxForce = VelocityForce
	movementVelocity.P = movementVelocityP
end

function getMovementVelocity(prevVelocity, accelerate, maxVelocity)
	local accelForward = cameraLook * moveInputSum["forward"]
	local accelSide = (cameraYaw * CFrame.Angles(0,math.rad(90),0)).lookVector * moveInputSum["side"];
	local accelDir = (accelForward+accelSide).unit;
	if moveInputSum["forward"] == 0 and moveInputSum["side"] == 0 then --avoids divide 0 errors
		accelDir = Vector3.new(0,0,0);
	end
	
	local projVel =  prevVelocity:Dot(accelDir);
	local accelVel = accelerate * dt;
	
	if (projVel + accelVel > maxVelocity) then
		accelVel = math.max(maxVelocity - projVel, 0);
	end
	
	return prevVelocity + accelDir * accelVel;
end

function getMovementVelocityForce()

	return Vector3.new(movementVelocityForce,0,movementVelocityForce)
end

function getMovementVelocityAirForce()
	local accelForward = cameraLook * moveInputSum["forward"];
	local accelSide = (cameraYaw * CFrame.Angles(0,math.rad(90),0)).lookVector * moveInputSum["side"]
	local accelDir = (accelForward+accelSide).unit
	if moveInputSum["forward"] == 0 and moveInputSum["side"] == 0 then
		accelDir = Vector3.new(0,0,0);
	end
	
	local xp = math.abs(accelDir.x)
	local zp = math.abs(accelDir.z)
	
	return Vector3.new(movementVelocityForce*xp,0,movementVelocityForce*zp)
end

function getPartYRatio(normal)
	local partYawVector = Vector3.new(-normal.x, 0, -normal.z)
	if partYawVector.magnitude == 0 then
		return 0,0
	else
		local partPitch = math.atan2(partYawVector.magnitude,normal.y)/(math.pi/2)
		local vector = Vector3.new(cameraLook.x, 0, cameraLook.z)*partPitch
		return vector:Dot(partYawVector), -partYawVector:Cross(vector).y
	end	
end

function getYaw() --returns CFrame
	return camera.CoordinateFrame*CFrame.Angles(-getPitch(),0,0)
end

function getPitch() --returns number
	return math.pi/2 - math.acos(camera.CoordinateFrame.lookVector:Dot(Vector3.new(0,1,0)))
end

function getCharacterMass()
	return character.UpperTorso:GetMass() + character.Head:GetMass()
end

function magnitude2D(x,z)
	return math.sqrt(x*x+z*z)
end

--note: this only works with filtering enabled

local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")

local prevUpdateTime = nil
local updateDT = 1/60
local inputKeys = {
	["W"] = false,
	["S"] = false,
	["A"] = false,
	["D"] = false,
	["Space"] = false,
	["LMB"] = false,
	["RMB"] = false
}

function main()
	-- character spawning bs
	if player:FindFirstChild("customCharacterSpawned") == nil then
		local newval = Instance.new("BoolValue", player);
		newval.Name = "customCharacterSpawned";
		newval.Value = false;
	end
	
	if not player.customCharacterSpawned.Value then
		player.customCharacterSpawned.Value = true;
		return;
	end
	
	player.Character:WaitForChild("Humanoid");
	--remove hats for physics sake
	huckFats();
	spawn(function()
		while player.Character do
			wait(1)
			huckFats();
		end
	end)
	
	--init movement
	mv.init(player, camera, inputKeys);
	mv.initBodyMovers();
	
	--display poop

	
	--connect input
	UserInputService.InputBegan:connect(onInput);
	UserInputService.InputEnded:connect(onInput);
	
	--connect updateloop
	game:GetService("RunService"):BindToRenderStep("updateLoop", 1, updateLoop);
	
	--rip
	player.Character.Humanoid.Died:connect(onDeath)
end

function updateLoop()
	setDeltaTime();
	mv.update(updateDT);
end

function huckFats()
	for _,v in pairs (player.Character:GetChildren()) do
		if v:IsA("Hat") then
			v:Destroy()
		end
	end
end

function setDeltaTime() --seconds
	local UpdateTime = tick() 
	if prevUpdateTime ~= nil then
		updateDT = (UpdateTime - prevUpdateTime)
	else
		updateDT = 1/60
	end
	prevUpdateTime = UpdateTime
end

function onInput(input, gameProcessedEvent)
	local inputState
	--print(input.KeyCode)
	if input.UserInputState == Enum.UserInputState.Begin then
		inputState = true
	elseif input.UserInputState == Enum.UserInputState.End then
		inputState = false
	else
		return
	end 
	
	if input.UserInputType == Enum.UserInputType.Keyboard then
		local key = input.KeyCode.Name
		if inputKeys[key] ~= nil then
			inputKeys[key] = inputState
		end
	elseif input.UserInputType == Enum.UserInputType.MouseButton1 then --LMB down
		inputKeys.LMB = inputState
	elseif input.UserInputType == Enum.UserInputType.MouseButton2 then --RMB down
		inputKeys.RMB = inputState
	end
end

function onDeath()
	player.customCharacterSpawned = false
end

main()
