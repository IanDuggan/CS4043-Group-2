local composer = require "composer"
local physics = require("physics")
physics.start()
local enemySpawn = {}





local function spawn(params) 
local enemy = display.newImageRect(params.image, 360, 360)
enemy.objTable = params.objTable
enemy.index = #enemy.objTable + 1
enemy.myName ="enemy" .. enemy.index
enemy.myName = "enemy" --remove this when we sort out index's and shit
enemy.x = 1500
enemy.y = 870
if params.hasBody then
enemy.density = params.density or 0
enemy.friction = params.friction or 0
enemy.bounce = params.bounce or 0
enemy.isSensor = params.isSensor or false
enemy.bodyType = params.bodyType or "dynamic"

physics.addBody(enemy, enemy.bodyType, {density = enemy.density, friction = enemy.friction, bounce = enemy.bounce, isSensor = enemy.isSensor})
end
enemy.group = params.group or nil 
enemy.group:insert(enemy)
enemy.objTable[enemy.index] = enemy
return enemy
end

local localGroup = display.newGroup()

local spawnTable = {}

local spawns = spawn(
{
	image = G.enemies.."mummy.png",
	objTable = spawnTable,
	hasBody = true,
	density = 1.0,
	friction = 0.8,
	--bounce = 0.4,
	bodytype = "dynamic",
	group = localGroup,
}
)








--[[local spawnTimer
local spawnedObject = {}

local spawnParams =
 {
    xMin= 50,
	xMax = 750,
	yMin= 20,
	yMax = 1100,
	spawnTime = 200,
	spawnOnTimer = 1,
	spawnInitial = 0,
 }
 
 --spawning an enemy
 local function spawnEnemy(bounds)
 
 --create an enemy & add physics to it
 local newEnemy = display.newImage(G.enemies.."mummy.png" )
 physics.addBody(newEnemy,"dynamic",{density=1.0,friction=0.8, 1,1 })
 newEnemy:setLinearVelocity(100,0)
newEnemy.myName = "enemy"
 -- position the enemy randomly with the bounds
 newEnemy.x =1500 --math.random(bounds.xMin, bounds.xMax )
 newEnemy.y = 700--math.random(bounds.yMin , bounds.yMax)
 
 -- add enemy to spawnedObject table for tracking purposes
 spawnedObject[#spawnedObject+1] = enemy
 end
 
 --Spawn Controller
 local function spawnController( action, params)
 
 --cancel timer on "start" or "stop" , if it exist
 if(spawnTimer and (action == "start" or action=="stop" ) )then
    timer.cancel(spawnTimer)
end

--Start spawning
if(action == "start") then

    -- gather/set spawning bounds
	local spawnBounds= {}
	spawnBounds.xMin = params.xMin or 0
	spawnBounds.xMax = params.xMax or display.contentWidth
	spawnBounds.yMin = params.yMin or 0
	spawnBounds.yMax = params.xMax or display.ContentHeight
	--gather/set other spawning params
	local spawnTime = params.spawnTime or 1000
	local spawnOnTimer = params.spawnOnTimer or 50
	local spawnInitial = params.spawnInitial or 0
	--if spawnInitila > 0, spawn n enemies instantly
	if(spawnInitial > 0) then
	    for n =1, spawnInitial do
		    spawnEnemy( spawnBounds )
		end
	end
	
	--start repeating timer to spawn enemies
	if(spawnOnTimer > 0) then
	    spawnTimer = timer.performWithDelay( spawnTime,
		    function () spawnEnemy( spawnBounds); end,
			spawnOnTimer)
	end
	--Pause spawning
	elseif(action == "pause") then
	    timer.pause( spawnTimer )
	
	--Resume spawning
	elseif ( action=="resume" )then
	     timer.resume( spawnTimer )
	end
end
spawnController ("start", spawnParams)
spawnController( "pause" )
spawnController( "resume" )
--spawnController( "stop" )--]]
