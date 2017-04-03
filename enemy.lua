local composer = require "composer"
local g = require("globals")
local M = require("maths")
local xap = require("xap")

local E = {}



local function spawn(params) 
	E.type = params.type

	if E.type == "mummy" then
		E.image = G.enemies.."mummy.png"
		E.imageX = 250
		E.imageY = 250
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
--[[
	local function ai()
		if 	(maths.calculateDistance( {x1 = xap.display.x, x2 = E.x, y1 = xap.display.y, y2 = E.y }) <= 10) then 

		end
	end
--]]

	function scrollObjects(self, event)
		if self.display.x ~= nil then
			self.display.x = self.display.x + G.currentXapXSpeed
		end
	end


	
end

	E.enterFrame = scrollObjects
	Runtime:addEventListener("enterFrame", E)
	E.spawn = spawn
return E



