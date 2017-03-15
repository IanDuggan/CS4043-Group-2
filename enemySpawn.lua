local composer = require "composer"
local physics = require("physics")

local spawn = {}

local spawnTimer
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

return spawn