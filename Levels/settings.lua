local composer = require( "composer" )
local scene = composer.newScene()
local widget = require "widget"



local function backButtonTouch()
	composer.gotoScene( G.levels.."menu")
	return true
end

local function drawModeTouch()
	if G.drawMode == "normal" then
		G.drawMode = "hybrid"
	else
		G.drawMode = "normal"
	end
	return true
end


function scene:create( event )
	local sceneGroup = self.view


	local background = display.newImageRect( G.backgrounds.."menu.jpg", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY

	
	local backButton = widget.newButton
		{
			label = "Back",
			labelColor = { default={255}, over={128} },
			default = G.misc.."button.png",
			over = G.misc.."button-over.png",
			fontSize = 90,
			width = 154, height=40,
			onRelease = backButtonTouch
		}
		backButton.x = display.contentCenterX
		backButton.y = display.contentHeight - 300
		
			local drawMode = widget.newButton
		{
			label = "Enable Draw Mode",
			labelColor = { default={255}, over={128} },
			default = G.misc.."button.png",
			over = G.misc.."button-over.png",
			fontSize = 90,
			width = 154, height=40,
			onRelease = drawModeTouch
		}
		drawMode.x = display.contentCenterX
		drawMode.y = display.contentHeight - 600
	
	
	sceneGroup:insert( background )
	sceneGroup:insert(backButton)
	sceneGroup:insert(drawMode)

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