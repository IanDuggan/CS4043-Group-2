local composer = require "composer"
local physics = require("physics")
local enemySpawn = require("enemySpawn")
physics.start()

local combat = {}
local lives =3
local died = false
local sheetOptions =
{
    frames =
    {
        {   -- 2) dagger
            x = 98,
            y = 265,
            width = 40,
            height = 14
        },
    },
}

local objectSheet = graphics.newImageSheet( "dagger.jpg", sheetOptions )

local mainGroup = display.newGroup()

local function daggerAttack()

	local newAttack = display.newImageRect(mainGroup, objectSheet, 1, 40, 14)
	physics.addBody( newAttack, "dynamic", { isSensor=true } )
	newAttack.isBullet = true
	newAttack.myName = "dagger"

	newAttack.x = xap.x
	newAttack.y = xap.y
	newAttack:toBack()

	transition.to( newAttack, { x=150000,y=50, time=500000,
		onComplete = function() display.remove( newAttack ) end
	} )
end
Runtime:addEventListener( "tap", daggerAttack )


--[[
local function restoreXap()

    xap.isBodyActive = false
    xap.x = display.contentCenterX-5
    xap.y = display.contentHeight-15

    -- Fade in the xap
    transition.to( xap, { alpha=1, time=4000,
        onComplete = function()
            xap.isBodyActive = true
            died = false
        end
    } )
end
--]]


local function onCollision( event )

    if ( event.phase == "began" ) then

        local obj1 = event.object1
		local obj2 = event.object2

		if((obj1.myName == "xap" and obj2.myName == "trap") or
			(obj1.myName == "trap" and obj2.myName == "xap"))
		then
			display.remove(trap)
		end

		if ( ( obj1.myName == "dagger" and obj2.myName == "enemy" ) or
             ( obj1.myName == "enemy" and obj2.myName == "dagger" ) )
        then
            -- Code to remove the enemy after his health is down
            display.remove( obj1 )
            display.remove( obj2 )

		elseif ( ( obj1.myName == "xap" and obj2.myName == "enemy" ) or
                 ( obj1.myName == "enemy" and obj2.myName == "xap" ) )
        then
		    --display.remove( obj1 )
            if ( lives > 0 ) then
			   lives = lives - 1
			   if(lives == 0) then
					display.remove( xap )
					composer.gotoScene(G.levelsPath.."menu")
				else

				end
            end
        end
    end
end
Runtime:addEventListener( "collision", onCollision )
return combat
