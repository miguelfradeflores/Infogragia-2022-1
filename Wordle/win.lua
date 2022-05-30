local composer = require( "composer" )
local scene = composer.newScene()

cw = display.contentWidth
ch = display.contentHeight


function scene:create( event )
 
    local sceneGroup = self.view
    fondo = display.newRect(0,0,cw*2,ch*2)
    fondo:toFront()
    texto = display.newText( "GANASTE WORDLE!!", cw/2, ch/2, "arial", 35 )
    texto:setFillColor(0,0,0)

end

scene:addEventListener( "create", scene )
 
return scene