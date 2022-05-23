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


cuadrado = display.newRect(cw/2, ch/2, 50, 50)

circulo = display.newCircle( cw/2, ch/4, 25 )

redondo = display.newCircle ( cw/2, ch*0.75, 25)
redondo:setFillColor( 0,0,1 )
redondo.nombre = "Juan"

rectangulo = display.newRect( cw/4, ch/2, 30, 50 )
rectangulo:setFillColor( 1, 0, 0 )

function mover_cuadrado(event )
	if (event.phase == "began") then
		print( "Fase began del circulo", event.x, event.y )
	elseif (event.phase == "moved") then
		print( "Fase moved", event.x, event.y )


	elseif( event.phase == "ended") then
		print( "Fase del ended", event.x, event.y )
		cuadrado.x =  redondo.x  --math.random( 0, cw  )
		cuadrado.y =  redondo.y  -- math.random( 0, ch )
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

	end
	return true
end

function agrandar( self, e)

	if e.phase == "ended" then
		self.width = self.width *2
		self.height = self.height *2
	end
end

rectangulo.touch = agrandar

rectangulo:addEventListener( "touch", rectangulo )

cuadrado:addEventListener( "touch", tocar_cuadrado )

circulo:addEventListener( "touch", mover_cuadrado )

redondo:addEventListener( "touch", redondo )
-- redondo:addEventListener( "touch", rellenar )


