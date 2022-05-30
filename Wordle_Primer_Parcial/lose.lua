local composer = require( "composer" )
local scene = composer.newScene()

local grupo_background, grupo_intermedio, grupo_delantero, puntaje
grupos = {grupo_background, grupo_intermedio, grupo_delantero}
local puntos = 0

cw = display.contentWidth
ch = display.contentHeight


function scene:create( event )
 
    local sceneGroup = self.view

    grupo_background = display.newGroup( )
	grupo_intermedio = display.newGroup( )
	grupo_delantero = display.newGroup()

    sceneGroup:insert( grupo_intermedio)
	sceneGroup:insert( 1, grupo_background )
	sceneGroup:insert( grupo_delantero )

    --fondo = display.newRect(0,0,cw*2,ch*2)
    --fondo:toFront()
    fondoAlt = display.newImageRect("/imagenes/gato-triste.jpg", cw, ch)
    fondoAlt.anchorX = 0; fondoAlt.anchorY = 0
    fondoAlt:toFront()

    fondoAlt:addEventListener( "touch", atras )

    texto = display.newText( "PERDISTE!!", cw/2, ch/2, "arial", 35 )
    texto:setFillColor(0,0,0)

    grupo_background:insert( fondoAlt )
    grupo_intermedio:insert( texto )
end

function atras(e)
    if e.phase == "ended" then
        composer.removeScene( "lose")
        composer.gotoScene( "juego", {"slideRight", 
        time = 2000,
        params = {}
         } )
    end
    return
end

scene:addEventListener( "create", scene )
 
return scene