

local composer = require("composer")
 
local scene = composer.newScene()

local grupo_background,  grupo_intermedio, grupo_delantero

local grupoRedondo, grupoCrucigrama 

-- local grupo_overlay

cw = display.contentWidth
ch = display.contentHeight


black = {0,0,0}
white = {1,1,1}
silver = {192/255,192/255,192/255}


gray = {153/255, 153/255, 153/255}
green = {107/255, 142/255, 45/255}
red = {205/255, 92/255, 92/255}
blue = {51/255, 102/255, 153/255}


local overlayOptions = {
    isModal = true,
    effect = "fade",
    time = 400,
    params = {
        winner = true
    }
}


-- palabra , posx, posy, lx, ly
local arregloPalabras = {
{"alma",1,1,4,1,0},
{"llama",2,1,1,5,0},
{"mala",1,3,4,1,0},
{"malla",1,5,5,1,0}

}


local arregloLetras = {}

local circles = {}

local squares = {}

local options = {
    text = "h",
    x = display.contentCenterX,
    y = display.contentCenterY,
    font = "arial",
    fontSize = 200
}

local optionsArmado = {
    text = "",
    x = display.contentCenterX,
    y = display.contentCenterY,
    font = "arial",
    fontSize = 200
}

--Lines
local startedChoosing = false
local cordinatesLine = {}
local indicefijo = 0 
local selectedLetters ={}
--

local awx = 0
local ahc = 0

local winner
--WORD GENERAL FUNCTIONS

function getLetters( arreglo)

    for index, value in ipairs(arreglo) do
        print(value[1]);
        local t={}
        value[1]:gsub(".",function(c) table.insert(t,c) end);
        
        arrAux = getArregloLetras(t)

        print("ARRAUX:", unpack(arrAux))
        for j=1,#arrAux,2 do
            local indexes = getIndex(arregloLetras,arrAux[j]);
            if (next(indexes) == nil) then
                table.insert(arregloLetras , arrAux[j]);
                table.insert(arregloLetras ,arrAux[j+1]);
            else
                if arregloLetras[indexes[1]+1] < arrAux[j+1] then
                    arregloLetras[indexes[1]+1] = arrAux[j+1] 
                end
                
            end
        end
    end
    print("--------------------------")
    print("ARREGLO LETRAS:",unpack(arregloLetras))
    print("--------------------------")

    local expandedArray = {}
    for i=1, #arregloLetras, 2 do
        for j=1,arregloLetras[i+1] do
            table.insert(expandedArray, arregloLetras[i])
        end
    end
    arregloLetras = expandedArray;
    print("NEW ARREGLO LETRAS:",unpack(arregloLetras))

end

function getArregloLetras(cadena)
    
    local arrayAux = {}
    for index, value in ipairs(cadena) do
        local c = value;
        local indexes = getIndex(arrayAux,c);
        if (next(indexes) == nil) then
            table.insert(arrayAux , c);
            table.insert(arrayAux , 1);
        else
            arrayAux[indexes[1]+1] = arrayAux[indexes[1]+1] +1
        end
    end
    return arrayAux

end

function getIndex(str, elem)
    local aux = {}
    for index, value in ipairs(str) do
        --print("inside for")
        if value == elem then
            --print("inside if")
            table.insert(aux,index)
        end
    end
    return aux
end


--SQUARE FUNCTIONS
function createSquare(x,y, awc, ahc, indice ,word, letter)
 
    local posx = awc*x
    local  posy = ahc*y
    
    squares[indice] = display.newRoundedRect(grupoCrucigrama,posx, posy, awc*1, ahc*1,40)
    squares[indice]:setFillColor( unpack(white) )
    squares[indice]:setStrokeColor(0,0,0)
    squares[indice].strokeWidth = 10
    squares[indice].letter = letter
    squares[indice].word = {word}
    squares[indice].anchorX = 0; squares[indice].anchorY=0;
    

end


--PUZZLE FUNCTIONS
function getGridDimensions(arrrayWords)
        x = -1
        y = -1
    
        -- Get max x
        xtable = {}
        for index, value in ipairs(arrrayWords) do
            auxVal = (value[2] + value[4])-1 
            table.insert(xtable,auxVal)
        end
        x = math.max(unpack(xtable))

        
        ytable = {}
        for index, value in ipairs(arrrayWords) do
            auxVal = (value[3] + value[5])-1 
            table.insert(ytable,auxVal)
        end
        y = math.max(unpack(ytable))

        return {x+2,y+2}
       
end


function createGrid(largo)
    gridD = getGridDimensions(arregloPalabras);
    print("Dimension x:", gridD[1] , " Y:", gridD[2])
    awc = cw/gridD[1];
    ahc = (ch/2)/gridD[2];
    indice = 1;
    for i=1, #arregloPalabras do
        -- 1 nombre,2 x, 3 y, 4 lx , 5 ly
        --vertical
        word = arregloPalabras[i][1]
        if arregloPalabras[i][4] == 1 then
            for j = 0 , arregloPalabras[i][5]-1 do

                posx = arregloPalabras[i][2]
                posy = arregloPalabras[i][3] + j
                
                createSquare(posx,posy,awc,ahc,indice, word, string.sub(word,j+1,j+1));
                indice = indice +1
            end
        else           
            for k = 0 , arregloPalabras[i][4]-1 do
                posx = arregloPalabras[i][2] + k
                posy = arregloPalabras[i][3] 
               
                createSquare(posx,posy,awc,ahc,indice, word, string.sub(word,k+1,k+1));
                indice = indice +1
            end
        end 
    end
end

function revealWord(word)

    print("WORD:",word)
    for index, value in ipairs(squares) do
        aux = getIndex(value.word , word)
        if (next(aux) ~= nil) then
            --Cambiar de color
            value:setFillColor(unpack(blue))
            value:toFront()
            --Agregar las letras
            createLetterObject( value.letter, value.x + (awc/2) ,value.y + (ahc/2), ahc/2,grupoCrucigrama)

        end
    end
end


--CIRCLE FUNCTIONS
function createBigCircle(largo)
    bigRadio = largo/2 - ((largo/2)*0.06)

    local bigControl = display.newCircle(grupoRedondo,cw/2,largo+bigRadio+(largo/6) ,bigRadio);
    bigControl:setFillColor(unpack(silver));
    bigControl:setStrokeColor(unpack(black))
    bigControl.strokeWidth  =10 
    createArrayCircles(bigControl.x, bigControl.y , bigRadio , arregloLetras)
   
end
function createArrayCircles(bx,by,br,letterArray)
    numCirculos = #letterArray
    radio = calculoMiniRadio(numCirculos,br);
    division = math.pi*2 / numCirculos;
    hipotenusa = br - radio

    local j = 1;
    for i=0, (math.pi *2)-division , division do
        x = math.cos(i) *  (hipotenusa-6)
        y = math.sin(i) * (hipotenusa-6)
 
        createMiniCircle(bx,by,x,y,radio,arregloLetras[j],j);
        j = j+1

    end


end

function createMiniCircle(bx,by,sx,sy,sr,text,indice)
    
    circles[indice] = display.newCircle(grupoRedondo,bx, by, sr);
    circles[indice]:translate(sx,sy);
    circles[indice]:setFillColor(unpack(silver));
    circles[indice].letter = text;
    circles[indice].selected = false;
    circles[indice].touch = selectMiniCircle;
    circles[indice]:addEventListener("touch",circles[indice])
    circles[indice]:toFront()
    createLetterObject(text, circles[indice].x,circles[indice].y,sr*1.3,grupoRedondo)
    
end

function calculoMiniRadio(numCirculos, radioGrande)
    local r = ((math.tan(math.pi/numCirculos))/(math.tan(math.pi/numCirculos)+1  ))*radioGrande
    if r < radioGrande*0.3 then
        return r
    end

    return radioGrande * 0.3

end



--SELECTION CIRCLE
function resetLines()

    indicefijo = 0
    display.remove(choosingLine)
    startedChoosing = false
    cordinatesLine={}
    selectedLetters = {}
    for i=1 , #circles do
        circles[i].selected = false
        circles[i]:setFillColor(unpack(silver))
        circles[i]:setStrokeColor(unpack(black))
    end
    display.remove(myText);
    display.remove(wordBox);
    optionsArmado.text = ""

end

function selectMiniCircle(self, event)
    if event.phase == "began" then
        print("touched MINI redondo")
        cordinatesLine = {}
        table.insert(cordinatesLine, self.x)
        table.insert(cordinatesLine, self.y)
        startedChoosing = true
        indicefijo = 2
        table.insert(selectedLetters,self.letter)
        self:setFillColor(unpack(blue))
        self.selected = true
        createChangingLetter(self.letter , cw/2 , ch*17/35 ,100 , grupo_intermedio)
        
    elseif event.phase == "moved" then
        -- print("moving MINI redondo")
        if (startedChoosing == true and self.selected == false) then
            self.selected = true
            cordinatesLine[indicefijo +1 ] = self.x
            cordinatesLine[indicefijo +2] = self.y
            table.insert(selectedLetters,self.letter)
            indicefijo = indicefijo +2 
            self:setFillColor(unpack(blue))
    
            createChangingLetter(self.letter , cw/2 , ch*17/35 , 100 , grupo_intermedio)
        end
        
    elseif event.phase == "ended" then
            print("ENDED MINI EVENT")
        
            actionWWord(selectedLetters);
        
            
        return true
    end
    return false
    
end

function createLine(x,y)
    cordinatesLine[indicefijo +1 ] = x
    cordinatesLine[indicefijo +2] = y

    display.remove(choosingLine)
    
    choosingLine = display.newLine(unpack(cordinatesLine))

    choosingLine.strokeWidth = 20
    choosingLine:setStrokeColor(unpack(blue));
    choosingLine:toBack()
    grupoRedondo:insert(2,choosingLine);

end

function selectBigCircle(event)
    if event.phase == "began" then
        print("touched BIG redondo")
        if startedChoosing == true then
            createLine(event.x,event.y)
           
           end
    
    elseif event.phase == "moved" then
        -- print("moving BIG redondo: x: ".. event.x,"y:", event.y)
        
       if startedChoosing == true then
        createLine(event.x,event.y)
       
       end
       
    
    elseif event.phase == "ended" then
        print("++++++++")
        if startedChoosing == true then
            actionWWord(selectedLetters);
        end
       
        return true

    end
    return false
end


function selectOutside(event)
   
    if event.phase == "ended" then
        print("**************")
        
        actionWWord(selectedLetters);

    end
end



--LETTER OBJECT FUNCTIONS
function createLetterObject(text,x,y,fs,grupo)
    
    options.text = text
    options.x = x
    options.y = y
    options.fontSize = fs
    local myText = display.newText(options);
    myText:setFillColor(0,0,0);
    myText:toFront()
    grupo:insert(myText)
end

--Word that is forming
function createChangingLetter(text,x,y,fs,grupo)
    optionsArmado.text = optionsArmado.text..text
    optionsArmado.x = x
    optionsArmado.y = y
    optionsArmado.fontSize = fs
    display.remove(myText);
    display.remove(wordBox)
    
    myText = display.newText(optionsArmado);
    myText:setFillColor(0,0,0);
    myText:toFront()


    wordBox = display.newRoundedRect(optionsArmado.x,optionsArmado.y,myText.width+20,myText.height+20,30);
    wordBox:setFillColor(unpack(blue));
   
    grupo:insert(wordBox)
    grupo:insert(myText)
end



--FINAL FUNCTIONS
function checkWord(word) 

    for index, value in ipairs(arregloPalabras) do
        if value[1] ==word then
            value[6] = 1
            return true
        end
    end
    return false
end

function checkWin() 

    for index, value in ipairs(arregloPalabras) do
        if value[6] == 0 then
            return false
        end
    end
    print("GANOOO EL NIVEL")

    

    return true
end

--CHOOSING
function actionWWord(selectedLetters)
    local word = ""
    for index, value in ipairs(selectedLetters) do
        word = word .. value
    end
    wasWord = checkWord(word)
    if wasWord then
        changeColor(green)
        revealWord(word)
        winner = checkWin()
        if winner then
            
            overlayOptions.params.winner = true
            fondo:removeEventListener( "touch", selectOutside )
            grupoRedondo:removeEventListener( "touch", selectBigCircle )
            for index, value in ipairs(circles) do
                value:removeEventListener("touch",value)
            end

            composer.showOverlay("overlay-window",overlayOptions);
        end
    else 
        changeColor(red)
    end

    timer.performWithDelay( 350, resetLines  )
    

end

function changeColor(color)


    
        if choosingLine ~= nil and #cordinatesLine > 0  then
            choosingLine:setStrokeColor(unpack(color))
            wordBox:setFillColor(unpack(color))
            for index, value in ipairs(circles) do
                if value.selected == true then
                    value:setFillColor(unpack(color))
                end
            end
        end
    
   
end




--Pause listener
function pauseGame(e)
    if e.phase == "began" then

        
    
    elseif e.phase == "ended" then
        overlayOptions.params.winner = false
        composer.showOverlay("overlay-window",overlayOptions)

    end
    return
end



function scene:create( event )
 
    print("en crear level");
    

end
 
 
-- show()
function scene:show( event )

     
    if ( event.phase == "will" ) then
        

    elseif ( event.phase == "did" ) then
      
        local sceneGroup = self.view

        
        arregloPalabras = event.params.arregloPalabras

       
        grupo_background = display.newGroup( )
        grupo_intermedio = display.newGroup( )
        grupo_delantero = display.newGroup( )
       
    
        sceneGroup:insert( grupo_background )
        sceneGroup:insert( grupo_intermedio )
        sceneGroup:insert( grupo_delantero )
     
    
        grupoCrucigrama = display.newGroup( )
        grupoRedondo = display.newGroup( )
        
        grupo_intermedio:insert(grupoCrucigrama)
        grupo_delantero:insert(grupoRedondo)
    
        
        fondo = display.newImageRect(grupo_background,"images/fondo.jpg" , cw, ch) 
      
        fondo.anchorX = 0
        fondo.anchorY = 0
    
        fondo:setFillColor( unpack(white))
        fondo:addEventListener("touch",selectOutside)
        
        pauseB = display.newImage(grupo_delantero, "images/pause.png", cw+20, 5)
        pauseB.xScale = 0.45 pauseB.yScale = 0.45
        pauseB.anchorX = 1;  pauseB.anchorY =0 
        pauseB:addEventListener( "touch", pauseGame )
    
    
        grupoRedondo:addEventListener("touch",selectBigCircle)
        
       

        arregloLetras = {}
        circles = {}
        squares = {}
         --Lines
        winner = false
        for index, value in ipairs(arregloPalabras) do
            value[6]=0
        end
        overlayOptions.params.winner = false
        startedChoosing = false
        cordinatesLine = {}
        indicefijo = 0 
        selectedLetters ={}

        options = {
            text = "",
            x = display.contentCenterX,
            y = display.contentCenterY,
            font = "arial",
            fontSize = 200
        }
        
        optionsArmado = {
            text = "",
            x = display.contentCenterX,
            y = display.contentCenterY,
            font = "arial",
            fontSize = 200
        }
    --

        awx = 0
        ahc = 0

        getLetters(arregloPalabras);
        createBigCircle(ch*16/35);
        createGrid(ch*17/35);

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