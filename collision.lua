local composer = require "composer"
local physics = require("physics")
local enemy = require("enemy")
local xap = require("xap")
local trap = ("traps")
local combat = require("combat")

local collision = {}

local function onCollision( event )

    if ( event.phase == "began" ) then
        local obj1 = event.object1
		local obj2 = event.object2

		
		if((obj1.myName == "xap" and obj2.myName == "floor") or
			(obj1.myName == "floor" and obj2.myName == "xap"))
		then
		print(obj1.myName)
		print(obj2.myName)
			xap.canJump = true
		end
			
		if((obj1.myName == "xap" and obj2.myName == "trap") or
			(obj1.myName == "trap" and obj2.myName == "xap"))
		then

			display.remove(trap.display)

		end

		if ( ( obj1.myName == "dagger" and obj2.myName == "enemy" ) or
             ( obj1.myName == "enemy" and obj2.myName == "dagger" ) )
        then
            -- Code to remove the enemy after his health is down
            display.remove( obj1 )
            display.remove( obj2 )

		elseif ( ( obj1.myName == "xap" and (obj2.myName == "enemy" or obj2.myName == "arrow") ) or
			( (obj1.myName == "enemy" or obj1.myName == "arrow") and obj2.myName == "xap" ) )
        then
			print("hit")
			if obj1.myName == "arrow" or obj2.myName == "arrow" then
				lives = 1
			end
	
            if ( xap.health > 0 ) then
			   xap.health = xap.health - 40
			   if(xap.health <= 0) then
					display.remove( xap.display )
					display.remove(newEnemy)
					composer.gotoScene(G.levels.."menu")
				else

				end
            end
        end
    end
end

Runtime:addEventListener( "collision", onCollision )
return collision
