local composer = require( "composer" )
local scene = composer.newScene()
local widget = require "widget"

local playButton

--After pressing play, level 1 initiates
local function PlayButtonTouch()
	composer.gotoScene( "level1", "fade", 500 )
	return true
end

function scene:create( event )
	local sceneGroup = self.view


	local background = display.newImageRect( "sandBackground.png", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY
	
	
	local titleLogo = display.newImageRect( "logo.png", 1000, 200)
	titleLogo.x = display.contentCenterX
	titleLogo.y = 100
	
	-- create a widget button (which will loads level1.lua on release)
	playButton = widget.newButton
	{
		label = "Play Now",
		labelColor = { default={255}, over={128} },
		default = "button.png",
		over = "button-over.png",
		fontSize = 90,
		width = 154, height=40,
		onRelease = PlayButtonTouch	-- event listener function
	}
	playButton.x = display.contentCenterX
	playButton.y = display.contentHeight - 600
	

	sceneGroup:insert( background )
	sceneGroup:insert( titleLogo )
	sceneGroup:insert( playButton )
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
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if playButton then
		playButton:removeSelf()	-- widgets must be manually removed
		playButton = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene