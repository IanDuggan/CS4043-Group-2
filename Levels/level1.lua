local composer = require( "composer" )
local physics = require ("physics")
local xap = require("xap")
local trap = require("traps")
local enemy = require("enemySpawn")
local g = require("globals")
local input = require("input")
local combat = require("combat")
local col = require("collision")

local scene = composer.newScene()

physics.setDrawMode(G.drawMode)

function scene:create( event )

	local sceneGroup = self.view
	physics.start()
	physics.pause()

	local background = display.newImageRect( G.backgrounds.."level1.jpg",  display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0

	function scrollCity(self, event)
		self.x = self.x - 3
	end
	
	
	
	local floor = display.newRect(0, 0, G.width, 1 )
	floor.x = G.width / 2; floor.y = G.height - 35
	physics.addBody(floor, "static", { friction = .5, bounce = .3} )
	floor.alpha = 0
	


		trap.spawn(
		{
			myName = "trap",
			image = G.traps.."trap.png",
			x = G.width/2 - 270,
			y = G.height - 50,			
			bodyType = "static",
			friction = .5,
			bounce = 0,
		}	)
		
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
		}	)

		xap.spawn(
		{
			x = G.width / 2,
			y = G.height -100,
		}	)
		
		enemy.spawn(
		{
			type = "mummy",
			index = 1,
			x = 1500,
			y = 870,
			density = 1.0,
			friction = 0.8,
			bounce = 0.4,
			bodytype = "dynamic",
		}	)
	


	
	

	
	
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert(floor)


end


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

	if event.phase == "will" then -- when scene is about to go off screen
	elseif phase == "did" then	--when the scene leaves the screen
	end
end


function scene:destroy( event )

	local sceneGroup = self.view

	display.remove(background)
	display.remove(floor)
	display.remove(newEnemy)

	
	package.loaded[physics] = nil
	physics = nil
end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
Runtime:addEventListener("key", input.onKeyEvent)

return scene
