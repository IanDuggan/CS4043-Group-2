local composer = require "composer"
local physics = require("physics")
local enemySpawn = require("enemySpawn")
local xap = require("xap")
local trap = ("traps")

local combat = {}
local died = false

local sheetOptions =
{
    frames =
    {
        {   -- 2) dagger
            x = 98,
            y = 265,
            width = 160,
            height = 170
        },
    },
}
physics.start()
local objectSheet = graphics.newImageSheet( G.misc.."dagger.png", sheetOptions )

local mainGroup = display.newGroup()

local function daggerAttack()

	local newAttack = display.newImageRect(mainGroup, objectSheet, 1, 150, 54)
	physics.addBody( newAttack, "dynamic", { isSensor=true } )
	newAttack.isBullet = true
	newAttack.myName = "dagger"

	newAttack.x = xap.display.x
	newAttack.y = xap.display.y
	newAttack:toBack()

	local dagAttackTrans = transition.to( newAttack, { x=150000,y=50, time=500000,
		onComplete = function() display.remove( newAttack ) end
	} )
end
Runtime:addEventListener( "tap", daggerAttack )

local function onCollision( event )

    if ( event.phase == "began" ) then
		print(xap.myName)
        local obj1 = event.object1
		local obj2 = event.object2

		
		
		if((obj1.myName == "xap" and obj2.myName == "floor") or
			(obj1.myName == "floor" and obj2.myName == "xap"))
		then
			
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
		    --display.remove( obj1 )
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
return combat
