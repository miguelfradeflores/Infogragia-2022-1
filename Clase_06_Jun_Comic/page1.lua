-----------------------------------------------------------------------------------------
--
-- page1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local cw = display.contentWidth
local ch = display.contentHeight
local paddingX = cw/12
local paddingY = ch/12

local inicio = 1
local final = 6



-- forward declarations and other locals
local background, boton_adelante, boton_atras
local grupo_background, grupo_intermedio, grupo_delantero
-- function to show next animation

-- touch event listener for background object

local arreglo_posiciones = {
	{x=0,y=0,xScale=1,yScale=1},
	{x=0,y=0,xScale=1/5*12,yScale=1/6*16},
	{x=-paddingX*6,y=0,xScale=1/7*12,yScale=1/7*16},
	{x=-paddingX*7,y=-paddingY*7,xScale=1/6*12,yScale=1/8*16},
	{x=0,y=0,xScale=1,yScale=1}
}
local posicion = 1

function mover(self,event)
	if(event.phase == "ended") then
		posicion = posicion + self.direccion
		print(self.direccion)

		if posicion>inicio and posicion<final then
			print("transition al siguiente cuadro ", posicion )
			transition.to(grupo_background, {
				x= arreglo_posiciones[posicion].x,
				y= arreglo_posiciones[posicion].y,
				xScale=arreglo_posiciones[posicion].xScale,
				yScale=arreglo_posiciones[posicion].yScale,
				time=2000
			})
		end
	end
	return true
end


function scene:create( event )
	local sceneGroup = self.view
	grupo_background = display.newGroup()
	grupo_intermedio = display.newGroup()
	grupo_delantero = display.newGroup()

	sceneGroup:insert(grupo_background)
	sceneGroup:insert(grupo_intermedio)
	sceneGroup:insert(grupo_delantero)

	grupo_intermedio.alpha = 0.5
	-- Called when the scene's view does not exist.å
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
	-- create background image
	background = display.newImageRect( grupo_background, "batman5.jpg", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0

	for i=0, 11 do
		local LineaVertical = display.newLine(grupo_intermedio, paddingX*i, 0, paddingX*i, ch )
		LineaVertical.strokeWidth = 4
		LineaVertical:setStrokeColor( 1 )
	end
	
	for i=0, 16 do
		local LineaHorizontal = display.newLine(grupo_intermedio, 0, paddingY*i, cw, paddingY*i)
		LineaHorizontal.strokeWidth = 4
		LineaHorizontal:setStrokeColor( 1 )
	end
	
	local fondo_botones = display.newRect(grupo_delantero, cw/2, ch, cw,180)
	fondo_botones.anchorY = 1
	fondo_botones:setFillColor(0)

	boton_adelante = display.newImageRect(grupo_delantero, "next.png", 130,130)
	boton_adelante.x = cw - 100; boton_adelante.y = ch-100 
	boton_adelante.direccion = 1

	boton_atras = display.newImageRect(grupo_delantero, "next.png", 130,130)
	boton_atras.x = 100; boton_atras.y = ch-100 
	boton_atras.rotation = 180
	boton_atras.direccion = -1

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		
		boton_adelante.touch = mover
		boton_atras.touch = mover

		boton_atras:addEventListener("touch", boton_atras)
		boton_adelante:addEventListener("touch", boton_adelante)

	end	

end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		

	elseif phase == "did" then
		-- Called when the scene is now off screen
	end		

end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
