local composer = require( "composer" )
local scene = composer.newScene()
local physics = require "physics"

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
	local xap = display.newImageRect( "capnXap.png", 90, 90 )
	physics.addBody( xap, "dynamic", {friction = .5, bounce = 0})
	xap.x = 50; xap.y = G.height - 100
	
	--Testing around with movement of Xap
	
	--add left joystick
	local left = display.newRect(0,0,160,160)
	left.x = 50; left.y = 280;
	
	--add right joystick
	local right = display.newRect(0,0,160,160)
	right.x = G.width - 50; right.y = 280;

	
	function left:touch()
		G.motionx = -G.speed;
	end
	left:addEventListener("touch", left)
	
	function right:touch()
		G.motionx = G.speed;
	end
	right:addEventListener("touch", right)
	
	
	--move character
	local function movePlayer (event)
		xap.x = xap.x + G.motionx;
	end
	Runtime:addEventListener("enterFrame", movePlayer)
	
	local function stop (event)
  if event.phase =="ended" then
   G.motionx = 0;
  end
 end
 Runtime:addEventListener("touch", stop )
	
	
	--let character jump
	local function onTouch(event)
		if(event.phase == "began") then
		xap:setLinearVelocity(0, -200)
		end
	end
	Runtime:addEventListener("touch", onTouch)

	
	
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