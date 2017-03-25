local xap = {}

local function spawn(params)

	xap.display = display.newImageRect( G.xap.."Xap.png", 240, 419 )
	xap.myName = "xap"
	xap.canJump = true
	xap.velocity = 0.5
	xap.isAlive = true
	xap.canJump = true
	xap.health = 100

	
	xap.display.x = params.x or 0
	xap.display.y = params.y or 0
	
	
	physics.addBody( xap.display, "dynamic", {friction = 0.5, bounce = 0})
	xap.isFixedRotation = true
end

xap.spawn = spawn







return xap

