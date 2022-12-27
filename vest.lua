local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character
local Hitbox = Character:WaitforChild("hitbox")
local entities = game:GetService("Workspace").placeFolders.entityManifestCollection:GetChildren()

godcheck = true
local godmode 
godmode = hookmetamethod(game, "__namecall", function(self, ...)  
  local args = {...}
  if godcheck == true and getnamecallmethod() == "FireServer" and args[4] == "monster" then 
    return
  end

  return godmode(self, ...)
end)

local function GetAttackable()
  attackable = {}
  for i, entity in pairs(entities) do
    if entity.ClassName ~= "Model" and entity:FindFirstChild("health") and entity.health.Value  > 0 and not Value:FindFirstChild:("pet") then
      local Distance = (entity.Position - Hitbox.Position).Magnitude
      if Distance < 15 then
        table.insert(attackable, entity)
      end
    end
  end
  return attackable
 end

local function attack(targ)
for Index, IValue in next, getconnections(Player.Idled) do 
  if Value then 
    IValue:Disable() 
  else
    IValue:Enable()
  end
end

tpOffset = Vector3.new(0, 4, 0)
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
    if entity.ClassName ~= "Model" and entity:FindFirstChild("health") and entity.health.Value  > 0 and not Value:FindFirstChild:("pet") then
      local Distance = (entity.Position - Hitbox.Position).Magnitude
      if Distance < 15 then
        table.insert(attackable, entity)
      end
    end
  end
  return attackable
 end

local function attack(targ)
  
      
    
local function killaura(targets)
      
end
