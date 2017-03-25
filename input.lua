local input = {}

local xap = require("xap")
local composer = require("composer")


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
			transition.to(xap.display, {time = 3000, x = xap.display.x - (display.actualContentWidth / 2), tag = left})
		elseif event.phase == "up" then
			transition.cancel(left)
		end
	end
	if event.keyName == "d" then
		if event.phase == "down" then
			transition.to(xap.display, {time = 3000, x = xap.display.x + 1000, tag = right})
		elseif event.phase == "up" then
			transition.cancel(right)
		end
	end
	if event.keyName == "space" or event.keyName == "w" then
		if event.phase == "down" then
			transition.to(xap.display, {time = 1500, y = xap.display.y - (display.actualContentHeight / 2), tag = jump})
		elseif event.phase == "up" then
			transition.cancel(jump)
		end
	end

end


input.onKeyEvent = onKeyEvent

return input