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

set_de_palabras = {"ababa", "abaca", "abaco", "abada", "abadi", "abaja", "abaje", "abajo", "abala", "abale", "abalo", "abana", "abane", "abano", "abasi", "abata", "abate", "abati", "abato", "abece", "abeja", "abete", "abeto", "abiar", "abias", "abina", "abine",
"babas", "babea", "babee", "babel", "babeo", "babis", "bable", "babor", "bacan", "bacas", "bache", "bacia", "bacin", "bacon", "badal", "badan", "badas", "badea", "baden", "badil", "bafle", "bagad", "bagan", "bagar", "bagas", "bagos", "bagre", "bague", "bahai", "bahia",
"cabal", "cabas", "cabed", "caben", "caber", "cabes", "cabia", "cabio", "cable", "cabos", "cabra", "cabre", "cabro", "cacan", "cacao", "cacas", "cacea", "cacee", "cacen", "caceo", "caces", "cacha", "cache", "cacho", "cachu", "cacle", "cacos", "cacto", "cacuy", "cadas",
"daban", "dabas", "dable", "dacha", "dacia", "dacio", "dadas", "dador", "dados", "dagas", "dahir", "daifa", "dajao", "dalas", "dalgo", "dalia", "dalla", "dalle", "dallo", "damas", "damil", "damos", "dance", "dandi", "dando", "danes", "dango", "danta", "dante", "danto",
"ebano", "ebria", "ebrio", "echad", "echan", "echar", "echas", "echen", "eches", "ecuas", "ecuos", "edema", "edila", "edita", "edite", "edito", "edrad", "edran", "edrar", "edras", "edren", "edres", "educa", "educe", "educi", "educo", "eduje", "edujo", "efebo", "efeta",
"fabas", "fabla", "fabos", "fabro", "facas", "facer", "faces", "facha", "fache", "facho", "facil", "facon", "facto", "fadas", "fados", "faena", "faene", "faeno", "fagos", "fagot", "faina", "faino", "fajad", "fajan", "fajar", "fajas", "fajea", "fajee", "fajen", "fajeo",
"gaban", "gabar", "gacel", "gacha", "gache", "gachi", "gacho", "gafad", "gafan", "gafar", "gafas", "gafea", "gafee", "gafen", "gafeo", "gafes", "gafos", "gagas", "gagos", "gaita", "gajes", "gajos", "galan", "galas", "galce", "galea", "galeo", "gales", "galga", "galgo",
"habar", "habas", "haber", "habia", "habil", "habiz", "habla", "hable", "hablo", "habon", "habra", "habre", "habus", "hacan", "haced", "hacen", "hacer", "haces", "hacha", "hache", "hacho", "hacia", "hadar", "hadas", "hados", "hafiz", "hagan", "hagas", "haiga", "halad",
"ibais", "ibera", "ibero", "ibice", "icaco", "iceis", "ichal", "ichos", "ichus", "icono", "ictus", "idead", "ideal", "idean", "idear", "ideas", "ideay", "ideen", "idees", "ideos", "idolo", "iglus", "ignea", "igneo", "igual", "iguar", "ijada", "ijiyo", "ijuju", "ileon",
"jabas", "jabis", "jable", "jabon", "jabra", "jabre", "jabri", "jabro", "jacal", "jacas", "jacer", "jacha", "jacos", "jacta", "jacte", "jacto", "jadas", "jadea", "jadee", "jadeo", "jades", "jadia", "jadie", "jadio", "jaece", "jaeza", "jaezo", "jagua", "jaiba", "jaima",
"labeo", "labes", "labia", "labil", "labio", "labor", "labra", "labre", "labro", "lacad", "lacan", "lacar", "lacas", "lacea", "lacee", "lacen", "laceo", "laces", "lacha", "lacho", "lacia", "lacio", "lacon", "lacra", "lacre", "lacro", "lacta", "lacte", "lacto", "ladas",
"mabis", "mable", "macal", "macan", "macar", "macas", "macea", "macee", "macen", "maceo", "maces", "macha", "mache", "machi", "macho", "macia", "macio", "macis", "macla", "macon", "macro", "macua", "mador", "madre", "maesa", "maese", "maeso", "mafia",
"nabab", "nabal", "nabar", "nabas", "nabis", "nabla", "nabos", "nacar", "nacas", "naced", "nacen", "nacer", "naces", "nacha", "nacho", "nacia", "nacio", "nacos", "nacre", "nadad", "nadal", "nadan", "nadar", "nadas", "naden", "nades", "nadga", "nadie", "nadir", "nafra",
"oasis", "obelo", "obesa", "obeso", "obice", "obito", "oblea", "oboes", "obolo", "obrad", "obran", "obrar", "obras", "obren", "obres", "obsta", "obste", "obsto", "obten", "obues", "obvia", "obvie", "obvio", "ocapi", "ocaso", "ocelo", "ocena", "ochos", "ociad", "ocian",
"pacae", "pacas", "pacay", "paced", "pacen", "pacer", "paces", "pacha", "pacho", "pacia", "pacio", "pacon", "pacos", "pacta", "pacte", "pacto", "pacus", "padre", "pafia", "pafio", "pagad", "pagan", "pagar", "pagas", "pagel", "pagos", "pagro", "pagua", "pague", "pahua",
"queco", "queda", "quede", "quedo", "queja", "queje", "quejo", "quema", "queme", "quemi", "quemo", "quena", "quepa", "quepi", "quepo", "quera", "quere", "quero", "queso", "quias", "quien", "quier", "quifs", "quijo", "quila", "quilo", "quima", "quimo", "quina", "quino",
"rabal", "rabas", "rabea", "rabee", "rabel", "rabeo", "rabia", "rabie", "rabil", "rabio", "rabis", "rabon", "rabos", "racea", "racee", "racel", "raceo", "racha", "rache", "racho", "racor", "racos", "radal", "radar", "radas", "rades", "radia", "radie", "radio", "radon",
"sabea", "sabed", "saben", "sabeo", "saber", "sabes", "sabia", "sabio", "sabir", "sable", "sabor", "sabra", "sabre", "sacad", "sacan", "sacar", "sacas", "saces", "sacha", "sache", "sacho", "sacia", "sacie", "sacio", "sacon", "sacos", "sacra", "sacre", "sacro", "saeta",
"tabal", "tabas", "tabea", "tabes", "tabis", "tabla", "table", "tablo", "tabon", "tabor", "tabos", "tabus", "tacar", "tacas", "tacen", "taces", "tacet", "tacha", "tache", "tacho", "tacon", "tacos", "tacto", "tafia", "tafon", "tafos", "tafur", "tagua", "tahas", "tahur",
"ubica", "ubico", "ubies", "ubios", "ubres", "ucase", "uchus", "uebos", "ufana", "ufane", "ufano", "ugres", "ujier", "ujule", "ulaga", "ulala", "ulano", "ulema", "ulpos", "ultra", "uluas", "ulula", "ulule", "ululo", "umbra", "umbro", "umero", "unais", "uncen", "unces",
"vacad", "vacan", "vacar", "vacas", "vacia", "vacie", "vacio", "vacos", "vacua", "vacuo", "vadea", "vadee", "vadeo", "vades", "vados", "vafea", "vafee", "vafeo", "vagad", "vagan", "vagar", "vagas", "vagon", "vagos", "vague", "vahad", "vahan", "vahar", "vahas", "vahea",
"xecas", "xenon", "xinca", "xiote", "xolas", "xolos", "yabas", "yacal", "yacas", "yaced", "yacen", "yacer", "yaces", "yacia", "yacio", "yacon", "yagan", "yagas", "yagua", "yaiti", "yales", "yamao", "yambo", "yampa", "yanas", "yanta", "yante", "yanto", "yapad", "yapan", 
"yapar", "yapas", "yapen", "yapes", "yapus", "yaque", "zabra", "zabro", "zacas", "zacea", "zacee", "zaceo", "zades", "zafad", "zafan", "zafar", "zafas", "zafen", "zafes", "zafia", "zafio", "zafir", "zafon", "zafos", "zafra", "zafre", "zagal", "zagas", "zagua", "zahen", 
"zahon", "zaida", "zaina", "zaino", "zajon", "zalas"}

print("Tamano set_de_palabras: ", #set_de_palabras)
palabra_a_descubrir = set_de_palabras[math.random(0, #set_de_palabras - 1)]

print("Palabra a DESCUBRIR:", palabra_a_descubrir)



cw = display.contentWidth
ch = display.contentHeight

acw = cw/16
ach = ch/16

-- utiles
even_lighter_gray = { 245/255, 245/255, 245/255}
light_gray = { 190/255, 190/255, 190/255 }
dark_grey = { 64/255, 64/255, 64/255 }
black = { 0, 0, 0 }
green = { 58/255, 219/255, 9/255 }
yellow = { 240/255, 236/255, 120/255 }

-- valores auxiliares
letter_column_counter = 0 -- para ver en que letra de las palabras
word_row_counter = 0      -- estamos

last_col = letter_column_counter
last_row = word_row_counter

fila_letra_palabra = 0 -- para crearBloqueLetraPalabra
columna_letra_palabra = 0

-- variables IMPORTANTES
matrizCeldasLetras = {}
matrizCeldasLetras[word_row_counter] = {} -- agregamos fila
matrizCeldasBloqueLetras = {}
matrizCeldasBloqueLetras[word_row_counter] = {}
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

    --matrizCeldasBloqueLetras[fila_letra_palabra][columna_letra_palabra]
    if columna_letra_palabra <= 4 then
        if columna_letra_palabra == 4 then
            matrizCeldasBloqueLetras[fila_letra_palabra][columna_letra_palabra] = bloque
            matrizCeldasBloqueLetras[fila_letra_palabra+1] = {}

            fila_letra_palabra = fila_letra_palabra + 1
            columna_letra_palabra = 0
            return
        end
        matrizCeldasBloqueLetras[fila_letra_palabra][columna_letra_palabra] = bloque

        columna_letra_palabra = columna_letra_palabra + 1
    end

end
function crearLetraBloque(posX, posY, palabra) -- letras del teclado de input (abajo)
    myText = display.newText( palabra, posX, posY, "arial", 50 )
    myText.anchorX = 0; myText.anchorY = 0
    myText:setFillColor(unpack(black))
    myText:toFront()
    ---------------------------
    if myText.text == "<=" then
        myText.touch = borrarLetra -- le asignamos la funcion borrarLetra 
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
    for i=0, 27, 1 do
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
    letras_teclado = {"q","w","e","r","t","y","u","i","o","p",
    "a", "s", "d", "f", "g", "h", "j", "k", "l", "ñ",
    "z", "x", "c", "v", "b", "n", "m", "<="}
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
            verificacionPalabra(palabraActual)
            return
        else
            print("No puedes enviar una palabra que no sea de 5 letras!")
        end
end

function verificacionPalabra(palabra)
    --print("fila_letra_palabra:", word_row_counter, "columna_letra_palabra", letter_column_counter)
    if palabra == palabra_a_descubrir then
        print("palabra:", palabra, "palabra_a_descubrir:",palabra_a_descubrir)
        for i=0, #matrizCeldasBloqueLetras[word_row_counter] do
            matrizCeldasBloqueLetras[word_row_counter][i]:setFillColor(unpack(green))
        end
        print("FELICIDADES, GANASTE! OWO")
        ganar()
    else
        --print("palabra:", palabra, "palabra_a_descubrir:",palabra_a_descubrir)
        print("palabra:", palabra, "palabra_a_descubrir:",palabra_a_descubrir)
        for i=0, #matrizCeldasLetras[word_row_counter] do
            auxLetra = matrizCeldasLetras[word_row_counter][i].text
            for j=1, #palabra_a_descubrir do
                print(auxLetra, string.sub(palabra_a_descubrir, j, j), i, j-1)
                if auxLetra == string.sub(palabra_a_descubrir, j, j) then
                    if i == j-1 then
                        --print(i, j-1)
                        print(auxLetra, "esta en:", palabra_a_descubrir, "y mis posicion => verde")
                        matrizCeldasBloqueLetras[word_row_counter][i]:setFillColor(unpack(green))
                        break
                    else
                        print(auxLetra, "esta en:", palabra_a_descubrir, "y diferente posicion => amarillo")
                        matrizCeldasBloqueLetras[word_row_counter][i]:setFillColor(unpack(yellow))
                        break
                    end
                end
            end
        end
    end
end

function ganar()
    composer.removeScene( "juego")
    composer.gotoScene( "win", {
        effect =  "slideLeft", 
        time = 2000
         } )
    return true
end

crearBloqueDeTeclado()
crearBloqueDePalabras()
crearLetrasBloqueTeclado()

return scene