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
	
	physics.addBody( t.display, t.bodyType, {friction = t.friction, bounce = t.bounce})
end

local function scrollObjects(self, event)
if self.display ~= nil then
	if self.display.x ~= nil then
		self.display.x = self.display.x + G.currentXapXSpeed
	end
end
end

t.spawn = spawn

t.enterFrame = scrollObjects
Runtime:addEventListener("enterFrame", t)

return t