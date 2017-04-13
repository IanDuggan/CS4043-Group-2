local composer = require "composer"
local g = require("globals")
local M = require("maths")
local xap = require("xap")
local maths = require("maths")
local E = {}

local ai
local id = 0
local group = {}

local function spawn(params) 
	E.type = params.type or "mummy"

	if E.type == "mummy" then
		E.image = G.enemies.."mummyEnemy.png"
		E.imageX = 321
		E.imageY = 379
	end

	--add more if statements depending on the type of creature when we get there :)
	

	E.display = display.newImageRect(E.image, E.imageX, E.imageY)

	E.index = params.index
	E.display.myName = params.myName or "enemy"
	E.display.x = params.x
	E.display.y = params.y
	E.density = params.density or 0
	E.friction = params.friction or 0
	E.bounce = params.bounce or 0
	E.bodyType = params.bodyType or "dynamic"

	physics.addBody(E.display, E.bodyType, {density = E.density, friction = E.friction, bounce = E.bounce, isSensor = E.isSensor})


	group[id] = E.display
	id = id + 1

	local tempX = xap.display.x
	local tempY = xap.display.y

	local function ai()
		
		if(maths.calculateDistance(
			{	x1 = E.display.x, 
				y1 = E.display.y, 
				x2 = xap.display.x, 
				y2 = xap.display.y
			})	< 750) 
		then	
			if tempX == nil and tempY == nil then
				tempX = xap.display.x
				tempY = xap.display.y
			end

			transition.moveTo(E.display, (
			{
				time = 7500, x = tempX, y = tempY
			}	)	)
		else
			transition.cancel()
		end
	end
	E.ai = ai
	Runtime:addEventListener("enterFrame", E.ai)
end



	

E.spawn = spawn


return E



