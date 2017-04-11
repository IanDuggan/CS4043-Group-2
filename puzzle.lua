local composer = require( "composer" )
local physics = require ("physics")
local xap = require("xap")
local lvl1 = require(G.levels.."level1")
local g = require("globals")
physics.start()
physics.stop()
--*****Puzzle half works ***********
local scene = composer.newScene()
 

--io.output():setvbuf("no") 
--display.setStatusBar(display.HiddenStatusBar)  
local w       = display.contentWidth		
local h       = display.contentHeight
local centerX = display.contentWidth/2 
local centerY = display.contentHeight/2

	
local puzzleName = "puzzle"


local puzzlePieces = {}						


local gameStatusMsg							

local puzzleArea							

local piecesTray							

local drawBoard								
local placePieces							
local movePiecesToTray						

local isSolved								
local pointInRect							


local onPuzzlePieceTouch					

drawBoard = function()

	
	puzzleArea = display.newRect( 0, 0, 300, 240) 

	

	puzzleArea.x = w - 160
	puzzleArea.y = centerY + 35

	puzzleArea:setFillColor( 0.125,0.125,0.125,1 )
	puzzleArea:setStrokeColor( 0.5,0.5,0.5,1 )
	puzzleArea.strokeWidth = 1

	piecesTray = display.newRect( 0, 0, 140, 140) 

	piecesTray.x = 85
	piecesTray.y = centerY

	
	piecesTray:setFillColor( 0.125,0.125,0.125,1 )
	piecesTray:setStrokeColor( 0.5,0.5,0.5,1 )
	piecesTray.strokeWidth = 1

	
	gameStatusMsg = display.newEmbossedText( "Puzzle Solved!", 0, 0, native.systemFont, 36 )		

	gameStatusMsg.x = puzzleArea.x
	gameStatusMsg.y = 40

	gameStatusMsg:setFillColor( 0.1211,0.8633,0.1211 )	
	gameStatusMsg.isVisible = false			

end



placePieces = function()

	
	local left   = puzzleArea.x - puzzleArea.contentWidth/2
	local right  = puzzleArea.x + puzzleArea.contentWidth/2
	local top    = puzzleArea.y - puzzleArea.contentHeight/2
	local bottom = puzzleArea.y + puzzleArea.contentHeight/2

	
	local tmp
	for row = 1, 2 do
		for col = 1, 2 do

		local imgNum = row + (col-1) * 2
		
		tmp = display.newImage( G.misc .. puzzleName .. "/" .. imgNum .. ".png") 

		
		if(imgNum == 1) then
			--tmp:setReferencePoint( display.TopLeftReferencePoint )
			tmp.x = left
			tmp.y = top
			tmp.anchorX = 0
			tmp.anchorY = 0


		elseif(imgNum == 2) then
			--tmp:setReferencePoint( display.TopRightReferencePoint )
			tmp.x = right
			tmp.y = top
			tmp.anchorX = 1
			tmp.anchorY = 0

		elseif(imgNum == 3) then
			--tmp:setReferencePoint( display.BottomLeftReferencePoint )
			tmp.x = left
			tmp.y = bottom
			tmp.anchorX = 0
			tmp.anchorY = 1

		elseif(imgNum == 4) then
			--tmp:setReferencePoint( display.BottomRightReferencePoint )
			tmp.x = right
			tmp.y = bottom
			tmp.anchorX = 1
			tmp.anchorY = 1

		end

		
		tmp.solvedX = tmp.x
		tmp.solvedY = tmp.y

		
		tmp.isSolved = false

		
		tmp:addEventListener( "touch", onPuzzlePieceTouch )

		
		puzzlePieces[#puzzlePieces+1] = tmp

		end
	end

end


movePiecesToTray = function()

	
	local yStart = piecesTray.y - piecesTray.contentHeight/2 + 55
	local yEnd   = piecesTray.y + piecesTray.contentHeight/2 - 40

	
	local curY = yStart
	
	
	for i = 1, #puzzlePieces do

		local aPiece = puzzlePieces[i]

		
		aPiece.x = piecesTray.x + math.random( -20, 20 )

		
		aPiece.y = curY

		
		aPiece.inTrayX = aPiece.x
		aPiece.inTrayY = aPiece.y

		
		aPiece.xScale = 0.5
		aPiece.yScale = 0.5

	
		aPiece.rotation = math.random( -30, 30 )
		aPiece.inTrayAngle = aPiece.rotation

		
		curY = curY + math.random( 60, 100)
		if( curY > yEnd ) then
			curY = yStart
		end		

	end 
end


pointInRect = function( pointX, pointY, left, top, width, height )
	if( pointX >= left and pointX <= left + width and 
	    pointY >= top and pointY <= top + height ) then 
	   return true
	else
		return false
	end
end


isSolved = function()

	local retVal = true

	for i = 1, #puzzlePieces do
		retVal = retVal and  puzzlePieces[i].solved
	end

	return retVal
end



local function centerDrag( obj, event )	
	obj.x = obj.x0 + event.x - event.xStart
	obj.y = obj.y0 + event.y - event.yStart

	if( obj.anchorX == 0 ) then
		obj.x = obj.x - obj.contentWidth/2
	else
		obj.x = obj.x + obj.contentWidth/2
	end

	if( obj.anchorY == 0 ) then
		obj.y = obj.y - obj.contentHeight/2
	else
		obj.y = obj.y + obj.contentHeight/2
	end


end
onPuzzlePieceTouch = function( event )
	
	local phase    = event.phase  
	local target   = event.target
	local x        = event.x
	local y        = event.y

	local minSnapDistance = 15 

	
	
	if( target.solved ) then 
		return true 
	end

	
	if(event.phase == "began") then  
		target.rotation = 0
		
		target.xScale = 1
		target.yScale = 1

		target:toFront()

		
		target.isFocus = true 
		display.currentStage:setFocus( target )
		target.x0 = x
		target.y0 = y

	elseif( target.isFocus ) then

	    
		if(event.phase == "moved") then  
			--target.x = target.x0 + event.x - event.xStart
			--target.y = target.y0 + event.y - event.yStart
			centerDrag( target, event )


		
		elseif(event.phase == "ended") then  
		
			
			target.isFocus = true 
			display.currentStage:setFocus( nil )

			
			local dx  = target.x - target.solvedX
			local dy  = target.y - target.solvedY
			local len = math.sqrt( dx * dx + dy * dy )

			print("Dropped distance: ", len )

			if( len <= minSnapDistance ) then

				
				target.x = target.solvedX
				target.y = target.solvedY

				
				target.solved = true
			else

				

				local left   = piecesTray.x - piecesTray.contentWidth/2
				local top    = piecesTray.y - piecesTray.contentHeight/2
				local width  = piecesTray.contentWidth
				local height = piecesTray.contentHeight

				if( pointInRect( x, y, top, left, width, height ) ) then

					
					target.rotation = target.inTrayAngle
			
					target.xScale = 0.5
					target.yScale = 0.5

					target.x = target.inTrayX
					target.y = target.inTrayY
					
				end			
			end
		else
			return false
		end

		
		if( isSolved() ) then
			
			gameStatusMsg.isVisible = true
		
		end

	end

	return true
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    --local parent = event.lvl1 --reference to the parent scene object
 --***Not working***
    if ( isSolved() ) then
        -- Call the "resumeGame()" function in the parent scene
        lvl1:resumeGame()
    end
--******
end
drawBoard()
placePieces()
movePiecesToTray()
	
composer.hideOverlay( "fade", 400 )
 
scene:addEventListener( "hide", scene )

return scene
