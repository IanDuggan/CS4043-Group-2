local g = require("globals")

local M = {}

local function calculateDistance(params)
	M.x1 = params.x1 or 0
	M.x2 = params.x2 or 0
	M.y1 = params.y1 or 0
	M.y2 = params.y2 or 0

	M.distance = math.sqrt((M.x2 - M.x1)*(M.x2 - M.x1) + (M.y2 - M.y1)*(M.y2 - M.y1))
	print(M.distance)
end

M.calculateDistance = calculateDistance

return M