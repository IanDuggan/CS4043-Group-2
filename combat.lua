local composer = require "composer"
local physics = require("physics")
local enemy = require("enemy")
local xap = require("xap")
local trap = ("traps")

direction = 1


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

local function saberAttack(event)
	if event.isSecondaryButtonDown then
		local sAttack = display.newImageRect(G.misc.."sword.png",150, 54)
		physics.addBody( sAttack, "static", { isSensor=true } )
		sAttack.myName = "saber"

		sAttack.x = xap.display.x + 180 
		sAttack.y = xap.display.y
		sAttack:toBack()
		
			
	end
end
Runtime:addEventListener("mouse", saberAttack )
return combat
