require("globals")
local composer = (require "composer")
local xap = {}

local distance = 0

local function spawn(params)

	xap.display = display.newImageRect( G.xap.."Xap.png", 240, 419 )
	xap.display.myName = "xap"
	xap.motionX = params.motionx or 0 
	xap.speed = G.xapSpeed
	xap.isAlive = true
	xap.canJump = params.canJump or true 
	xap.health =  params.health or 100
	
	xap.display.x = params.x or 0
	xap.display.y = params.y or 0
	
	
	--xap.healthbar = display.newText({text = "Health : "..xap.health, x = 300, y = 100})
	
	
	physics.addBody( xap.display, "dynamic", {friction = .5, bounce = 0})
	xap.display.isFixedRotation = true
	

	
end

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

	elseif event.keyName == "a" and event.phase == "up" then
		distance = 0
		G.currentXapXSpeed = 0
	end

	if event.keyName == "d" and event.phase == "down" then
			distance = G.xapSpeed
			G.currentXapXSpeed = -G.xapSpeed
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




xap.spawn = spawn
xap.move = move



Runtime:addEventListener("enterFrame", move)
Runtime:addEventListener("key", onKeyEvent)


return xap

