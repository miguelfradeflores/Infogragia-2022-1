




local composer = require("composer")
 
local scene = composer.newScene()

local grupo_background, grupo_intermedio , group_delantero


black = {0,0,0}
white = {1,1,1}
silver = {192/255,192/255,192/255}
coral = {255/255,127/255,80/255}
metallicGold = {212/255,175/255,55/255}

dimgray = {105/255,105/255,105/255}


gray = {153/255, 153/255, 153/255}
green = {107/255, 142/255, 45/255}
red = {205/255, 92/255, 92/255}
blue = {51/255, 102/255, 153/255}

cw = display.contentWidth
ch = display.contentHeight


local music = audio.loadSound( "music/inHeat.mp3" )

     optionsL = {
        effect = "crossFade",
        time = 1500,
        params = {
            arregloPalabras = {
                {"alma",1,1,4,1,0},
                {"llama",2,1,1,5,0},
                {"mala",1,3,4,1,0},
                {"malla",1,5,5,1,0}
                
            }
        }
    }


function jugar(e)

    if e.phase == "ended" then
        -- composer.gotoScene( "level", optionsL)
        composer.gotoScene( "levelsMenu", optionsL)
    end
    return
end





function scene:create( event )
 
    local sceneGroup = self.view
    -- audio.play(music);
    -- audio.setVolume(0.4,{channel =1 , loops = -1});

    grupo_background = display.newGroup( )
    grupo_intermedio = display.newGroup( )
    grupo_delantero = display.newGroup( )

    sceneGroup:insert( grupo_background )
    sceneGroup:insert( grupo_intermedio )
    sceneGroup:insert( grupo_delantero )


	-- fondo = display.newImageRect(sceneGroup, "images/mountainsv2.jpg", cw, ch)
    fondo = display.newRect( 0,0,cw, ch)  
    fondo.xScale = 1.2
    fondo.yScale = 1.2
	fondo.anchorX = 0
	fondo.anchorY = 0
    fondo:setFillColor( unpack(dimgray))
   
	grupo_background:insert( fondo )

    fondo = display.newRoundedRect(0+ cw/25,0 + ch/25,cw - (cw*2/25), ch-(ch*2/25),50)  
	fondo.anchorX = 0
	fondo.anchorY = 0
    fondo:setFillColor( unpack(gray))
   
	grupo_background:insert( fondo )

    fondo = display.newRoundedRect(0+ cw*2/25,0 + ch*2/25,cw - (cw*4/25), ch-(ch*4/25),50)  
	fondo.anchorX = 0
	fondo.anchorY = 0
    fondo:setFillColor( unpack(white))
   
	grupo_background:insert( fondo )


    playB = display.newImage(sceneGroup, "images/play2v2.png", cw/2, ch/2 + (ch/2 *0.1) )
    playB.xScale = 1.5 playB.yScale = 1.5
    playB:addEventListener( "touch", jugar )

    grupo_delantero:insert(playB)



    options = {
        text = "WELCOME TO",
        x = cw/2,
        y = ch/2 - (ch/2 * 0.5),
        font = "fonts/OrganicRelief.ttf",
        fontSize = 90
    }
   

   
    text = display.newText(options)
    text:setFillColor(0,0,0)
    text:toFront()
    grupo_background:insert(text)

    options.text = "ELECTRICWORD"
    options.fontSize = 80
    text = display.newText(options)
    text:setFillColor(0,0,0)
    text.y = ch/2 - (ch/2 * 0.3),
    
    grupo_background:insert(text)





end


-- show()
function scene:show( event )
 
    -- local sceneGroup = self.view
    -- local phase = event.phase
 
    -- if ( phase == "will" ) then
    --     -- Code here runs when the scene is still off screen (but is about to come on screen)

    -- elseif ( phase == "did" ) then
    --     -- Code here runs when the scene is entirely on screen
 
    --     manzana = display.newImage(sceneGroup, "f1.png", math.random( 0,cw ), math.random(0,ch) )
    --     manzana.xScale = 0.5; manzana.yScale = 0.5
 
    -- end
end
 
 
-- hide()
function scene:hide( event )
 
    -- local sceneGroup = self.view
    -- local phase = event.phase
 
    -- if ( phase == "will" ) then
    --     -- Code here runs when the scene is on screen (but is about to go off screen)
 
    -- elseif ( phase == "did" ) then
    --     -- Code here runs immediately after the scene goes entirely off screen
 
    -- end
end
 
 
-- destroy()
function scene:destroy( event )
 
    -- local sceneGroup = self.view
    -- -- Code here runs prior to the removal of scene's view
 
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