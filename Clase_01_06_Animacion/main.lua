-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local physics = require( "physics" )
-- Your code here

cw = display.contentWidth
ch = display.contentHeight

physics.start()
physics.setDrawMode( "hybrid" )

fondo = display.newImageRect("8.jpg", cw, ch)
fondo.x = cw/2; fondo.y = ch/2

local piso = display.newRect(cw/2, ch/2 -20, cw, 2)
piso:setFillColor( 1, 0, 0 )

local box_body = {
	halfWidth = cw/2,
	halfHeight = 18,
	x = 0,
	y= 0,
	angle = 0

}
physics.addBody(piso, "static", {friction = 0.5})
piso.isVisible = false

--physics.addBody( fondo, "static", {box = box_body}  )

local attackSpeed = 5
local puedeAtacar = true
local direccion = "D"

local options = {

	width = 300,
	height= 300,
	numFrames = 8

}

local options2 = {

	width = 1599/3,
	height= 300,
	numFrames = 6

}


local spriteDerecha = graphics.newImageSheet( "avanzaD.png", options )
local sptriteIzquierda = graphics.newImageSheet("avanzaL.png", options)
local sptiteAcciones = graphics.newImageSheet("especialL.png", options2)

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
		frames = {4,3,2,1,8,7,6,5,4},
		loopCount =0,
		time = 670,
		sheet = sptriteIzquierda
	},
	{
		name = "atacar",
		sheet = sptiteAcciones,
		frames = {3,2,1,2},
		time = 5000/attackSpeed,
		loopCount = 1

	}

}

local fox_body = {
	halfWidth = 22,
	halfHeight = 24,
	x = 0,
	y= 0,
	angle = 0

}

local fox_hunter = display.newSprite(spriteDerecha, sequence)
fox_hunter:translate( cw/2, ch/3 )
fox_hunter.xScale= 0.3; fox_hunter.yScale = 0.3

physics.addBody(fox_hunter, "dynamic", {box= fox_body, friction = 0.3})

local boton_atacar = display.newImageRect("atacar.png", 50, 50 )
boton_atacar.x = cw - 60; boton_atacar.y = ch - 20
boton_atacar.anochorY = 1

function reanudar_caminata(  )
	fox_hunter:setSequence( "AvanzarIzquierda" )
	fox_hunter:play( )
	puedeAtacar = true
end

function atacar( event )
	if event.phase == "ended" then
		if puedeAtacar then
			desface = fox_hunter.x + 20
			transition.to(fox_hunter, { x=desface, time=500 })
			if direccion == "I" then
				fox_hunter.xScale = fox_hunter.xScale * -1
				puedeAtacar = false
				fox_hunter:setSequence( "atacar")
				fox_hunter:play()
				transition.to(fox_hunter, {time = 5000/attackSpeed, onComplete= reanudar_caminata} )
			else
				puedeAtacar = false
				fox_hunter:setSequence( "atacar")
				fox_hunter.xScale = fox_hunter.xScale * -1

				fox_hunter:play()
				transition.to(fox_hunter, {time = 5000/attackSpeed, onComplete= reanudar_caminata} )

			end

			fox_hunter:applyForce( 2, 0, fox_hunter.x, fox_hunter.y )

		end
	end
	return true
end

boton_atacar:addEventListener( "touch", atacar )


print("frame: " .. fox_hunter.frame)
print("Is Playing: " .. tostring(fox_hunter.isPlaying))
print("# de frames: " .. fox_hunter.numFrames)
print("squence: " .. fox_hunter.sequence)
print("timeScale: " .. fox_hunter.timeScale)
fox_hunter:setSequence( "AvanzarDerecha")
fox_hunter:play()
-- fox_hunter.rotation = 90
print("frame: " .. fox_hunter.frame)
print("Is Playing: " .. tostring(fox_hunter.isPlaying))
print("# de frames: " .. fox_hunter.numFrames)
print("squence: " .. fox_hunter.sequence)
print("timeScale: " .. fox_hunter.timeScale)