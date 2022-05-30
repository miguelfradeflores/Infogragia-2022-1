local composer = require( "composer" )
local scene = composer.newScene()

cw = display.contentWidth
ch = display.contentHeight
local myIntroSound
local soundTable = {
 
    start = audio.loadSound( "assets/start.mp3" )
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
            velocidadPajaro = 20,
            numInt = 10,
        }
    }
    composer.gotoScene( "central", options ) 
end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )

    local sceneGroup = self.view
    myIntroSound = audio.play( soundTable["start"] )
    print("en el intro")
    local intro = display.newImageRect("assets/intro.png", cw, ch)
    intro.anchorX = 0
    intro.anchorY = 0
    sceneGroup:insert( intro)
    local start = display.newImageRect("assets/start.png", 130, 50)
    start.anchorX = 0
    start.anchorY = 0
    start.x = cw/2 - 65
    start.y = ch*0.88
    start.touch = irCentral
    start:addEventListener("touch", start)
    sceneGroup:insert(start)
 
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
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    audio.stop( myIntroSound )
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