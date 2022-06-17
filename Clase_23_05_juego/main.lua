-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

cw = display.contentWidth
ch = display.contentHeight

local grupo_background, grupo_intermedio, grupo_delantero

grupo_background = display.newGroup( )
grupo_intermedio = display.newGroup( )
grupo_delantero = display.newGroup()


local puntos = 0
-- imagen mide 1152 de ancho
-- dimension de ancho 1024


boton_inicio = display.newImageRect(grupo_delantero, "play.png", 100,100)
boton_inicio.x = cw/2; boton_inicio.y = ch/5


fondo = display.newImageRect("1.jpg", cw, ch)
fondo.x = 0;
fondo.y = 0
fondo.anchorX = 0
fondo.anchorY = 0

grupo_background:insert( fondo  )
--fondo.xScale = 1.5

-- la imagen f1.png la vamos a usar para sumar puntos
-- tiempo de vida de las manzanas para que puedan sumar puntos
-- que  las manzanas transicionen para tener dificultas



puntaje = display.newText(  grupo_intermedio,  "SCORE: " .. puntos, 70,50, "arial", 30)
puntaje.anchorY = 0; puntaje.anchorX =0.5

local manzanas = {}

function destruirManzana(self, event)

	if event.phase == "ended" then
		-- desaparecer objeto
		--aumentar marcador 
		if self.se_puede_matar then
			puntos = puntos + 5
			puntaje.text = "SCORE: " .. puntos
			self:removeSelf( )
		end
	end
	return 
end

function mover(manzana)
	transition.to(manzana, { tag= "movimiento", time = 1000, x=math.random(0, cw), y= math.random(0, ch), onComplete= mover})
end

function crearManzanas( cantidad, ancho, alto )
	-- body
	for i=1, cantidad,1 do
		manzanas[i] = display.newImageRect("f1.png", ancho, alto)
		manzanas[i].x =math.random(0, cw); manzanas[i].y =math.random(0, ch)
		manzanas[i].touch = destruirManzana
		manzanas[i]:addEventListener( "touch", manzanas[i] )
		manzanas[i].se_puede_matar = true

		posx = math.random(0, cw)
		posy = math.random(0, ch)
		grupo_intermedio:insert(  manzanas[i] )
		manzanas[i].transition = transition.to(manzanas[i], {time =3000, x=posx, y=posy, onComplete= mover, tag = "movimiento"})

	end	
end

function reanudar_animacion()
	for i=1, #manzanas, 1 do
		manzanas[i].se_puede_matar = true
	end

	transition.resume("movimiento")
end

function boton_inicio:touch(e)
	if e.phase == "ended" then
		if grupo_intermedio.isVisible then
			grupo_intermedio.isVisible = false
			transition.pause("movimiento")
			for i=1, #manzanas, 1 do
				manzanas[i].se_puede_matar = false
				-- transition.pause(manzanas[i].transition )
			end
		else
			grupo_intermedio.isVisible = true
			transition.to(grupo_intermedio, {time = 3000, onComplete= reanudar_animacion})
		end

	end
	return true
end

boton_inicio:addEventListener( "touch", boton_inicio )

-- manzana = crearManzanas( math.random( 0, cw ), math.random(0,ch), 1, 50,50)
-- manzana.touch = destruirManzana

-- manzana:addEventListener( "touch", manzana )

print("grupo grupo_intermedio ", grupo_intermedio, grupo_intermedio.numChildren )

crearManzanas(10, 50,50)

print("posiciones del grupo",  grupo_intermedio.x, grupo_intermedio.y, grupo_intermedio.numChildren)
transition.to(grupo_intermedio, {time =3000, x=cw/2 } )
