local composer = require( "composer" )
local scene = composer.newScene()
local widget = require "widget"

audio.stop(2)

local function mainMenuTouch()
	composer.gotoScene( G.levels.."menu")
	return true
end


function scene:create( event )
	local sceneGroup = self.view


		local background = display.newImageRect( G.backgrounds.."dead.png", display.actualContentWidth, display.actualContentHeight )
		background.anchorX = 0
		background.anchorY = 0
		background.x = 0 + display.screenOriginX 
		background.y = 0 + display.screenOriginY

		local mainMenuButton = display.newRect( 0, 0, 1200, 100 )
		mainMenuButton:setFillColor(gray)

		local mainMenu = widget.newButton
		{
			label = "You've died, click to go back to main menu",
			labelColor = { default={255}, over={128} },
			default = G.misc.."button.png",
			over = G.misc.."button-over.png",
			fontSize = 90,
			width = 154, height=40,
			onRelease = mainMenuTouch
		}
		mainMenu.x = display.contentCenterX
		mainMenu.y = display.contentHeight - 600

	
	sceneGroup:insert( background )
	sceneGroup:insert(mainMenu)
	sceneGroup:insert(mainMenuButton)

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
	composer.removeScene(G.levels.."menu")
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

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
