-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

--[[
Requerimientos
● Tener un fondo para el juego
● Crear una matriz de celdas para cada letra donde se reflejen los turnos del jugador
    o El jugador solo podrá escribir palabras validas
    o Cada vez que el jugador introduzca una palabra se mostrará el resultado de
    su intento basado en:
        ▪ Las letras que coinciden en el orden de la palabra deberán marcarse
        de color verde
        ▪ Las letras que existan en la palabra pero no coinciden en orden,
        deberan marcar su fondo de amarillO
        ▪ Las Letras que no estén en la palabra se quedarán del mismo color
        que la celda original
    o El jugador tendrá un límite de turnos para adivinar la palabra.
    o Un mensaje deberá desplegarse para denotar si el jugador gano o perdio
        Opcionales
        o Modo científico que implemente una descripción de la palabra a adivinar
        o Modo tildes que implementa la opción de introducir vocales con tildes.
        o Opción de volver a jugar de nuevo con un banco de palabras disponible para
        un nuevo juego.
]]

local composer = require( "composer" )

local scene = composer.newScene()

cw = display.contentWidth
ch = display.contentHeight

acw = cw/16
ach = ch/16

-- utiles
even_lighter_gray = { 245/255, 245/255, 245/255}
light_gray = { 190/255, 190/255, 190/255 }
dark_grey = { 64/255, 64/255, 64/255}
black = { 0, 0, 0}

-- valores auxiliares
letter_column_counter = 0 -- para ver en que letra de las palabras
word_row_counter = 0      -- estamos

last_col = letter_column_counter
last_row = word_row_counter

-- variables IMPORTANTES
matrizCeldasLetras = {}
matrizCeldasLetras[word_row_counter] = {} -- agregamos fila
palabraActual = ""

-- funciones de creacion de objetos
function crearBloqueLetraInput(posX,posY) -- bloque de letras (abajo)
    bloque = display.newRect(posX, posY, acw, ach)
    bloque.anchorX = 0; bloque.anchorY = 0
    bloque:setFillColor(unpack(light_gray))
end
function crearBloqueLetraPalabra(posX,posY) -- bloque de palabras (arriba)
    bloque = display.newRect(posX, posY, acw, ach)
    bloque.anchorX = 0; bloque.anchorY = 0
    bloque:setFillColor(unpack(even_lighter_gray))
    bloque.strokeWidth = 2
    bloque:setStrokeColor(unpack(dark_grey))
end
function crearLetraBloque(posX, posY, palabra) -- letras del teclado de input (abajo)
    myText = display.newText( palabra, posX, posY, "arial", 40 )
    myText.anchorX = 0; myText.anchorY = 0
    myText:setFillColor(unpack(black))
    myText:toFront()
    ---------------------------
    if myText.text == "<=" then
        myText.touch = borrarLetra -- le asignamos la funcion borrarLetra 
        myText:addEventListener("touch", myLetter) -- agregamos eventos cuando toquen
    elseif myText.text == "=>" then
        myText.touch = enviarPalabra -- le asignamos la funcion enviarPalabra 
        myText:addEventListener("touch", myLetter) -- agregamos eventos cuando toquen
    else
        myText.touch = escribirLetra -- le asignamos la funcion escribirLetra 
        myText.letra = palabra -- le agregamos su valor letra a cada letra de los bloques
        myText:addEventListener("touch", myLetter) -- agregamos eventos cuando toquen
    end
end
function crearLetra(posX, posY, letra) -- letra que va en bloque de palabras (arriba)
    myLetter = display.newText( letra, posX, posY, "arial", 35 )
    myLetter.anchorX = 0; myLetter.anchorY = 0
    myLetter:setFillColor(unpack(black))
    myLetter:toFront()

    print("word_row_counter: ", word_row_counter, "letter_column_counter: ", letter_column_counter)
    if letter_column_counter <= 4 then
        if letter_column_counter == 4 then
            matrizCeldasLetras[word_row_counter][letter_column_counter] = myLetter
            print("Tamano fila: ", #matrizCeldasLetras[word_row_counter]+1)
            print("Escribimos la letra: ", matrizCeldasLetras[word_row_counter][letter_column_counter].text)
            for i=0, #matrizCeldasLetras[word_row_counter] do
                palabraActual = palabraActual .. matrizCeldasLetras[word_row_counter][letter_column_counter].text
                break
            end
            print("Palabra: ", palabraActual)

            enviarPalabra() -- ENVIAMOS LA PALABRA DE 5 CARACTERES
            print("creamos nueva fila")
            palabraActual = ""
            matrizCeldasLetras[word_row_counter+1] = {}
            return
        end
        matrizCeldasLetras[word_row_counter][letter_column_counter] = myLetter
        print("Tamano fila: ", #matrizCeldasLetras[word_row_counter]+1)
        print("Escribimos la letra: ", matrizCeldasLetras[word_row_counter][letter_column_counter].text)
        for i=0, #matrizCeldasLetras[word_row_counter] do
            palabraActual = palabraActual .. matrizCeldasLetras[word_row_counter][letter_column_counter].text
            break
        end
        print("Palabra: ", palabraActual)
    end
    
    return myLetter
end

-- FONDO
fondo = display.newRect(0, 0, cw, ch)
fondo.anchorX = 0 ; fondo.anchorY = 0
fondo:setFillColor(240/255, 236/255, 120/255)

-- TECLADO (abajo)
function crearBloqueDeTeclado()
    auxCrearBloquesTeclado = 0; -- var auxiliar para recorrer en x
    jCBT = 0; -- var auxiliar para TAMBIEN para recorrer en x
    for i=0, 28, 1 do
        auxCrearBloquesTeclado = auxCrearBloquesTeclado + 0.5
        if i <= 9 then
            crearBloqueLetraInput(acw*(jCBT+auxCrearBloquesTeclado), ach*11)
        elseif i > 9 and i<=19 then
            if i == 10 then
                jCBT = 0
                auxCrearBloquesTeclado = 0.5;
            end
            crearBloqueLetraInput(acw*(jCBT+auxCrearBloquesTeclado), ach*12.5)
        elseif i > 19 then
            if i == 20 then
                jCBT = 0
                auxCrearBloquesTeclado = 0.5;
            end
            crearBloqueLetraInput(acw*(jCBT+auxCrearBloquesTeclado), ach*14)
        end
        --print(i, j)
        jCBT = jCBT + 1
    end
end

-- LETRAS TECLADO (abajo)
function crearLetrasBloqueTeclado() -- => para ENVIAR, <= para BORRAR
    letras_teclado = {"Q","W","E","R","T","Y","U","I","O","P",
    "A", "S", "D", "F", "G", "H", "J", "K", "L", "Ñ",
    "=>", "Z", "X", "C", "V", "B", "N", "M", "<="}
    auxCrearBloquesTeclado = 0; -- var auxiliar para recorrer en x
    jCBT = 0; -- var auxiliar para TAMBIEN para recorrer en x
    for i in ipairs(letras_teclado) do
        auxCrearBloquesTeclado = auxCrearBloquesTeclado + 0.5
        if i <= 10 then
            crearLetraBloque(acw*(jCBT+auxCrearBloquesTeclado)+10, ach*11.2, letras_teclado[i])
        elseif i > 10 and i<=20 then
            if i == 11 then
                jCBT = 0
                auxCrearBloquesTeclado = 0.5;
            end
            crearLetraBloque(acw*(jCBT+auxCrearBloquesTeclado)+10, ach*12.7, letras_teclado[i])
        elseif i > 20 then
            if i == 21 then
                jCBT = 0
                auxCrearBloquesTeclado = 0.5;
            end
            crearLetraBloque(acw*(jCBT+auxCrearBloquesTeclado)+10, ach*14.2, letras_teclado[i])
        end
        --print(i, j)
        jCBT = jCBT + 1
   end  
end

-- PALABRAS (arriba)
function crearBloqueDePalabras()
    auxCrearBloquesPalabras = 0; -- var auxiliar para recorrer en x
    jCBT = 0; -- var auxiliar para TAMBIEN para recorrer en x
    for i=0, 29, 1 do
        auxCrearBloquesPalabras = auxCrearBloquesPalabras + 0.5
        if i <= 4 then
            crearBloqueLetraPalabra(acw*(jCBT+auxCrearBloquesPalabras)+(acw*4), ach*1)
        elseif i > 4 and i<=9 then
            if i == 5 then
                jCBT = 0
                auxCrearBloquesPalabras = 0.5;
            end
            crearBloqueLetraPalabra(acw*(jCBT+auxCrearBloquesPalabras)+(acw*4), ach*2.5)
        elseif i > 9 and i<=14 then
            if i == 10 then
                jCBT = 0
                auxCrearBloquesPalabras = 0.5;
            end
            crearBloqueLetraPalabra(acw*(jCBT+auxCrearBloquesPalabras)+(acw*4), ach*4)
        elseif i > 14 and i<=19 then
            if i == 15 then
                jCBT = 0
                auxCrearBloquesPalabras = 0.5;
            end
            crearBloqueLetraPalabra(acw*(jCBT+auxCrearBloquesPalabras)+(acw*4), ach*5.5)
        elseif i > 19 and i<=24 then
            if i == 20 then
                jCBT = 0
                auxCrearBloquesPalabras = 0.5;
            end
            crearBloqueLetraPalabra(acw*(jCBT+auxCrearBloquesPalabras)+(acw*4), ach*7)
        elseif i > 24 and i<=29 then
            if i == 25 then
                jCBT = 0
                auxCrearBloquesPalabras = 0.5;
            end
            crearBloqueLetraPalabra(acw*(jCBT+auxCrearBloquesPalabras)+(acw*4), ach*8.5)
        end
        jCBT = jCBT + 1
    end
end

-- LETRAS PALABRAS / ESCRIBIR (arriba)
auxXletra = 0
auxXletra2 = 0
auxYletra = 0
function escribirLetra(self, e)
    if e.phase == "ended" then
        auxXletra2 = auxXletra2 + 0.5
        if word_row_counter <= 5 then
                if word_row_counter == 0 then
                    if letter_column_counter < 4 then
                        crearLetra(acw*(auxXletra+auxXletra2)+(acw*4)+10, ach*(1.2), self.letra)
                        
                        letter_column_counter = letter_column_counter + 1
                        last_col = letter_column_counter

                        auxXletra = auxXletra + 1
                        return
                    elseif letter_column_counter == 4 then
                        crearLetra(acw*(auxXletra+auxXletra2)+(acw*4)+10, ach*(1.2), self.letra)
                        letter_column_counter = 0
                        last_col = last_col + 1
                        last_row = word_row_counter
                        word_row_counter = word_row_counter + 1

                        auxXletra2 = 0
                        auxXletra = 0
                        return
                    end
                elseif word_row_counter > 0 then
                    if letter_column_counter == 4 then
                        crearLetra(acw*(auxXletra+auxXletra2)+(acw*4)+10, ach*(2.5+auxYletra+0.2), self.letra)
                        letter_column_counter = 0
                        last_col = last_col + 1
                        last_row = word_row_counter
                        word_row_counter = word_row_counter + 1

                        auxXletra2 = 0
                        auxXletra = 0
                        auxYletra = auxYletra + 1.5
                    elseif letter_column_counter < 4 then
                        crearLetra(acw*(auxXletra+auxXletra2)+(acw*4)+10, ach*(2.5+auxYletra+0.2), self.letra)
                        
                        letter_column_counter = letter_column_counter + 1
                        last_col = letter_column_counter

                        auxXletra = auxXletra + 1
                    end
                end
        else
            print("LIMITE DE PALABRAS!")
        end
    end
end

function borrarLetra(self, e)
    if e.phase == "ended" then
        if letter_column_counter > 0 then
            print("eliminamos fila:", last_row, "columna:", last_col-1)
            display.remove(matrizCeldasLetras[word_row_counter][last_col-1])
            table.remove(matrizCeldasLetras[word_row_counter][last_col-1])
            palabraActual = palabraActual:sub(1, #palabraActual-1)

            letter_column_counter = letter_column_counter - 1
            last_col = letter_column_counter 
            print("Palabra acutal: ", palabraActual)

            auxXletra = auxXletra - 1
            auxXletra2 = auxXletra2 - 0.5
        else
            print("No hay nada que borrar :)")
        end

    end
end

function enviarPalabra()
        if last_col == 4 then
            print("Verificamos la palabra:", palabraActual)
            return
        else
            print("No puedes enviar una palabra que no sea de 5 letras!")
        end
end

crearBloqueDeTeclado()
crearBloqueDePalabras()
crearLetrasBloqueTeclado()

return scene