-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

-- JUEGO DE MEMORIA

cw = display.contentWidth
ch = display.contentHeight

fondo = display.newImageRect("donnas.png", cw, ch)
fondo.x = 0;
fondo.y = 0;
fondo.anchorX = 0;
fondo.anchorY = 0;

espacio = 10
espacioPuntuacion =0

rh = (ch-3*espacio-espacioPuntuacion)/4
rw = (cw-2*espacio)/3

tablaRecta = {}
local index=1

for i=1,4 do
	for j=1,3 do
		tablaRecta[index] = {}
		tablaRecta[index]["x"] = rw/2 + (j-1)*(rw + 10)
		tablaRecta[index]["y"] = rh/2 + (i-1)*(rh + 10)
		index = index + 1
	end
end

function pantallaDeInicio()
	
	local botonDeInicio = display.newRoundedRect( cw/2, ch/2, 150, 50, 12 ) 
	
	local textoDeInicio = display.newText( "Empezar", cw/2, ch/2, native.systemFontBold, 25) 
	
	local nombreDelJuego = display.newText("Juego de memoria", cw/2, ch/2-100, native.systemFont, 35) 
 
	
	botonDeInicio:setFillColor( 1/255,14/255,131/255 )
	nombreDelJuego:setFillColor( 145/255,2/255,131/255 )
	
	botonDeInicio:addEventListener( "tap", iniciarJuego)

	grupoDeInicio = display.newGroup()
	grupoDeInicio:insert( 1, botonDeInicio)
	grupoDeInicio:insert( 2, textoDeInicio)
	grupoDeInicio:insert( 3, nombreDelJuego)

end

function iniciarJuego(event)
	
	grupoDeInicio.isVisible = false
	dibujarTarjeta()
	return true
end

function tiempoTotalJugado(formas, procesarDeNuevo)
	
	if(formas == 0) then
		grupoDeTarjetas.isVisible = false
		local msg = "         Fin del juego \n\n Tiempo total jugado: " .. textoDeTiempo.text
		local tText = display.newText( msg,cw/2,ch/2,native.systemFontBold,25)
		tText:setFillColor( 128/255,4/255,106/255 )
		local holdTime = timer.performWithDelay(5000,
		function ()
			timer.cancel(timeKeeper)
			tText:removeSelf()
			grupoDeInicio:removeSelf()
			grupoDeTarjetas:removeSelf()
			pantallaDeInicio()
		end,1)
	end
end

function tarjetaDeEventos(event)
	if("began" == event.phase and formas > 0) then
		
		local clickedIndex = event.target.selectedIndex
		local clickedName = event.target.name
		local fname = clickedIndex..".png"	
		local scaleV = 0.05
	
		if (clickedIndex == seleccionAnterior and previousName ~= clickedName) then

			event.target.fill = { type = "image",filename = fname}
			local to_remove = previousTarget
			seleccionAnterior = -1
			previousName = -1
			previousTarget = nil
			score = score + 1
			formas = formas - 2

			local pauseT = timer.performWithDelay(500,
			function ()
				event.target:removeSelf()
				to_remove:removeSelf()
				tiempoTotalJugado(formas, procesarDeNuevo)
			end,1)

		else 
			
			event.target.fill = { type = "image",filename = fname}
			transition.scaleBy(event.target, { xScale=0.05, yScale=0.05, time=600})

			if (seleccionAnterior > -1) then
				transition.scaleBy(previousTarget, { xScale=-0.05, yScale=-0.05, time=300})
				previousTarget.fill = {170/255,51/255,249/255}
			end
			
			seleccionAnterior = clickedIndex
			previousName = clickedName
			previousTarget = event.target
			procesarDeNuevo = procesarDeNuevo + 1
		end

	end
	-- return true
end



function dibujarTarjeta()
	
	grupoDeTarjetas = display.newGroup()
	 
	local shapes = {1,1,2,2,3,3,4,4,5,5,6,6}
	
	seleccionAnterior = -1
	previousTarget = nil
	previousName = -1
	procesarDeNuevo = 0
	score = 0
	formas = 12

	for i=1,12 do
		local rect = display.newRect( tablaRecta[i]["x"], tablaRecta[i]["y"], rw, rh )
		rect:setFillColor(170/255,51/255,249/255)
		local shapesLen = table.getn(shapes)
		local randomIndex = math.random(1,shapesLen)
		local shape = shapes[randomIndex]
		table.remove(shapes, randomIndex)
		rect.selectedIndex = shape
		rect.name = i
		rect:addEventListener("touch", tarjetaDeEventos)
		grupoDeTarjetas:insert( i, rect)
	end
	
	local tText = display.newText( "Tiempo:", 30,-25,native.systemFontBold,15)
	tText:setFillColor(238/255,200/255,210/255)
	grupoDeTarjetas:insert(tText)
	textoDeTiempo = display.newText( "00", 80,-25,native.systemFontBold,15)
	textoDeTiempo:setFillColor(238/255,200/255,210/255)
	grupoDeTarjetas:insert(textoDeTiempo)
	timeKeeper = timer.performWithDelay( 1000, 
	function ()
		textoDeTiempo.text = textoDeTiempo.text + 1;
	end,0)

end

pantallaDeInicio()