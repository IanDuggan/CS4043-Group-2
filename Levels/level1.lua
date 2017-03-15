local composer = require( "composer" )
local scene = composer.newScene()
local physics = require ("physics")
local input = require ("input")
local combat = require ("combat")

--Check hitboxes and shit
physics.setDrawMode("hybrid")

function scene:create( event )

	local sceneGroup = self.view
	physics.start()
	physics.pause()

	local background = display.newImageRect( G.backgrounds.."level1.jpg",  display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0

	
	local floor = display.newRect(0, 0, G.width, 40 )
	floor.x = G.width / 2; floor.y = G.height - 35
	physics.addBody(floor, "static", { friction = .5, bounce = .3} )

	
	xap = display.newImageRect( G.xap.."capnXap.png", 250, 250 )
	physics.addBody( xap, "dynamic", {friction = .5, bounce = 0})
	xap.myName = "xap"
	xap.x = G.width / 2
	xap.y = G.height - 180

	trap = display.newImageRect(G.traps.."trap.png", 100,100)
	physics.addBody(trap, "static", {friction = .5, bounce = 0})
	trap.myName = "trap"
	trap.x = G.width / 2 - 270; trap.y = G.height - 50

	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert(trap)
	sceneGroup:insert(floor)
	sceneGroup:insert( xap )
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
	display.remove(trap)
	
	package.loaded[physics] = nil
	physics = nil
end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene