


local composer = require("composer")
 
local scene = composer.newScene()

cw = display.contentWidth
ch = display.contentHeight

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


local grupo_background,  grupo_intermedio, grupo_delantero

local overlay_background



function irMenu(e)
    if e.phase == "ended" then
        local options = {
            effect = "fade",
            time = 200,
            params = {
                
            }
        }
        composer.gotoScene( "menu", options )

    end
    return
end
function irNiveles(e)
    if e.phase == "ended" then
       
        local options = {
            effect = "fade",
            time = 200,
            params = {
                
            }
        }
        composer.gotoScene( "levelsMenu", options )
    end
    return
end

function volverJuego(e)
    if e.phase == "ended" then
        composer.hideOverlay( "overlay-window", 200 )
    end
    return
end




function scene:create( event )
    local sceneGroup = self.view
    
	grupo_background = display.newGroup( )
    grupo_intermedio = display.newGroup( )
    grupo_delantero = display.newGroup( )
    -- grupo_overlay = display.newGroup( )

    sceneGroup:insert( grupo_background )
    sceneGroup:insert( grupo_intermedio )
    sceneGroup:insert( grupo_delantero )

    print("CREATE OVERLAY")

    overlay_background = display.newRect(grupo_background,0,0, cw, ch)  
    overlay_background.xScale = 1.2
    overlay_background.yScale = 1.2
	overlay_background.anchorX = 0
	overlay_background.anchorY = 0
    
    overlay_background:setFillColor( unpack(black))
    overlay_background.alpha = 0.8


   
    
end
 
 
-- show()
function scene:show( event )
    local sceneGroup = self.view
    if ( event.phase == "will" ) then
        print("SCENE SHOW WILL")

    elseif ( event.phase == "did" ) then
        print("SCENE SHOW DID")



            
        grupo_background = display.newGroup( )
        grupo_intermedio = display.newGroup( )
        grupo_delantero = display.newGroup( )
        
        -- grupo_overlay = display.newGroup( )

        sceneGroup:insert( grupo_background )
        sceneGroup:insert( grupo_intermedio )
        sceneGroup:insert( grupo_delantero )
        optionsG = {
            text = "COMPLETO \nEL NIVEL",
            x = cw/2,
            y = ch/2 - (ch/2 * 0.5),
            font = "fonts/OrganicRelief.ttf",
            fontSize = 90
        }


        print("Params:", event.params.winner)

        if (event.params.winner == true) then
        
            optionsG.text = "COMPLETO \nEL NIVEL"
            text = display.newText(optionsG)
            text:setFillColor(1,1,1)
            text:toFront()
            grupo_background:insert(text)
            
        else
            optionsG.text = "PUSO PAUSA"
            text = display.newText(optionsG)
            text:setFillColor(1,1,1)
            text:toFront()
            grupo_background:insert(text)


            
        end
        volver = display.newRoundedRect(grupo_delantero, cw/2, optionsG.y + ch*3/7 ,cw/2, ch/8,50)  
        volver:setFillColor( unpack(white))
        volver:addEventListener("touch",volverJuego)

        textB3 = display.newText(grupo_delantero,"Volver",cw/2 ,optionsG.y + ch*3/7,"arial",70 )
        textB3:setFillColor(unpack(black))
        
        menu = display.newRoundedRect(grupo_delantero, cw/2, optionsG.y + ch/7 ,cw/2, ch/8,50)  
        menu:setFillColor( unpack(white))
        menu:addEventListener("touch",irMenu)

        textB = display.newText(grupo_delantero,"Menu principal",cw/2 ,optionsG.y + ch/7,"arial",70 )
        textB:setFillColor(unpack(black))
        
        niveles = display.newRoundedRect(grupo_delantero, cw/2, optionsG.y + ch*2/7 ,cw/2, ch/8,50)  
        niveles:setFillColor( unpack(white))
        niveles:addEventListener("touch",irNiveles)

        textB2 = display.newText(grupo_delantero,"Ir a Niveles",cw/2 ,optionsG.y + ch*2/7,"arial",70 )
        textB2:setFillColor(unpack(black))
       
    end
    
    
 

   
end
 
 
-- hide()
function scene:hide( event )
 
   
end
 
 
-- destroy()
function scene:destroy( event )
 
    
 
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