local composer = require ("composer")
local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view
	
	local background = display.newImageRect(G.backgrounds.."levelSelect.jpg",  display.actualContentWidth, display.actualContentHeight)
		background.anchorX = 0
		background.anchorY = 0
		background.x = 0 + display.screenOriginX 
		background.y = 0 + display.screenOriginY
	
	sceneGroup:insert(background)
end

function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
	
	elseif phase == "did" then
	composer.removeScene(G.levels.."menu")
	end
end

function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
	
	elseif phase == "did" then
	end
end

function scene:destroy(event)
	local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene