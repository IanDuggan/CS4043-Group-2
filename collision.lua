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
		print(xap.health)
		
		

		if xap.health > 0 then
			display.remove(xap.healthbar)
			xap.healthbar = display.newText({text = "Health : "..xap.health, x = 300, y = 100})
		end
		
		if((obj1.myName == "xap" and obj2.myName == "floor") or
			(obj1.myName == "floor" and obj2.myName == "xap"))
		then
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
		
		elseif ( ( obj1.myName == "saber" and obj2.myName == "enemy" ) or
             ( obj1.myName == "enemy" and obj2.myName == "saber" ) )
        then
            -- Code to remove the enemy after his health is down
            display.remove( obj1 )
            display.remove( obj2 )
		elseif ( ( obj1.myName == "xap" and (obj2.myName == "enemy" or obj2.myName == "arrow") ) or
			( (obj1.myName == "enemy" or obj1.myName == "arrow") and obj2.myName == "xap" ) )
        then

			if obj1.myName == "arrow" or obj2.myName == "arrow" then
				xap.health = xap.health - 50
			else
				xap.health = xap.health - 70
			end
			
			   if(xap.health <= 0) then
					display.remove(xap.healthbar)
					composer.gotoScene(G.levels.."dead")

				end
            end
        end
    end



Runtime:addEventListener( "collision", onCollision )
return collision
