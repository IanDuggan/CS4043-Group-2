local g = require("globals")
--local xap = require("xap")

local urn = {}


local function spawn(params)

	urnGroup = display.newGroup()

	urn.state = params.state or "closed"
	urn.image = "urnDusty.png"
	urn.myName = "urn"

	if urn.state == "closed" then
		urn.image = "urnDusty.png"
	elseif urn.state == "opened" then
		urn.image = "urnDustyOpen.png"
	end

	urn.display = display.newImageRect(G.urns..urn.image, 180, 295)
	urn.display.x = params.x or 0
	urn.display.y = params.y or 0

	--physics.addBody( urn.display, "static", {friction = .5, isSensor = true, bounce = 0})

	urnGroup:insert(urn.display)

	urn.score = params.score or 0
	
end

local function open(params)
	

end

urn.spawn = spawn
urn.open = open

return urn