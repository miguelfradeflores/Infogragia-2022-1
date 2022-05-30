

cw = display.contentWidth
ch = display.contentHeight

local composer = require( "composer" )
local scene = composer.newScene()

local puntaje
local bird
local dot
local detrasPasto --grupo para establecer las capas

local score = 0
local caminataPerro = 6000 --tiempo
local saltadaPerro = 1000 --tiempo
local perroLlegada = caminataPerro + saltadaPerro
local numIntentosOriginal --= 10
local numeroIntentos = numIntentosOriginal

local tamanoPerro = 58
local tamanoObjetivo = 30
local tamanoPajaro = 38
local velocidadPajaro --= 20 --(cuanto menos es mas rapido)

local colisionado = false;
local muerto = false;
local vivo = false;
local yaLlegoPerro = false
local siguienteEscena = false
local parado = false

local play
local pause
local next

local tries = {}

local myTry

local duckFallAudio
local duckFlappingAudio
local gunShotAudio 
local introMusic



rojo = {252/255, 3/255, 3/255}
verde = {9/255, 222/255, 73/255}

--sobre los efectos de sonido
local soundTable = {
 
    duckFalling = audio.loadSound( "assets/duck-falling.mp3" ),
    duckFlapping = audio.loadSound( "assets/duck-flapping.mp3" ),
    lose = audio.loadSound( "assets/lose.mp3" ),
    gunShot = audio.loadSound( "assets/gun-shot.mp3" )
}

--Sobre las animaciones
local sheetOptions =
{
    width = tamanoPajaro,
    height = tamanoPajaro,
    numFrames = 12
}
local sheet_bird1 = graphics.newImageSheet( "assets/pajaros1.png", sheetOptions )
local sheet_bird2 = graphics.newImageSheet( "assets/pajaros2.png", sheetOptions )
local sheet_bird3 = graphics.newImageSheet( "assets/pajaros3.png", sheetOptions )
local sequences_bird = {
    -- consecutive frames sequence
    {
        name = "birdFly",
        start = 1,
        count = 10,
        time = 1000,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "birdFall",
        start = 10,
        count = 2,
        time = 500,
        loopCount = 1,
        loopDirection = "forward"
    }

}
local sheetOptionsDog1 =
{
    width = tamanoPerro,
    height = tamanoPerro,
    numFrames = 10
}
local sheet_dog1 = graphics.newImageSheet( "assets/perro1.png", sheetOptionsDog1 )
local sequences_dog = {
    -- consecutive frames sequence
    {
        name = "dogWalk",
        start = 1,
        count = 6,
        time = 2000,
        loopCount = 1,
        loopDirection = "forward"
    },
    {
        name = "dogEntry",
        start = 6,
        count = 2,
        time = 500,
        loopCount = 1,
        loopDirection = "forward"
    },
    {
        name = "birdKillFail",
        start = 9,
        count = 2,
        time = 500,
        loopCount = 0,
        loopDirection = "forward"
    }
    

}
-- create()
function scene:create( event )
    print("en el central")
    composer.removeScene( "gameIntro" )
    composer.removeScene( "gameOutro" )
    
    local sceneGroup = self.view
    local params = event.params
    
    if params.numInt < 5 then 
        numIntentosOriginal = 5
        numeroIntentos = numIntentosOriginal
    else
        numIntentosOriginal = params.numInt
        numeroIntentos = numIntentosOriginal
    end
    if params.velocidadPajaro <= 10 then
        velocidadPajaro = 10
    else
        velocidadPajaro = params.velocidadPajaro
    end

    print("vel pajaro:",velocidadPajaro)
    print("num intentos:", numIntentosOriginal)
    --Intro music

    introMusic = audio.loadStream( "assets/duck-hunt-intro.mp3" )
    audio.play( introMusic )

    --Backround Image
    fondo1 = display.newImageRect("assets/back0.jpg", cw, ch)
    fondo1.x = 0
    fondo1.y = 0
    fondo1.anchorX = 0
    fondo1.anchorY = 0
    sceneGroup:insert(fondo1)

    detrasPasto = display.newGroup()
    crearPajaros()

    fondo2 = display.newImageRect("assets/back1.png", cw, ch)
    fondo2.x = 0
    fondo2.y = 0
    fondo2.anchorX = 0
    fondo2.anchorY = 0
    --sceneGroup:insert(fondo2)

    puntaje= display.newText(score, 0.65*cw, 0.88*ch, "assets/pixel.otf", 18 )
    --sceneGroup:insert(puntaje)

    play = display.newImageRect("assets/play.png", 10,10)
    play.anchorX = 0
    play.anchorY = 0
    play.x = 0.31 * cw
    play.y = 0.89 * ch

    play.touch = pararReanudar
    play:addEventListener("touch", play)
    play.isVisible = false
    --sceneGroup:insert(play)

    pause = display.newImageRect("assets/pause.png", 10,10)
    pause.anchorX = 0
    pause.anchorY = 0
    pause.x = 0.31 * cw
    pause.y = 0.89 * ch

    pause.touch = pararReanudar
    pause:addEventListener("touch",pause)
    --sceneGroup:insert(pause)

    next = display.newImageRect("assets/next.png", 80, 25)
    next.anchorX = 0
    next.anchorY = 0
    next.x = cw*0.85
    next.y = ch*0.92
    next.touch = irOutro
    next:addEventListener("touch", next)

    perroEntrada()

    dot = display.newImageRect("assets/objetivo.png", tamanoObjetivo, tamanoObjetivo)
    dot.anchorX = 0
    dot.anchorY = 0
    dot.x = cw/2
    dot.y=ch/2
    --sceneGroup:insert(dot)

 
end
 
-- show()
function scene:show( event )
end
 
-- hide()
function scene:hide( event )
end
 
-- destroy()
function scene:destroy( event )
    
    Runtime:removeEventListener( "enterFrame", gameLoop )
    Runtime:removeEventListener( "accelerometer", onTilt )
    transition.cancelAll()
    next:removeEventListener("touch", next)
    display.remove( dog )
    display.remove( bird )
    display.remove( fondo1 )
    display.remove( fondo2 )
    display.remove( dot )
    display.remove( pause )
    display.remove( play )
    display.remove( next )
    display.remove( puntaje)
    audio.stop( duckFallAudio )
    audio.stop( duckFlappingAudio )
    audio.stop( gunShotAudio  )
    audio.stop( introMusic  )
    
    
    for key, value in pairs(tries) do
        display.remove( value )
    end

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------




--Functions
function actualizarIntentos(intento, exito)
    myTry = display.newRect(0.45*cw+intento*6, 0.9*ch, 3, 10)
    if exito == true then
        myTry:setFillColor(unpack(verde))
    else 
        myTry:setFillColor(unpack(rojo))
    end
    table.insert(tries, myTry)
    return true
end
function iniciarSiguiente(dog)
    
    if(numeroIntentos <= 0) then 
        siguienteEscena = true
        print("CODIGO PARA LA SIGUIENTE ESCENA")
        Runtime:removeEventListener( "enterFrame", gameLoop )
        local options = {
            effect = "fade",
            time = 500,
            params = {
                velocidadPajaro = velocidadPajaro,
                numInt = numIntentosOriginal,
                puntaje = score
            }
        }
        composer.gotoScene( "gameOutro", options ) 

    else
        transition.to(dog, {y = dog.y + 55,delay= 500, time = 2000, onComplete = iniciarNuevoPajaro})
    end
    return true
end
function iniciarNuevoPajaro(dog)
    desaparecer(dog)
    display.remove(bird)
    crearPajaros()
    return true
end
function pararTodo(self, event)
    if ( event.phase == "ended" ) then
    print("pause")    
    self.isVisible = false
    play.isVisible = true
    transition.pause()

    end
    return true
end
function pararReanudar(self, event)
    if ( event.phase == "ended" and parado == true ) then
        print("resume")
        parado = false
        self.isVisible = false
        pause.isVisible = true
        transition.resume()
    elseif ( event.phase == "ended" and parado == false) then
        print("pause")
        parado = true    
        self.isVisible = false
        play.isVisible = true
        transition.pause()
    
    end
    return true
end
--function matarPajaro(self, event)
function matarPajaro(self)-- antes tenia event mas
    --if event.phase == "ended" and colisionado == false then
        --muerto = true
        --colisionado = true

        duckFallAudio = audio.play( soundTable["duckFalling"] )
        transition.cancel(self)
        self:setSequence("birdFall")
        self:play()
        transition.to(self, {y = 250, time = 20000/(self.y)})
        score = score + 10
        puntaje.text = score

        numeroIntentos = numeroIntentos -1
        actualizarIntentos(numIntentosOriginal - numeroIntentos, true)

        dog = display.newImageRect("assets/perro2.png", 58, 58)
        dog.anchorX = 0
        dog.anchorY = 0
        dog.x = cw/2 -tamanoPerro/2
        dog.y = ch*0.7
        detrasPasto:insert(dog)
        transition.to(dog, {y = dog.y - 55, time = 2000, onComplete = iniciarSiguiente})

        
        
    --end
    return true
end
function desaparecerPajaro(obj)
    muerto = true
    colisionado = true
    vivo = false
    desaparecer(obj)
    numeroIntentos = numeroIntentos -1
    actualizarIntentos(numIntentosOriginal - numeroIntentos, false)

    dog = display.newSprite( sheet_dog1, sequences_dog )
    dog:setSequence("birdKillFail")
    dog:play()
    dog.anchorX = 0
    dog.anchorY = 0
    dog.x = cw/2 -tamanoPerro/2
    dog.y = ch*0.68
    detrasPasto:insert(dog)
    transition.to(dog, {y = dog.y - 50, time = 2000, onComplete = iniciarSiguiente})
    return true
end
function desaparecer(obj)
    display.remove(obj)
    return true
end
-----------------------
function colisionPajaro(self,event)
    if ( event.phase == "began" ) then
        --myText = display.newText( self.myName .. ": collision began with " .. event.other.myName, cw/2, ch/2, native.systemFont, 16 )
        myText = display.newText( "COLIISION BEGAN", cw/2, ch/2, native.systemFont, 16 )
 
    elseif ( event.phase == "ended" ) then
        myText = display.newText( "COLLISION ENDED", cw/3, ch/3, native.systemFont, 16 )
        matarPajaro(bird)
    end
    return true
end
function vivirPajaro()
    vivo = true
    return true
end

function crearPajaros()
    n = math.random(1,3)
    if n ==1 then
        bird = display.newSprite( sheet_bird1, sequences_bird )
    elseif n ==2 then
        bird = display.newSprite( sheet_bird2, sequences_bird )
    else 
        bird = display.newSprite( sheet_bird3, sequences_bird )
    end
    xOrigen = math.random(0 + tamanoPajaro,cw -tamanoPajaro)
    xObjetivo = math.random(0 + tamanoPajaro,cw -tamanoPajaro)
    tamY = ch*0.7

    --Calculando la distancia entre origen y destino con la hipotenusa
    local b = tamY
    local c = math.abs(xObjetivo - xOrigen)
    local a = math.abs(math.sqrt(b^2 + c^2))

    bird:play()
    bird.x = xOrigen
    bird.y = tamY
    --bird.touch = matarPajaro
    --bird:addEventListener("touch", bird)

    bird.collision = matarPajaro
    bird:addEventListener("collision")

    --physics.addBody( bird, "static",{ bounce=0 } )
    bird.myName = "pajaro"
    colisionado = false
    muerto = false

    if yaLlegoPerro then
        transition.to(bird, {y = 0, x = xObjetivo,time = math.abs(a)*velocidadPajaro, onComplete=desaparecerPajaro, tag = "subirPajaro", delay = 300, onStart = vivirPajaro})
    else
        transition.to(bird, {y = 0, x = xObjetivo,time = math.abs(a)*velocidadPajaro, onComplete=desaparecerPajaro, tag = "subirPajaro", delay = perroLlegada, onStart = vivirPajaro})
    end
    
    detrasPasto:insert(bird)
    duckFlappingAudio = audio.play( soundTable["duckFlapping"] )


end

function perroSalto(obj)
    obj:setSequence("dogEntry")
    obj:play()
    transition.to(obj, {y = obj.y -40, time = saltadaPerro,onComplete = desaparecer})
    yaLlegoPerro = true
    return true
end

function perroEntrada()
    dog = display.newSprite( sheet_dog1, sequences_dog )
    dog:play()
    dog.x = 0 + tamanoPerro
    dog.y = ch*0.77
    transition.to(dog, {x = cw/2, time = caminataPerro,onComplete = perroSalto})
    return true
end

function colisionPajaroObjetivo(obj1, obj2)
    if obj1 == nil or obj2== nil or tamanoObjetivo == nil or tamanoObjetivo == nil then
        return false
    end
    if ( vivo == true and  muerto == false and siguienteEscena == false and obj1 ~= nil and obj2~= nil and colisionado == false) then  -- Make sure the first object exists

       
        --local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
        --local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
        --local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
        --local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax
    
        local left = obj1.x + obj1.width/2<= obj2.x + obj2.width and obj1.x + obj1.width/2 >= obj2.x
        local right = obj2.x + obj2.width/2 <= obj1.x + obj1.width and obj2.x + obj2.width/2 >= obj1.x
        local up = obj1.y + obj1.height/2 <obj2.y + obj2.height and obj1.y + obj1.height/2 > obj2.y
        local down = obj2.y+ obj2.height/2 < obj1.y + obj1.height and obj2.y +obj2.height/2 > obj1.y
        return ( left or right ) and ( up or down )
    else
        return false
    end
    
end
function irOutro()
    siguienteEscena = true
    numeroIntentos = 0
    iniciarSiguiente(dog)
    return true
end

local function onTilt( event )
    if siguienteEscena == false then
        dot.x = dot.x + event.yGravity*25*(-1)
        dot.y = dot.y + event.xGravity *25*(-1)
    
        if dot.x > cw -tamanoObjetivo then
            dot.x = cw -tamanoObjetivo
        end
        if dot.x < 0 then
            dot.x = 0
        end
        if dot.y > ch -tamanoObjetivo then
            dot.y = ch -tamanoObjetivo
        end
        if dot.y < 0 then 
            dot.y = 0
        end
    end
    return true
end

local function gameLoop( event )

    if vivo == true and muerto == false and siguienteEscena == false and bird ~= nil and dot ~= nil and colisionado == false and colisionPajaroObjetivo(bird, dot) then
        colisionado = true
        muerto = true
        gunShotAudio = audio.play( soundTable["gunShot"] )
        matarPajaro(bird)
    end
    return true
end

Runtime:addEventListener( "enterFrame", gameLoop )
Runtime:addEventListener( "accelerometer", onTilt )

return scene