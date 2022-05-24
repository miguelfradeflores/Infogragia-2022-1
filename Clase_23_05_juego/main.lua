-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

cw = display.contentWidth
ch = display.contentHeight

local puntos = 0
-- imagen mide 1152 de ancho
-- dimension de ancho 1024

fondo = display.newImageRect("1.jpg", cw, ch)
fondo.x = 0;
fondo.y = 0
fondo.anchorX = 0
fondo.anchorY = 0
--fondo.xScale = 1.5

-- la imagen f1.png la vamos a usar para sumar puntos
-- tiempo de vida de las manzanas para que puedan sumar puntos
-- que  las manzanas transicionen para tener dificultas



puntaje = display.newText("SCORE: " .. puntos, 70,50, "arial", 30)
puntaje.anchorY = 0; puntaje.anchorX =0.5

local manzanas = {}

function destruirManzana(self, event)

	if event.phase == "ended" then
		-- desaparecer objeto
		--aumentar marcador 
		puntos = puntos + 5
		puntaje.text = "SCORE: " .. puntos
		self:removeSelf( )
	end
	return 
end

function mover(manzana)
	transition.to(manzana, {time = 1000, x=math.random(0, cw), y= math.random(0, ch), onComplete= mover})
end

function crearManzanas(  cantidad, ancho, alto )
	-- body
	for i=1, cantidad,1 do
		manzanas[i] = display.newImageRect("f1.png", ancho, alto)
		manzanas[i].x =math.random(0, cw); manzanas[i].y =math.random(0, ch)
		manzanas[i].touch = destruirManzana
		manzanas[i]:addEventListener( "touch", manzanas[i] )

		posx = math.random(0, cw)
		posy = math.random(0, ch)

		transition.to(manzanas[i], {time =3000, x=posx, y=posy, onComplete= mover})

	end	
end




-- manzana = crearManzanas( math.random( 0, cw ), math.random(0,ch), 1, 50,50)
-- manzana.touch = destruirManzana

-- manzana:addEventListener( "touch", manzana )

crearManzanas(10, 50,50)

