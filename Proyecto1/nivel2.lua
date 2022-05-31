local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
cw = display.contentWidth
ch = display.contentHeight

local grupo_background, grupo_intermedio, grupo_delantero
grupos = {grupo_background, grupo_intermedio, grupo_delantero}
local puntos = 0
 

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
	return true
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
 
function atras(e)
    if e.phase == "ended" then
        composer.gotoScene( "menu", "slideRight", 2000 )

    end
    return
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
 
	grupo_background = display.newGroup( )
	grupo_intermedio = display.newGroup( )
	grupo_delantero = display.newGroup()

	sceneGroup:insert( grupo_intermedio)
	sceneGroup:insert( 1, grupo_background )
	sceneGroup:insert( grupo_delantero )

	fondo = display.newImageRect("1.jpg", cw, ch)
	fondo.x = 0;
	fondo.y = 0
	fondo.anchorX = 0
	fondo.anchorY = 0

	fondo:addEventListener( "touch", atras )


	puntaje = display.newText(  grupo_delantero,  "SCORE: " .. puntos, 70,50, "arial", 30)
	puntaje.anchorY = 0; puntaje.anchorX =0.5

	grupo_background:insert( fondo )



end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 		crearManzanas(20, 50,50)
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

        for i=grupo_intermedio.numChildren, 1, -1 do
        	grupo_intermedio[i]:removeSelf( )
        	grupo_intermedio[i] = nil
        end

 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene