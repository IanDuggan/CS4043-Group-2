local composer = require "composer"
local physics = require("physics")
local enemySpawn = require("enemySpawn")
local xap = require("xap")
local trap = ("traps")

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

