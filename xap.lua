require("globals")

local xap = {}


local function spawn(params)

	xap.display = display.newImageRect( G.xap.."Xap.png", 240, 419 )
	xap.myName = "xap"
	xap.motionX = params.motionx or 0 
	xap.speed = G.xapSpeed
	xap.isAlive = true
	xap.canJump = params.canJump or true 
	xap.health =  params.health or 100

	
	xap.display.x = params.x or 0
	xap.display.y = params.y or 0
	
	
	physics.addBody( xap.display, "dynamic", {friction = 0.5, bounce = 0})
	xap.isFixedRotation = true
end

xap.spawn = spawn







return xap

