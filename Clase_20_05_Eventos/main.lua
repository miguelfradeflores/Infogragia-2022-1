-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here


cw = display.contentWidth
ch = display.contentHeight

fondo = display.newRect( cw/2, ch/2, cw, ch )
fondo:setFillColor( 0.45 )

heroe_move_speed = 300

local rotacion_icono

cuadrado = display.newRect(cw/2, ch/2, 50, 50)

circulo = display.newCircle( cw/2, ch/4, 25 )

redondo = display.newCircle ( cw/2, ch*0.75, 25)
redondo:setFillColor( 0,0,1 )
redondo.nombre = "Juan"
redondo.alpha = 0.5

rectangulo = display.newRect( cw/4, ch/2, 30, 50 )
rectangulo:setFillColor( 1, 0, 0 )
rectangulo.alpha=0.2

icono = display.newImage("Icon.png", cw*0.75, ch/2)
icono.rotation = 90
icono.anchorX = 0; icono.anchorY =0 
print("Rotacion del icono", icono.rotation)

titulo = display.newText( "Victoria!", cw/2, ch/8, "arial", 20 )

print("Propiedad alpha del rectangulo", rectangulo.alpha)

function mover_cuadrado(event )
	if (event.phase == "began") then
		print( "Fase began del circulo", event.x, event.y )
		--capturar posicion del click del mouse

	elseif (event.phase == "moved") then
		print( "Fase moved", event.x, event.y )


	elseif( event.phase == "ended") then
		print( "Fase del ended", event.x, event.y )
		-- cuadrado.x =  math.random( 0, cw  )
		-- cuadrado.y =   math.random( 0, ch )

		neoX =  math.random( 0, cw  )
		neoY =  math.random( 0, ch )
		transition.to( cuadrado, {x=neoX, y=neoY, time=1000})

		-- jugador mover(posicion del mouse)

	end

end


function tocar_cuadrado( event )

	if (event.phase == "began") then
		print( "Fase began del cuadrado", event.x, event.y )
	elseif (event.phase == "moved") then
		print( "Fase moved", event.x, event.y )
		if event.x > 0  and event.x < cw and event.y > 0 and event.y <ch then
			cuadrado.x = event.x;
			cuadrado.y = event.y
		end

	elseif( event.phase == "ended") then
		print( "Fase del ended", event.x, event.y )
	end

end


function redondo:describir(apellido)

	print("Soy un redondo ".. redondo.nombre .. " " .. apellido)
end

function rellenar(e)
	if e.phase == "ended" then
		print("rellenar")
	end

end

arreglo = {}

function redondo:touch(event)

	if (event.phase == "began") then
		self:describir("Pedraza")
	elseif (event.phase == "moved") then
		print( "Fase moved", event.x, event.y )


	elseif( event.phase == "ended") then
		print( "Fase del ended", event.x, event.y )
		red = math.random(0,255)/255

		green = math.random(0,255)/255
		blue = math.random(0,255)/255

		cuadrado:setFillColor( red, green, blue )

		redondo:removeEventListener( "touch", redondo )
		redondo:addEventListener( "touch", rellenar )

		transition.to(redondo, { alpha=0.2, time =500, iterations = 20 })

	end
	return true
end

function agrandar( self, e)

	if e.phase == "ended" then
		-- self.width = self.width *2
		-- self.height = self.height *2

--		transition.to(self, { xScale=self.xScale*2, yScale=2, time=800 })
		transition.to(self, { width=self.width/2, height=self.height*3, time = 1000  })
		transition.to(self, {x=cw, time =2000, alpha=1})


	end
	return true
end

function fondo:touch( e )
	if e.phase == "ended" or e.phase == "cancelled" then 
		-- circulo.x = e.x
		-- circulo.y = e.y
		transition.to(circulo, {x=e.x , y=e.y, time= heroe_move_speed })

	end
	return true
end

fondo:addEventListener( "touch", fondo )

rectangulo.touch = agrandar

rectangulo:addEventListener( "touch", rectangulo )

cuadrado:addEventListener( "touch", tocar_cuadrado )

circulo:addEventListener( "touch", mover_cuadrado )

redondo:addEventListener( "touch", redondo )
-- redondo:addEventListener( "touch", rellenar )

function icono:touch(e)

	if e.phase == "ended" then
		transition.pause(rotacion_icono)
	end
	return true
end


function detenidos()
	print("objeto detenido")
	icono:setFillColor( 1,0,0 )
end

function iniciar( ... )
	icono.xScale = 2;
	icono.yScale = 2
end

function mover(  )
	-- body


	transition.to(icono, {y = ch/8, time=1000, delay = 2000, onStart = iniciar})

end

icono:addEventListener( "touch", icono )

rotacion_icono = transition.to(icono, {rotation = 720, time = 5000, onComplete = mover, onPause = detenidos, tag = "objeto"})

transition.to(titulo, { size = 40, iterations=6, time =1000, tag = "objeto" })

