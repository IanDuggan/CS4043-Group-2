G = {}

--paths--
G.levels = "Levels."
G.images = "Assets/Images/"
G.backgrounds = "Assets/Images/Backgrounds/"
G.enemies ="Assets/Images/enemies/" 
G.misc = "Assets/Images/Misc/"
G.traps = "Assets/images/Traps/"
G.xap = "Assets/images/Xap/"
G.sounds = "Assets/Sounds/"


--random--
G.width = display.actualContentWidth
G.height = display.actualContentHeight
--G.drawMode = "hybrid"
G.drawMode = "normal"

G.xapSpeed = 10

--platform names
G.android = (system.getInfo("platformName") == "Android")
G.winPhone = (system.getInfo("platformName ") == "WinPhone") 