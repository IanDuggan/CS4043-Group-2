local t = {}

local function spawn(params)

	t.myName = params.myName
	t.display = display.newImageRect(params.image, 60,60)
	t.display.x = params.x
	t.display.y = params.y
	t.rotation = params.rotation or 0
	t.friction = params.friction or .5
	t.bounce = params.bounce or 0
	t.bodyType = bodyType

	physics.addBody( t.display, t.bodyType, {friction = t.friction, bounce = t.bounce})
end

t.spawn = spawn

return t