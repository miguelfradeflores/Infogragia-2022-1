local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------
-- Functions
-- -----------------------------------------------------------------------------------
function dist_puntos(ax, ay, bx, by)
    -- body
    return math.sqrt(math.pow(ax-bx,2)+math.pow(ay-by,2))
end

function iniciarJuego( event )


	if( event.phase == "ended") then
		print( "Fase del ended", event.x, event.y )
		composer.gotoScene( "juegoNivel", {
            effect = "slideLeft",
            time =  2000,
            params = {
                nivel = 1,
                balasInicio  =3,
                balasFinal = 3,
                puntaje = 0,
                tiempo = 33,
                escenario = "fondo1.jpg"
            } 
        })
	end
	return true
end


function crearBoton()

    botonInicio = display.newImageRect( "start.jpg", 150, 100 )
    botonInicio.x = cw/2;   botonInicio.y =(ch/2)+200
    botonInicio:addEventListener( "touch", iniciarJuego )

end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    fondoM = display.newImageRect( "menu.jpg", cw, ch )
    fondoM.x = 0;	fondoM.y = 0
	fondoM.anchorX = 0;	fondoM.anchorY = 0

	inicio = display.newText("Inicio", cw/2, ch/2-100, "arial", 50)



    crearBoton()
end

 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

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
        fondoM.isVisible = false
        botonInicio.isVisible = false
        inicio.isVisible = false
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