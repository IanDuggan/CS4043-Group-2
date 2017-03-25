local input = {}

local xap = require("xap")
local composer = require("composer")

local distance = 0

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


	elseif event.keyName == "a" and event.phase == "up" then
		distance = 0
	end

	if event.keyName == "d" and event.phase == "down" then
			distance = G.xapSpeed
	elseif event.keyName == "d" and event.phase == "up" then
			distance = 0
	end

	if event.keyName == "space" or event.keyName == "w" then
		if event.phase == "down" then
			xap.display:setLinearVelocity(0, -200)
		end
	end

	Runtime:removeEventListener("enterFrame", move)

end

local function move(event)
	xap.display.x = xap.display.x + distance
end

input.onKeyEvent = onKeyEvent

Runtime:addEventListener("enterFrame", move)
Runtime:addEventListener("key", input.onKeyEvent)

return input