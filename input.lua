local composer = require "composer"
local g = require "globals"


local input = {}

--This code is retarded and clunky af, will be fixed for beta
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
	
	if event.keyName == "a" then
		if event.phase == "down" then
			transition.to(xap, {time = 3000, x = xap.x - (display.actualContentWidth / 2)})
		elseif event.phase == "up" then
			transition.cancel()
		end
	end
	if event.keyName == "d" then
		if event.phase == "down" then
			transition.to(xap, {time = 3000, x = xap.x + 1000})
		elseif event.phase == "up" then
			transition.cancel()
		end
	end
	if event.keyName == "space" then
		if event.phase == "down" then
			transition.to(xap, {time = 1500, y = xap.y - (display.actualContentHeight / 2)})
		elseif event.phase == "up" then
			transition.cancel(xap, {time = 5000})
		end
	end
	if event.keyName == "s" then
		if event.phase == "down" then
			transition.to(xap, {time = 0, xap:scale(.5,.5), y = xap.y + 50})

		elseif event.phase == "up" then
			transition.cancel()
			xap:scale(2,2)
		end
	end
end


Runtime:addEventListener("key", onKeyEvent)

return input