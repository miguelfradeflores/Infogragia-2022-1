local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
-- cw = display.contentWidth
-- ch = display.contentHeight
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
function jugar(self, e)
    print( "INICIANDO METODO JUGAR" )

    if e.phase == "ended" then
        composer.removeScene( "menu"  )
        composer.gotoScene( "juego", {
          effect =  "slideLeft", 
          time = 2000, 
          params = {
            cantidad_de_manzanas = self.cantidad
            }
         } )

    end
    return true
end

-- function ir_nivel2(e)
--     if e.phase == "ended" then
--         composer.removeScene( "juego"  )
--         composer.gotoScene( "nivel2", {
--           effect =  "slideLeft", 
--           time = 2000, 
--           params = {
--             cantidad_de_manzanas = 30
--             }
--          } )
--     end
--     return true
-- end

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    fondo = display.newRect( sceneGroup, cw/2, ch/2, cw, ch )
    fondo:setFillColor( 0.42 )
    fondo.touch = jugar
    fondo.cantidad = 10
    fondo:addEventListener( "touch", fondo )

    manzana = display.newImage(sceneGroup, "f1.png", math.random( 0,cw ), math.random(0,ch) )

    boton_nivel2 = display.newImageRect(sceneGroup, "play.png", 150,150)
    boton_nivel2.x = cw/2; boton_nivel2.y  = ch/2
    boton_nivel2.touch = jugar
    boton_nivel2.cantidad = 30

    boton_nivel2:addEventListener( "touch", boton_nivel2 )

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
        manzana = display.newImage(sceneGroup, "f1.png", math.random( 0,cw ), math.random(0,ch) )
        manzana.xScale = 0.5; manzana.yScale = 0.5
 
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