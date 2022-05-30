local composer = require( "composer" )
local scene = composer.newScene()

cw = display.contentWidth
ch = display.contentHeight

local velPajaro 
local punt
local numeroInt

local intro
local puntaje
local next
local myOutroSound
local soundTable = {
 
    nextRound = audio.loadSound( "assets/next-round.mp3" )
}
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
function irCentral()
    local options = {
        effect = "fade",
        time = 500,
        params = {
            velocidadPajaro = velPajaro -1,
            numInt = numeroInt-1,
        }
    }
    composer.gotoScene( "central", options ) 
end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
    composer.removeScene( "central" )
    composer.removeScene( "gemeIntro" )
    print("en el outro")
    myOutroSound = audio.play( soundTable["nextRound"] )
    local sceneGroup = self.view
    local params = event.params
    velPajaro = params.velocidadPajaro
    numeroInt = params.numInt
    punt = params.puntaje
    intro = display.newImageRect("assets/intro.png", cw, ch)
    intro.anchorX = 0
    intro.anchorY = 0
    sceneGroup:insert( intro)
    puntaje = display.newText("PUNTAJE DEL JUEGO: "..punt, 0.1*cw, 0.05*ch, "assets/pixel.otf", 30 )
    puntaje.anchorX = 0
    puntaje.anchorY = 0
    sceneGroup:insert(puntaje)
    next = display.newImageRect("assets/next.png", 130, 50)
    next.anchorX = 0
    next.anchorY = 0
    next.x = cw/2 - 65
    next.y = ch*0.88
    next.touch = irCentral
    next:addEventListener("touch", next)
    sceneGroup:insert(next)
 
end
 
 
-- show()
function scene:show( event )
end
 
 
-- hide()
function scene:hide( event )
end
 
 
-- destroy()
function scene:destroy( event )
    transition.cancelAll()
    display.remove( intro )
    display.remove( puntaje)
    display.remove( next)
    audio.stop( myOutroSound )
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