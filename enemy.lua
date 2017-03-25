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

	local E = display.newImageRect(E.image, E.imageX, E.imageY)

	E.index = params.index
	E.myName ="enemy"
	E.x = params.x
	E.y = params.y
	E.density = params.density or 0
	E.friction = params.friction or 0
	E.bounce = params.bounce or 0
	E.bodyType = params.bodyType or "dynamic"

	physics.addBody(E, E.bodyType, {density = E.density, friction = E.friction, bounce = E.bounce, isSensor = E.isSensor})
--[[
	local function ai()
		if 	(maths.calculateDistance( {x1 = xap.display.x, x2 = E.x, y1 = xap.display.y, y2 = E.y }) <= 10) then 

		end
	end
--]]
end




E.spawn = spawn

return E



