require("globals")
local composer = (require "composer")
local xap = {}

local distance = 0
local direction = 1

local function spawn(params)

	xapGroup = display.newGroup()
	xap.display = display.newImageRect( G.xap.."Xap.png", 240, 419 )
	xap.display.myName = "xap"
	xap.motionX = params.motionx or 0 
	xap.speed = G.xapSpeed
	xap.isAlive = true
	xap.canJump = params.canJump or true 
	xap.health =  params.health or 100
	xap.canShoot = params.canShoot or true
	xap.canSwing = params.canSwing or true
	xap.ammo = params.ammo or 3
	
	
	xapAmmo = display.newText({text = "Ammo : "..xap.ammo, x = 270, y = 150})
	xap.healthbar = display.newText({text = "Health : "..xap.health, x = 300, y = 100})
	
	xap.display.x = params.x or 0
	xap.display.y = params.y or 0
	
	physics.addBody( xap.display, "dynamic", {friction = .5, bounce = 0})
	xap.display.isFixedRotation = true
	
	
	xapGroup:insert(xap.display)
	xapGroup:insert(xapAmmo)
	xapGroup:insert(xap.healthbar)
end

--Movement shtuff
function onKeyEvent (event)

	--If user presses back on android/windowsPhone it won't exit the app
	if ( event.keyName == "back" ) then
		if ( G.android ) or ( G.winPhone ) then
			return true
		end
    end
	
	if event.keyName == "escape" then
		composer.gotoScene(G.levels.."menu")
	end
	
	if event.keyName == "a" and event.phase == "down" then
		distance = -G.xapSpeed
		G.currentXapXSpeed = G.xapSpeed
		if direction == 1 then
				xap.display.xScale = -1
		end
		
		direction = 0
		

	elseif event.keyName == "a" and event.phase == "up" then
		distance = 0
		G.currentXapXSpeed = 0
	end

	if event.keyName == "d" and event.phase == "down" then
			distance = G.xapSpeed
			G.currentXapXSpeed = -G.xapSpeed
			if direction == 0 then
				xap.display.xScale = 1
			end
			direction = 1
	elseif event.keyName == "d" and event.phase == "up" then
			distance = 0
			G.currentXapXSpeed = 0
	end

	if event.keyName == "space" or event.keyName == "w" then
		if event.phase == "down" and xap.canJump == true then
			if xap.display.y ~= nil then
			xap.display:setLinearVelocity(0, -400)
			xap.canJump = false
			end
		end
	end
	
	Runtime:removeEventListener("enterFrame", move)
end


--Movement
local function move(event)
	if xap.display.x ~= nil  then
	xap.display.x = xap.display.x 
	end
end



--COMBAT



local function saberAttack(event)
	if event.isSecondaryButtonDown and xap.canSwing then
		xap.canShoot = false
		xap.canSwing = false
		
		local spawnX = 180
		
		
		sAttack = display.newImageRect(G.misc.."sword.png",92, 100)
		physics.addBody( sAttack, "static", { isSensor=false } )
		sAttack.myName = "saber"

		if direction == 0 then
			spawnX = -spawnX
			sAttack.xScale = -1
		end
		
		sAttack.x = xap.display.x + spawnX
		sAttack.y = xap.display.y
	else
		display.remove(sAttack)
		xap.canSwing = true
		xap.canShoot = true
	end
end

local function daggerAttack()
	
	if xap.ammo > 0 then
		display.remove(xapAmmo)
	end
	
	if xap.canShoot == true and xap.ammo > 0 then
	
		local dagger = display.newImageRect(G.misc.."dagger.png", 180, 90)
		
		xap.ammo = xap.ammo - 1
		xapAmmo = display.newText({text = "Ammo : "..xap.ammo, x = 270, y = 150})
		
		xap.canSwing = false
		
		spawnX = 210
		finishX = 400
		
		if direction == 0 then
			dagger:rotate(180)
			spawnX = -spawnX
			finishX = -finishX
		end
		
		physics.addBody( dagger, "static", { isSensor=false } )
		dagger.isBullet = true
		dagger.myName = "dagger"
		
		dagger.x = xap.display.x  + spawnX
		dagger.y = xap.display.y

		local daggerAttack = transition.to( dagger, { x= dagger.x + finishX, time=700, onComplete =function() display.remove(dagger ) xap.canSwing = true end	}	)
	end
end

xap.spawn = spawn
xap.move = move


Runtime:addEventListener("enterFrame", move)
Runtime:addEventListener("key", onKeyEvent)
Runtime:addEventListener("mouse", saberAttack )
Runtime:addEventListener( "tap", daggerAttack )

return xap