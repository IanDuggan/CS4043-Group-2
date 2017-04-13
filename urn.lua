local g = require("globals")
--local xap = require("xap")

local urn = {}


local function spawn(params)

	urnGroup = display.newGroup()

	urn.state = params.state or "closed"
	urn.image = "urnDusty.png"
	urn.myName = "urn"

	urn.closed = display.newImageRect(G.urns.."urnDusty.png", 180, 295)

	urn.closed.x = params.x or 0
	urn.closed.y = params.y or 0

	urn.opened = display.newImageRect(G.urns.."urnDustyOpen.png", 180, 295)
	
	urn.opened.x = params.x or 0
	urn.opened.y = params.y or 0
	urn.opened.alpha = 0
	
	urnGroup:insert(urn.opened)
	urnGroup:insert(urn.closed)

	urn.score = params.score or 0
end

urn.spawn = spawn

return urn