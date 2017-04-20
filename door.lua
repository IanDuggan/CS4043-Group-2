local g = require("globals")
--local xap = require("xap")

local door = {}


local function spawn(params)

	doorGroup = display.newGroup()

	door.state = params.state or "closed"
	door.image = G.misc .. "doorway.png"
	door.myName = "door"

	door.display = display.newImageRect(door.image, 500, 600)
	
	door.display.x = params.x
	door.display.y = params.y
	
	doorGroup:insert(door.display)
	
	door.display.alpha = 100
	door.score = params.score
end

door.spawn = spawn

return door