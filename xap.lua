require("globals")
local composer = (require "composer")
local maths = require("maths")
local urn = require("urn")

local xap = {}

local distance = 0

local function spawn(params)


	xap.direction = params.direction or 1
	xap.state = params.state or 0

	if xap.state == 0 then
		xap.image = "XapDaggerless.png"
	else
		xap.image = "Xap.png"
	end

	xapGroup = display.newGroup()
	xap.display = display.newImageRect( G.xap..xap.image, 240, 419 )

	if xap.direction == 0 then
		xap.display.xScale = -1
	end

	xap.score = xap.score or 0
	xap.display.myName = params.myName or "xap"
	xap.motionX = params.motionx or 0 
	xap.speed = G.xapSpeed
	xap.isAlive = true
	xap.canJump = params.canJump or true 
	xap.health =  params.health or 100
	xap.canShoot = params.canShoot or true
	xap.canSwing = params.canSwing or true
	xap.ammo = params.ammo or 3
	xap.myName = params.myName or "xap"
	
	xapAmmo = display.newText({text = "Ammo : "..xap.ammo, x = 270, y = 150})
	xap.healthbar = display.newText({text = "Health : "..xap.health, x = 300, y = 100})
	xapScore = display.newText({text = "Score : "..xap.score, x = 270, y = 200})


	xap.display.x = params.x or 0
	xap.display.y = params.y or 0
	
	physics.addBody( xap.display, "dynamic", {friction = .5, bounce = 0})
	xap.display.isFixedRotation = true
	
	
	xapGroup:insert(xap.display)
	xapGroup:insert(xapAmmo)
	xapGroup:insert(xap.healthbar)
	xapGroup:insert(xapScore)
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
---*** for the puzzle ***
		buttonPressed = false	
	if event.keyName == "e" and event.phase == "down" and buttonPressed ~= true then
		composer.showOverlay( "puzzle", options )
		buttonPressed = true
	end
--*******

	if event.keyName == "q" and event.phase == "down" then
		
		if urnGroup ~= nil then

			if(maths.calculateDistance(
			{	x1 = urn.closed.x, 
				y1 = urn.closed.y, 
				x2 = xap.display.x, 
				y2 = xap.display.y
			})	< 250) 
			then	
				xap.score = xap.score + urn.score
				local tempX = urn.closed.x
				local tempY = urn.closed.y

				display.remove(urn.closed)
				urn.opened.alpha = 100
				display.remove(xapScore)
				xapScore = display.newText({text = "Score : "..xap.score, x = 270, y = 200})
				xapGroup:insert(xapScore)

			end
		end
	end
	if event.keyName == "a" and event.phase == "down" then
		distance = -G.xapSpeed
		G.currentXapXSpeed = G.xapSpeed
		if xap.direction == 1 then
				xap.display.xScale = -1
		end
		
		xap.direction = 0
		

	elseif event.keyName == "a" and event.phase == "up" then
		distance = 0
		G.currentXapXSpeed = 0
	end

	if event.keyName == "d" and event.phase == "down" then
			distance = G.xapSpeed
			G.currentXapXSpeed = -G.xapSpeed
			if xap.direction == 0 then
				xap.display.xScale = 1
			end
			xap.direction = 1
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
		
		
		sAttack = display.newImageRect(G.misc.."swordy.png",110, 170)
		physics.addBody( sAttack, "static", { isSensor=false } )
		sAttack.myName = "saber"

		if xap.direction == 0 then
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
		
		if xap.direction == 0 then
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
xap.onKeyEvent = onKeyEvent
xap.saberAttack = saberAttack
xap.daggerAttack = daggerAttack


return xap