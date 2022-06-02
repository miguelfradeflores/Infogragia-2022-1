-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

cw = display.contentWidth
ch = display.contentHeight


fondo = display.newImageRect("8.jpg", cw, ch)
fondo.x = cw/2; fondo.y = ch/2

local options = {

	width = 300,
	height= 300,
	numFrames = 8

}

local spriteDerecha = graphics.newImageSheet( "avanzaD.png", options )
local sptriteIzquierda = graphics.newImageSheet("avanzaL.png", options)


local sequence = {
		{
		name = "AvanzarDerecha",
		start = 1,
		count = 8,
		loopCount =0,
		time = 670,
		sheet = spriteDerecha
	--loopDirection = "bounce"
	},
	{
		name = "AvanzarIzquierda",
		-- start = 1,
		-- count = 8,
		frames = {4,3,2,1,8,7,6,5,4,3,2,2,2,2,2,1,1,1,2,3,3,4,5,9},
		loopCount =0,
		time = 1670,
		sheet = sptriteIzquierda
	},

}

local fox_hunter = display.newSprite(spriteDerecha, sequence)
fox_hunter:translate( cw/2, ch/3 )
fox_hunter.xScale= 0.3; fox_hunter.yScale = 0.3

print("frame: " .. fox_hunter.frame)
print("Is Playing: " .. tostring(fox_hunter.isPlaying))
print("# de frames: " .. fox_hunter.numFrames)
print("squence: " .. fox_hunter.sequence)
print("timeScale: " .. fox_hunter.timeScale)
fox_hunter:setSequence( "AvanzarIzquierda")
fox_hunter:play()
print("frame: " .. fox_hunter.frame)
print("Is Playing: " .. tostring(fox_hunter.isPlaying))
print("# de frames: " .. fox_hunter.numFrames)
print("squence: " .. fox_hunter.sequence)
print("timeScale: " .. fox_hunter.timeScale)