local t = {}

local function spawn(params)

	t.group = {}
	
	t.display = display.newImageRect(params.image, 60,60)
	t.display.myName = params.myName
	t.display.x = params.x
	t.display.y = params.y
	t.rotation = params.rotation or 0
	t.friction = params.friction or .5
	t.bounce = params.bounce or 0
	t.bodyType = bodyType
	t.i = params.i
	t.group[t.i] = t.display 
	
	physics.addBody( t.display, t.bodyType, {friction = t.friction, bounce = t.bounce})
end

t.spawn = spawn

return t