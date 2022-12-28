local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer
local Character = Player.Character
local Hitbox = Character:WaitForChild("hitbox")
local entities = game:GetService("Workspace").placeFolders.entityManifestCollection:GetChildren()
local Signal = ReplicatedStorage:WaitForChild("signal")
getgenv().killA = false
getgenv().killSpeed = 1 
getgenv().god = false

local godmode 
godmode = hookmetamethod(game, "__namecall", function(self, ...)  
  local args = {...}
  if getgenv().god == true and getnamecallmethod() == "FireServer" and args[4] == "monster" then 
    return
  end

  return godmode(self, ...)
end)

local function GetAttackable()
  attackable = {}
  for i, entity in pairs(entities) do
    if entity.ClassName ~= "Model" and entity:FindFirstChild("health") and entity.health.Value  > 0 and not Value:FindFirstChild("pet") then
      local Distance = (entity.Position - Hitbox.Position).Magnitude
      if Distance < 15 then
        table.insert(attackable, entity)
      end
    end
  end
  return attackable
 end

local tpOffset = Vector3.new(0, 4, 0)
local function Tp(targ)
  if not Hitbox then
    return
  end
  Hitbox.CanCollide = false
  Hitbox.CFrame = targ.CFrame + tpOffset
end

local function GetAttackable()
  attackable = {}
  for i, entity in pairs(entities) do
    if entity.ClassName ~= "Model" and entity:FindFirstChild("health") and entity.health.Value  > 0 and not entity:FindFirstChild("pet") then
      local Distance = (entity.Position - Hitbox.Position).Magnitude
      if Distance < 15 then
        table.insert(attackable, entity)
      end
    end
  end
  return attackable
end

local function aura()
while getgenv.killA == true do
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
		  task.wait(getgenv.killSpeed)
		  end
		end
	end      
end


local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/cat"))()
local Window = Library:CreateWindow("PremReps Vesteria Custom", Vector2.new(300, 300), Enum.KeyCode.T)
local autoTab = Window:CreateTab("AutoFarm")

local KillAura = AutoTab:CreateSector("Kill Aura", "left")
KillAura.AddToggle("Kill Aura", false, function(bool)
	getgenv().killA = bool
	if bool then
		aura()
	end
end)

local playerTab = Window:CreateTab("Player")
playerTab:AddToggle("Godmode", false, function(bool)
	getgenv().god = bool
end)



