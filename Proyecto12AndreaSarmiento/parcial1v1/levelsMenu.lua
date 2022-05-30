

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

local fondo

local granArregloPalabras = {
    {{"alma",1,1,4,1,0},
    {"llama",2,1,1,5,0},
    {"mala",1,3,4,1,0},
    {"malla",1,5,5,1,0}}
    
    ,
    {{"alma",1,1,4,1,0},
    {"llama",2,1,1,5,0},
    {"mala",1,3,4,1,0}},

    {{"gama",1,3,4,1,0},
    {"maga", 1,1,1,4,0},
    {"ama" , 4,3,1,3,0},
    {"mama", 3,5,4,1,0}},

    
    
}
    
function irMenu(e)
    if e.phase == "ended" then
       
        composer.gotoScene( "menu" )

    end
    return
end


function irNivel(self,e)
    if e.phase == "ended" then
        local options = {
            effect = "crossFade",
            time = 500,
            params = {
                arregloPalabras = granArregloPalabras[self.indice]
            }
        }
       
        composer.removeScene("level", true )
        composer.gotoScene( "level", options )

    end
    return true
end



local boxes = {}
local texts = {}

function drawLetterBox(y,text,indice)
    boxes[indice] = display.newRoundedRect(grupo_delantero, cw/2, y ,cw/2, ch/8,50)  
    boxes[indice]:setFillColor( unpack(black))
    boxes[indice].indice = indice
    boxes[indice].touch = irNivel;
    boxes[indice]:addEventListener("touch",boxes[indice])
   

    texts[indice] = display.newText(grupo_delantero,text,cw/2 ,y,"arial",70 )
    texts[indice]:setFillColor(unpack(white))
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

    fondo = display.newImageRect(grupo_background,"images/fondo.jpg" , cw, ch)
    -- fondo.fill = {  type = "image",  filename = "images/fondo.jpg" }  
    
	fondo.anchorX = 0
	fondo.anchorY = 0
    
    fondo:setFillColor( unpack(white))

    backB = display.newImage(grupo_delantero, "images/back.png", 10, 10 )
    backB.xScale = 0.4  backB.yScale = 0.4
    backB.anchorX = 0;   backB.anchorY =0 
    backB:addEventListener( "touch", irMenu )

  
    local optionsG = {
        text = "NIVELES",
        x = cw/2,
        y = ch/2 - (ch/2 * 0.5),
        font = "fonts/OrganicRelief.ttf",
        fontSize = 90
    }
    text = display.newText(optionsG)
    text:setFillColor(unpack(black))
    text:toFront()
    grupo_background:insert(text)
    

   
    for i = 1,3 do
        drawLetterBox(optionsG.y + ch*(i)/7,"Nivel"..i, i)
    end
    
end
 
 

-- show()
function scene:show( event )
 
    local sceneGroup = self.view

    if ( event.phase == "will" ) then   

    elseif ( event.phase == "did" ) then
        
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