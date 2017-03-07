local composer = require "composer"
local g = require "globals"

native.setProperty("windowMode", "fullscreen")
-- Hides the status bar
display.setStatusBar( display.HiddenStatusBar )

--Loads the menu screen
composer.gotoScene( G.levelsPath.."menu" )