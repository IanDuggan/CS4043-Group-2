local composer = require( "composer" )
local physics = require ("physics")
local xap = require("xap")
local trap = require("traps")
local enemy = require("enemy")
local g = require("globals")
local col = require("collision")
local urn = require("urn")

local scene = composer.newScene()

physics.setDrawMode(G.drawMode)

function scene:create( event )

	local sceneGroup = self.view
	physics.start()
	physics.pause()

	local background1 = display.newImageRect( G.backgrounds.."background.png",  display.actualContentWidth, display.actualContentHeight )
	background1.x = background1.x - 2880
	background1.anchorX = 0
	background1.anchorY = 0
	
	local background2 = display.newImageRect( G.backgrounds.."background.png",  display.actualContentWidth, display.actualContentHeight )
	background2.x = background2.x - 1920
	background2.anchorX = 0
	background2.anchorY = 0
	
	local background3 = display.newImageRect( G.backgrounds.."background.png",  display.actualContentWidth, display.actualContentHeight )
	background3.anchorX = 0
	background3.anchorY = 0
	
	local background4 = display.newImageRect( G.backgrounds.."background.png",  display.actualContentWidth, display.actualContentHeight )
	background4.x = background4.x + 1920
	background4.anchorX = 0
	background4.anchorY = 0
	
	local background5 = display.newImageRect( G.backgrounds.."background.png",  display.actualContentWidth, display.actualContentHeight )
	background5.x = background5.x + 2880
	background5.anchorX = 0
	background5.anchorY = 0


	function scrollBackground(self, event)
		self.x = self.x + G.currentXapXSpeed
		if self.x > 3840 then
			self:translate( -7680, 0 )
		end
		if self.x < -3840 then
			self:translate( 7680, 0 )
		end
	end

	background1.enterFrame = scrollBackground
	Runtime:addEventListener("enterFrame", background1)
	
	background2.enterFrame = scrollBackground
	Runtime:addEventListener("enterFrame", background2)
	
	background3.enterFrame = scrollBackground
	Runtime:addEventListener("enterFrame", background3)
	
	background4.enterFrame = scrollBackground
	Runtime:addEventListener("enterFrame", background4)
	
	background5.enterFrame = scrollBackground
	Runtime:addEventListener("enterFrame", background5)
	

	
	local floor = display.newRect(0, 0, G.width * 100, 1 )
	floor.x = G.width / 2; floor.y = G.height - 35
	physics.addBody(floor, "static", { friction = .5, bounce = .3} )
	floor.alpha = 0; floor.myName = "floor"
	

	local trapGroup = display.newGroup()
	local enemyGroup = display.newGroup()
	local urnGroup = display.newGroup()

		--[[
		trap.spawn(
		{
			myName = "trap",
			image = G.traps.."trap.png",
			x = G.width/2 - 270,
			y = G.height - 50,			
			bodyType = "static",
			friction = .5,
			bounce = 0,
			i = 1,
		}	)
		
		trapGroup:insert(trap.display)
		

		trap.spawn(
		{
			myName = "arrow",
			image = G.misc.."arrow.png",
			x = G.width / 2 - 230,
			y = G.height - 1250,
			bodyType = "dynamic",
			friction = .5,
			bounce = 0,
			rotation = 270,
			i = 2,
		}	)

		trapGroup:insert(trap.display)
		
		--]]
		
		xap.spawn(
		{
			x = G.width / 2,
			y = G.height -250,
		}	)
		
	

		urn.spawn(
		{
			x = G.width / 2 - 750,
			y = G.height - 250,
			score = 100,
		})

		urnGroup:insert(urn.opened)
		urnGroup:insert(urn.closed)


		enemy.spawn(
		{
			type = "mummy",
			index = 1,
			x = 1800,
			y = 870,
			density = 1.0,
			friction = 0.8,
			bounce = 0.4,
			bodytype = "dynamic",
			myName = "enemy"
		}	)
		
		enemyGroup:insert(enemy.display)
		
		enemy.spawn(
		{
			type = "mummy",
			index = 2,
			x = 2500,
			y = 870,
			density = 1.0,
			friction = 0.8,
			bounce = 0.4,
			bodytype = "dynamic",
			myName = "enemy"
		}	)
		

		enemyGroup:insert(enemy.display)



		
	function scrollObjects(self, event)
		if self.x ~= nil then
			self.x = self.x + G.currentXapXSpeed
		end
	end
	
	for i=1 , enemyGroup.numChildren, 1 do
		enemyGroup[i].enterFrame = scrollObjects
		Runtime:addEventListener("enterFrame", enemyGroup[i])
	end

	for i=1 , urnGroup.numChildren, 1 do
		urnGroup[i].enterFrame = scrollObjects
		Runtime:addEventListener("enterFrame", urnGroup[i])
	end
	
	for i=1 , trapGroup.numChildren, 1 do
		trapGroup[i].enterFrame = scrollObjects
		Runtime:addEventListener("enterFrame", trapGroup[i])
	end

	
	-- all display objects must be inserted into group
	sceneGroup:insert( background1 )
	sceneGroup:insert( background2 )
	sceneGroup:insert( background3 )
	sceneGroup:insert( background4 )
	sceneGroup:insert( background5 )
	sceneGroup:insert(floor)
	sceneGroup:insert(xapGroup)
	sceneGroup:insert(trapGroup)
	sceneGroup:insert(enemyGroup)
	sceneGroup:insert(urnGroup)


end

 ---***** COde for the puzzle that is half working *****
-- Custom function for resuming the game (from pause state)
function scene:resumeGame()
    
end
 
-- Options table for the overlay scene "pause.lua"
local options = {
    isModal = true,
    effect = "fade",
    time = 400,
    }
--************************************

 
function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then -- when scene is about to come on screen
	elseif phase == "did" then -- when scene comes on, insert audio/animations here
		physics.start()
	end
end

function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then -- when scene is about to go off screen
	elseif phase == "did" then	--when the scene leaves the screen
	end
end


function scene:destroy( event )

	local sceneGroup = self.view

	display.remove(xap.healthbar)
	package.loaded[physics] = nil
	package.loaded[xap] = nil
	package.loaded[trap] = nil
	package.loaded[enemy] = nil
	package.loaded[col] = nil

	Runtime:removeEventListener("enterFrame", xap.move)
	Runtime:removeEventListener("key", xap.onKeyEvent)
	Runtime:removeEventListener("mouse", xap.saberAttack )
	Runtime:removeEventListener( "tap", xap.daggerAttack )
	Runtime:removeEventListener("enterFrame", setXap)

	physics = nil

	
end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

Runtime:addEventListener("enterFrame", xap.move)
Runtime:addEventListener("key", xap.onKeyEvent)
Runtime:addEventListener("mouse", xap.saberAttack )
Runtime:addEventListener( "tap", xap.daggerAttack )



return scene
