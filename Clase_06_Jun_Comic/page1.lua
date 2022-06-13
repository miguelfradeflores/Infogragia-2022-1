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
local final = 9
local puede_seguir = true


-- forward declarations and other locals
local background, boton_adelante, boton_atras, boton_inicio
local grupo_background, grupo_intermedio, grupo_delantero
-- function to show next animation

-- touch event listener for background object

local arreglo_posiciones = {
	{x=0,y=0,xScale=1,yScale=1,time=2000},
	{x=-paddingX*21.5,y=-paddingY*2,xScale=1/4*12,yScale=1/5*16,time=2000},
	{x=-paddingX*21.5,y=-paddingY*20,xScale=1/4*12,yScale=1/5*16,time=4000},
	{x=-paddingX*2.5,y=-paddingY*2,xScale=1/6*12,yScale=1/5.5*16,time=2000},
	{x=-paddingX*15.7,y=-paddingY*21,xScale=1/3*12,yScale=1/4*16,time=2000},
	{x=-paddingX*4.5,y=-paddingY*21,xScale=1/3*12,yScale=1/4*16,time=1000},
	{x=-paddingX*4.5,y=-paddingY*34,xScale=1/5.2*12,yScale=1/4*16,time=2000},
	{x=0,y=0,xScale=1,yScale=1,time=2000}
}
_G.posicion = 1

function mover(self,event)
	if(event.phase == "ended" and puede_seguir) then
		posicion = posicion + self.direccion
		-- print(posicion)

		if posicion>=inicio and posicion<final then
			print("transition al siguiente cuadro ", posicion )
			puede_seguir = false
			transition.to(grupo_background, {
				x= arreglo_posiciones[posicion].x,
				y= arreglo_posiciones[posicion].y,
				xScale=arreglo_posiciones[posicion].xScale,
				yScale=arreglo_posiciones[posicion].yScale,
				time=arreglo_posiciones[posicion].time,
				onComplete=(function() puede_seguir = true end)
			})
		elseif posicion==final then
			composer.gotoScene( "back", "slideLeft", 800 )
		end
	end
	return true
end
function volver( event )
	composer.gotoScene("title","slideRight",800)
	posicion = 1
	transition.to(grupo_background, {
			x= arreglo_posiciones[posicion].x,
			y= arreglo_posiciones[posicion].y,
			xScale=arreglo_posiciones[posicion].xScale,
			yScale=arreglo_posiciones[posicion].yScale,
			time=20
		})
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
	background = display.newImageRect( grupo_background, "030.jpg", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0

	
	
	local fondo_botones = display.newRect(grupo_delantero, cw/2, ch, cw,100)
	fondo_botones.anchorY = 1
	fondo_botones:setFillColor(0.5,0.5,0.5,0.45)

	boton_adelante = display.newImageRect(grupo_delantero, "next.png", 130,130)
	boton_adelante.x = cw - 100; boton_adelante.y = ch-50 
	boton_adelante.direccion = 1

	boton_inicio = display.newImageRect(grupo_delantero, "home.png", 80,80)
	boton_inicio.x = cw/2; boton_inicio.y = ch-50

	boton_atras = display.newImageRect(grupo_delantero, "next.png", 130,130)
	boton_atras.x = 100; boton_atras.y = ch-50 
	boton_atras.rotation = 180
	boton_atras.direccion = -1

	boton_adelante.touch = mover
	boton_atras.touch = mover
	boton_inicio.touch = volver

	boton_atras:addEventListener("touch", boton_atras)
	boton_adelante:addEventListener("touch", boton_adelante)
	boton_inicio:addEventListener("touch", boton_inicio)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
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
