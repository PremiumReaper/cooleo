local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer
local Character = Player.Character
local Hitbox = Character:WaitForChild("hitbox")
local Signal = ReplicatedStorage:WaitForChild("signal")
getgenv().killA = false
getgenv().killSpeed = 1 
getgenv().god = false
getgenv().autoFarm = false

local godmode 
godmode = hookmetamethod(game, "__namecall", function(self, ...)  
  local args = {...}
  if getgenv().god == true and getnamecallmethod() == "FireServer" and args[4] == "monster" then 
    return
  end

  return godmode(self, ...)
end)

local function Tp(targ)
  Hitbox.CanCollide = false
  Hitbox.CFrame = targ.CFrame
end

local function GetAttackable()
  local entities = game:GetService("Workspace").placeFolders.entityManifestCollection:GetChildren()
  attackable = {}
  for i, entity in pairs(entities) do
    if entity.ClassName ~= "Model" and entity:FindFirstChild("health") and entity.health.Value  > 0 and not entity:FindFirstChild("pet") then
      local Distance = (entity.Position - Hitbox.Position).Magnitude
      print(Distance)
      if Distance < 15 then
        table.insert(attackable, entity)
      end
    end
  end
  return attackable
end

local function aura()
while getgenv().killA == true do
	if killSpeed == 0 then
		task.wait(0.0001)
	else
		task.wait(killSpeed)
	end
	local attackable = GetAttackable()
	if #attackable > 0 then
		Signal:FireServer("fireEvent", "playerWillUseBasicAttack", Player)
		for Index = 1, 2 do
		  Signal:FireServer("replicatePlayerAnimationSequence", "daggerAnimations", "strike" .. tostring(Index), {attackSpeed = 0})
		  for i, entity in pairs(attackable) do
		    local ohTable2 = {
			    [1] = {
				  [1] = entity,
				  [2] = Hitbox.Position,
				  [3] = "equipment"
			    }
		      }
		  Signal:FireServer("playerRequest_damageEntity_batch", ohTable2)
		  --task.wait(getgenv().killSpeed) 
		  end
		end
	end     
end
end

local function autofarm()
	distinctMobs = {}
	while autoFarm == true do
		local entities = game:GetService("Workspace").placeFolders.entityManifestCollection:GetChildren()
		for i,entity in pairs(entities) do
			if not table.find(distinctMobs, entity.Name) then
				table.insert(distinctMobs, entity.Name)
			end
			if entity.ClassName ~= "Model" and autoFarm and entity:FindFirstChild("health") and entity.health.Value > 0 and not entity:FindFirstChild("pet") then
				while entity.health.Value > 0 or not entity:FindFirstChild("health") do
					if not autoFarm then
						break
					end
					Tp(entity)
					task.wait(0.2)
				end
			end
		end
		Hitbox.CanCollide = true
	end
end
	
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/cat"))()
local Window = Library:CreateWindow("PremReps Vesteria Custom", Vector2.new(300, 300), Enum.KeyCode.T)
local autoTab = Window:CreateTab("AutoFarm")

local KillAura = autoTab:CreateSector("Kill Aura", "left")
KillAura:AddToggle("Kill Aura", false, function(bool)
	getgenv().killA = bool
	if bool then
		aura()
	end
end)
KillAura:AddSlider("Kill Speed", 0, 5, 20, 1, function(val)
		killSpeed = val / 10
end)
KillAura:AddToggle("Auto Farm", false, function(bool)
	autoFarm = bool
	if bool then
		autofarm()
	end
end)

local playerTab = autoTab:CreateSector("Player", "right")
playerTab:AddToggle("Godmode", false, function(bool)
	getgenv().god = bool
end)

