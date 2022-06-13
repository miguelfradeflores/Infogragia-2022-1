-----------------------------------------------------------------------------------------
--
-- title.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local cw = display.contentWidth
local ch = display.contentHeight
--------------------------------------------

-- forward declaration
local background

-- Touch listener function for background object
local function onBackgroundTouch( self, event )
	if event.phase == "ended" or event.phase == "cancelled" then
		-- go to page1.lua scene
		composer.gotoScene( "page1", "slideLeft", 800 )
		
		return true	-- indicates successful touch
	end
end

function mover(self,event)
	if(event.phase == "ended") then
		_G.posicion = _G.posicion -1
		composer.gotoScene( "page1", "slideRight", 800 )
	end
	return true
end
function volver( event )
	composer.gotoScene("title","slideRight",800)
	posicion = 1
end
function scene:create( event )
	local sceneGroup = self.view
	grupo_background = display.newGroup()
	grupo_intermedio = display.newGroup()
	grupo_delantero = display.newGroup()

	sceneGroup:insert(grupo_background)
	sceneGroup:insert(grupo_intermedio)
	sceneGroup:insert(grupo_delantero)

	-- display a background image
	background = display.newImageRect( grupo_background, "back.jpg", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0
	
	local fondo_botones = display.newRect(grupo_delantero, cw/2, ch, cw,100)
	fondo_botones.anchorY = 1
	fondo_botones:setFillColor(0.5,0.5,0.5,0.45)

	boton_atras = display.newImageRect(grupo_delantero, "next.png", 130,130)
	boton_atras.x = 100; boton_atras.y = ch-50 
	boton_atras.rotation = 180
	boton_atras.direccion = -1

	boton_inicio = display.newImageRect(grupo_delantero, "home.png", 80,80)
	boton_inicio.x = cw/2; boton_inicio.y = ch-50

	boton_atras.touch = mover
	boton_inicio.touch = volver

	boton_atras:addEventListener("touch", boton_atras)
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