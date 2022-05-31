local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
local cw = display.contentWidth
local ch = display.contentHeight
 
 local myString = "YOU WIN"  -- Create your string
    local positionCount = 0     -- initialize a variable to determine letter position
    local space = 90
    local row = 1
    local finish = false
 local grupo_background, grupo_intermedio, grupo_delantero, puntaje
grupos = {grupo_background, grupo_intermedio, grupo_delantero}
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
function jugar(self, e)
    print( "INICIANDO METODO JUGAR" )

    if e.phase == "ended" then
        composer.removeScene( "win"  )
        composer.gotoScene( "menu", {
          effect =  "fade", 
          time = 2000
         } )

    end
    return true
end


local function displayData()
      positionCount = positionCount + 1
      if(positionCount<=string.len(myString))then
        local letter = string.sub(myString, positionCount, positionCount) -- get the current letter
        letterLabel = display.newText(letter,space+(positionCount*90),300+(space*row),"ARCADE_N.TTF",90) -- place the letter
        letterLabel.alpha = 0;
        transition.to(letterLabel,{time=100,alpha=1,onComplete=displayData})
        grupo_background:insert( letterLabel)
      
    else 
        --Al terminar el mensaje recien se despliega el boton de Play
        positionCount=0
        row = row + 1
        finish = true
        playB = display.newImageRect("playAgainB.png", cw, ch)
        playB.x = cw/2-60
        playB.y = 500
        playB.anchorX = 0
        playB.anchorY = 0
        playB:scale( 0.15, 0.15 )
        playB.touch = jugar
        playB.cantidad = 30
        playB:addEventListener( "touch", playB)
        --grupo_background:insert( letterLabel)
        grupo_background:insert( playB)
        
    end
end

function checkText()
    finish = true
 end  

-- function sleep (a) 
--     local sec = tonumber(os.clock() + a); 
--     while (os.clock() < sec) do 
--     end 
-- end

-- create()
function scene:create( event )
    local sceneGroup = self.view
    grupo_background = display.newGroup( )
    sceneGroup:insert( grupo_background)

    local sheetData1 = { width=169.3333, height=95.9556, numFrames=29, sheetContentWidth=850, sheetContentHeight=580 }
    local sheet1 = graphics.newImageSheet( "intron2.png", sheetData1)
    local sequenceData = {
                    name="seq1", sheet=sheet1, start=1, count=29, time=7000, loopCount=1 
                    }
     
    local myAnimation = display.newSprite( sheet1, sequenceData )
    myAnimation:scale( 7, 7)
    myAnimation.x = cw/2 ; myAnimation.y = ch/2
    myAnimation:play()
    grupo_background:insert(myAnimation )



     displayData()

    
     
    
-- function wait(seconds)
-- local start = os.time()
-- repeat until os.time() > start + seconds
-- end

    

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        -- title = display.newImage(sceneGroup, "titleF.png", cw/2, 630 )
        -- title:scale( 0.5, 0.5 )
 
        
 
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
          for i=grupo_background.numChildren, 1, -1 do
            grupo_background[i]:removeSelf( )
            grupo_background[i] = nil
        end  
        letterLabel = nil
        playB = nil

    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
    letterLabel = nil
        playB = nil
 
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