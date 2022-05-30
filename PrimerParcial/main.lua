local composer = require( "composer" )

-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

cw  = display.contentWidth
ch = display.contentHeight
display.setDefault( "background", 0,0,0,0)
display.setStatusBar(display.HiddenStatusBar)

--Alto y ancho de cada rectangulo de cada nivel 

rectHeightL3 = 100
rectWidthL3 = 90

rectHeightL2 = 100
rectWidthL2 = 155

rectHeightL1 = 100
rectWidthL1 = 100

--Tablas que almacenan x,y de cada rectangulo para cada nivel
rectTable3 = {}
local index = 1
for i=1,4 do
	for j=1,3 do
		rectTable3[index]={}
		rectTable3[index]["x"]=rectWidthL3/2+(j-1)*(rectWidthL3+15)
		rectTable3[index]["y"]=rectHeightL3/2+(i-1)*(rectHeightL3+7)
		index = index+1
	end
end

rectTable2 = {}
local index = 1
for i=1,4 do
	for j=1,2 do
		rectTable2[index]={}
		rectTable2[index]["x"]=rectWidthL2/2+(j-1)*(rectWidthL2+15)
		rectTable2[index]["y"]=rectHeightL2/2+(i-1)*(rectHeightL2+7)
		index = index+1
	end
end

rectTable1 = {}
local index = 1
for i=1,2 do
	for j=1,3 do
		rectTable1[index]={}
		rectTable1[index]["x"]=rectWidthL1/2+(j-1)*(rectWidthL1+15)
		rectTable1[index]["y"]=rectHeightL1/2+(i-1)*(rectHeightL1+7)
		index = index+1
	end
end

--Creando la pantalla de inicio
--Consiste en el nombre del juego y un boton para empezar a jugar
function homeScreen()
	local buttonStart = display.newRect(cw/2, ch/2, 120,50,10)
	buttonStart:setFillColor(250/255,138/255,26/255)
	buttonStart:addEventListener("tap", selectLevel )

	local textStart = display.newText("Start", cw/2, ch/2, native.systemFontBold, 25)

	local textGame = display.newText("Juego de \nMemoria", cw/2, ch/2-150, native.systemFontBold, 40 )
	textGame:setFillColor(250/255,138/255,26/255)

	local textName = display.newText("Mauricio Angulo\n51944", cw/2, ch/2+150, native.systemFontBold, 20 )
	textName:setFillColor(250/255,138/255,26/255)

	--Grupo para los objetos creados
	homeGroup = display.newGroup()
	homeGroup:insert(1,buttonStart)
	homeGroup:insert(2,textStart)
	homeGroup:insert(3,textGame)
	homeGroup:insert(4,textName)
end

--Pantalla para elegir entre los 3 distintos niveles
function selectLevel()
	homeGroup.isVisible = false
	local buttonFL = display.newRect(cw/2, ch/2-150, 200,100,10)
	buttonFL:setFillColor(250/255,138/255,26/255)
	buttonFL:addEventListener("tap", firstLevel)
	local textFL = display.newText("Primer Nivel", cw/2,ch/2-150, native.systemFontBold, 25)

	local buttonSL = display.newRect(cw/2, ch/2, 200,100,10)
	buttonSL:setFillColor(250/255,138/255,26/255)
	buttonSL:addEventListener("tap",secondLevel)
	local textSL = display.newText("Segundo Nivel", cw/2,ch/2, native.systemFontBold, 25)

	local buttonTL = display.newRect(cw/2, ch/2+150, 200,100,10)
	buttonTL:setFillColor(250/255,138/255,26/255)
	buttonTL:addEventListener("tap",thirdLevel)
	local textTL = display.newText("Tercer Nivel", cw/2,ch/2+150, native.systemFontBold, 25)

	--Grupo para los objetos creados
	levelGroup = display.newGroup()
	levelGroup:insert(1,buttonFL)
	levelGroup:insert(2,textFL)
	levelGroup:insert(3,buttonSL)
	levelGroup:insert(4,textSL)
	levelGroup:insert(5,buttonTL)
	levelGroup:insert(6,textTL)

end
--homeScreen()

function firstLevel()
	--Oculta los otros grupos
	homeGroup.isVisible = false
	levelGroup.isVisible = false
	local buttonP = display.newRect(cw-60, ch-20, 100,50,10)
	buttonP:setFillColor(250/255,138/255,26/255)
	buttonP:addEventListener("touch", buttonP )
	local textPause = display.newText("Pausa", cw-60,ch-20, native.systemFontBold, 25)
	local buttonBTM = display.newRect(80, ch-20, 100,50,10)
	buttonBTM:setFillColor(250/255,138/255,26/255)
	buttonBTM:addEventListener("touch", buttonBTM )
	local textBTM = display.newText("Volver al \nmenu", 80,ch-20, native.systemFontBold, 20)


	buttonGroup = display.newGroup()
	buttonGroup:insert(1,buttonP)
	buttonGroup:insert(2,textPause)
	buttonGroup:insert(3,buttonBTM)
	buttonGroup:insert(4,textBTM)

	drawCardsL1()
	--Funcion para poner en pausa y reanudar el juego
	function reanudar()
		transition.resume("firstLevel")
	end

	function buttonP:touch(e)
		if e.phase == "ended" then
			if cardGroup.isVisible then
				cardGroup.isVisible = false
				transition.pause("firstLevel")
			else
				cardGroup.isVisible = true
				transition.to(cardGroup, {time=1000, onComplete=reanudar})
			end
		end
	end

	function buttonBTM:touch(e)
		if e.phase == "ended" then
			cardGroup:removeSelf()
			levelGroup:removeSelf()
			buttonGroup:removeSelf()
			selectLevel()
		end
	end
	return true
end

function secondLevel()
	--Oculta los otros grupos
	homeGroup.isVisible = false
	levelGroup.isVisible = false
	local buttonP = display.newRect(cw-65, ch-20, 100,50,10)
	buttonP:setFillColor(250/255,138/255,26/255)
	buttonP:addEventListener("touch", buttonP )
	local textPause = display.newText("Pausa", cw-65,ch-20, native.systemFontBold, 25)
	local buttonBTM = display.newRect(80, ch-20, 100,50,10)
	buttonBTM:setFillColor(250/255,138/255,26/255)
	buttonBTM:addEventListener("touch", buttonBTM )
	local textBTM = display.newText("Volver al \nmenu", 80,ch-20, native.systemFontBold, 20)

	buttonGroup = display.newGroup()
	buttonGroup:insert(1,buttonP)
	buttonGroup:insert(2,textPause)
	buttonGroup:insert(3,buttonBTM)
	buttonGroup:insert(4,textBTM)


	drawCardsL2()
	--Funcion para poner en pausa y reanudar el juego
	function reanudar()
		transition.resume("firstLevel")
	end

	function buttonP:touch(e)
		if e.phase == "ended" then
			if cardGroup.isVisible then
				cardGroup.isVisible = false
				transition.pause("firstLevel")
			else
				cardGroup.isVisible = true
				transition.to(cardGroup, {time=1000, onComplete=reanudar})
			end
		end
	end

	function buttonBTM:touch(e)
		if e.phase == "ended" then
			cardGroup:removeSelf()
			levelGroup:removeSelf()
			buttonGroup:removeSelf()
			selectLevel()
		end
	end
	return true
end

function thirdLevel()
	--Oculta los otros grupos
	homeGroup.isVisible = false
	levelGroup.isVisible = false
	local buttonP = display.newRect(cw-65, ch-20, 100,50,10)
	buttonP:setFillColor(250/255,138/255,26/255)
	buttonP:addEventListener("touch", buttonP )
	local textPause = display.newText("Pausa", cw-65,ch-20, native.systemFontBold, 25)
	local buttonBTM = display.newRect(80, ch-20, 100,50,10)
	buttonBTM:setFillColor(250/255,138/255,26/255)
	buttonBTM:addEventListener("touch", buttonBTM )
	local textBTM = display.newText("Volver al \nmenu", 80,ch-20, native.systemFontBold, 20)

	buttonGroup = display.newGroup()
	buttonGroup:insert(1,buttonP)
	buttonGroup:insert(2,textPause)
	buttonGroup:insert(3,buttonBTM)
	buttonGroup:insert(4,textBTM)


	drawCardsL3()
	--Funcion para poner en pausa y reanudar el juego
	function reanudar()
		transition.resume("firstLevel")
	end

	function buttonP:touch(e)
		if e.phase == "ended" then
			if cardGroup.isVisible then
				cardGroup.isVisible = false
				transition.pause("firstLevel")
			else
				cardGroup.isVisible = true
				transition.to(cardGroup, {time=1000, onComplete=reanudar})
			end
		end
	end

	function buttonBTM:touch(e)
		if e.phase == "ended" then
			cardGroup:removeSelf()
			levelGroup:removeSelf()
			buttonGroup:removeSelf()
			selectLevel()
		end
	end
	return true
end

function displayScore(shapesLeft)
	--Esta funcion muestra el score despues de haber terminado el juego
	--Despues de mostrar el score durante 2 segundos vuelve a la pantalla de inicio
	if(shapesLeft==0) then
		cardGroup.isVisible = false
		buttonGroup.isVisible = false
		local message = "Felicidades!\n 	Ganaste! \n\n"
		local tText = display.newText(message, cw/2, ch/2, native.systemFontBold, 20)
		tText:setFillColor(250/255,138/255,26/255)
		local holdTime = timer.performWithDelay(2000,
			function()
				tText:removeSelf()
				homeGroup:removeSelf()
				levelGroup:removeSelf()
				buttonGroup:removeSelf()
				homeScreen()
			end,1)
	end
end


function cardEvent(event)
	if("began" == event.phase and shapesLeft > 0) then
		--Valor actual al que se le hace click
		local clickedIndex = event.target.selectedIndex
		--Valor del nombre de la carta seleccionada
		local clickedName = event.target.name
		local fname = clickedIndex..".jpg"	
		--Se verifica si la tarjeta anterior y la actual son diferentes
		--Si tienen la misma forma las hace desaparecer
		--Sino le asigna las propiedades actuales como anteriores
		if (clickedIndex == previousSelection and previousName ~= clickedName) then
			event.target.fill = { type = "image",filename = fname}
			local to_remove = previousTarget
			previousSelection = -1
			previousName = -1
			previousTarget = nil
			score = score + 1
			shapesLeft = shapesLeft - 2
			local pauseT = timer.performWithDelay(500,
			function ()
				event.target:removeSelf()
				to_remove:removeSelf()
				displayScore(shapesLeft)
			end,1)

		else 
			--Si se eligen cartas diferentes
			--Se llena la nueva carta con la imagen
			--Y la anterior carta vuelve a su tamano original
			event.target.fill = { type = "image",filename = fname}
			transition.scaleBy(event.target, { xScale=0.05, yScale=0.05, time=600})
			if (previousSelection > -1) then
				transition.scaleBy(previousTarget, { xScale=-0.05, yScale=-0.05, time=300})
				previousTarget.fill = {250/255,138/255,26/255}
			end
			--Se guarda el estado actual para el siguiente uso
			previousSelection = clickedIndex
			previousName = clickedName
			previousTarget = event.target
			retry = retry + 1
		end

	end
end

--Funcion para dibujar las cartas y asignarles una imagen random
--Misma funcion en todos los niveles
--Varia en la cantidad de rectangulos

function drawCardsL3()
	cardGroup = display.newGroup()
	local shapes = {1,1,2,2,3,3,4,4,5,5,6,6}
	--Variables del juego
	previousSelection = -1
	previousTarget = nil
	previousName = -1
	retry = 0
	score = 0
	shapesLeft = 12

	--Se dibujan los rectangulos y se le asignan imagenes de manera random

	for i=1,12 do
		local rect = display.newRect( rectTable3[i]["x"]+10, rectTable3[i]["y"], rectWidthL3, rectHeightL3 )
		rect:setFillColor(250/255,138/255,26/255)
		local shapesLen = table.getn(shapes)
		local randomIndex = math.random(1,shapesLen)
		local shape = shapes[randomIndex]
		table.remove(shapes, randomIndex)
		rect.selectedIndex = shape
		rect.name = i
		rect:addEventListener( "touch", cardEvent )
		cardGroup:insert( i, rect)
	end

end

function drawCardsL2()
	cardGroup = display.newGroup()
	local shapes = {1,1,2,2,3,3,4,4}
	--initialize variables for gameplay
	previousSelection = -1
	previousTarget = nil
	previousName = -1
	retry = 0
	score = 0
	shapesLeft = 8

	--Se dibujan los rectangulos y se le asignan imagenes de manera random

	for i=1,8 do
		local rect = display.newRect( rectTable2[i]["x"], rectTable2[i]["y"], rectWidthL3, rectHeightL3 )
		rect:setFillColor(250/255,138/255,26/255)
		local shapesLen = table.getn(shapes)
		local randomIndex = math.random(1,shapesLen)
		local shape = shapes[randomIndex]
		table.remove(shapes, randomIndex)
		rect.selectedIndex = shape
		rect.name = i
		rect:addEventListener( "touch", cardEvent )
		cardGroup:insert( i, rect)
	end

end

function drawCardsL1()
	cardGroup = display.newGroup()
	local shapes = {1,1,2,2,3,3}
	previousSelection = -1
	previousTarget = nil
	previousName = -1
	retry = 0
	score = 0
	shapesLeft = 6

	--Se dibujan los rectangulos y se le asignan imagenes randomicas

	for i=1,6 do
		local rect = display.newRect( rectTable1[i]["x"], rectTable1[i]["y"]+100, rectWidthL3, rectHeightL3 )
		rect:setFillColor(250/255,138/255,26/255)
		local shapesLen = table.getn(shapes)
		local randomIndex = math.random(1,shapesLen)
		local shape = shapes[randomIndex]
		table.remove(shapes, randomIndex)
		rect.selectedIndex = shape
		rect.name = i
		rect:addEventListener( "touch", cardEvent )
		cardGroup:insert( i, rect)
	end

end

homeScreen()







