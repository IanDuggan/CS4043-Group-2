local composer = require( "composer" )
local scene = composer.newScene()
local physics = require ("physics")
local input = require ("input")
local combat = require ("combat")
--alocal spawn = require ("spawn")


--Check hitboxes and shit
physics.setDrawMode("hybrid")

--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = G.width, G.height, display.contentCenterX

function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view
	
	physics.start()
	physics.pause()


	-- create a grey rectangle as the backdrop <change as needed>
	local background = display.newRect( display.screenOriginX, display.screenOriginY, screenW, screenH )
	background.anchorX = 0 
	background.anchorY = 0
	background:setFillColor( .5 )
	
	--adds a floor (no shit)
	local floor = display.newRect(0, 0, G.width, 40 )
	floor.x = G.width / 2; floor.y = G.height - 35
	physics.addBody(floor, "static", { friction = .5, bounce = .3} )

	--adds xap to the game
	
	xap = display.newImageRect( "capnXap.png", 250, 250 )
	physics.addBody( xap, "dynamic", {friction = .5, bounce = 0})
	xap.myName="xap"
	xap.x = G.width / 2; xap.y = G.height - 180

	-- all display objects must be inserted into group
	sceneGroup:insert( background )

	sceneGroup:insert( xap )
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end



---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


-----------------------------------------------------------------------------------------

return scene