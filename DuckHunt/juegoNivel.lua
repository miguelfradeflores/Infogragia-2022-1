local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
local contadorBalasF=3
local contadorBalasI=3
local puntaje=0
local grupo_background, grupo_intermedio, grupo_delantero
grupos = {grupo_background, grupo_intermedio, grupo_delantero}
local bala1,bala2, bala3
local manejadorBalas = {} 
local textoPuntaje
local velocidad 
local tiempo =0
local textoTiempo
local mensajeRectGameOver
local textoGameOver 
local textoNivelcompletado 
local manejadorTiempo 
local puntajeMax=100
local arma
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- ----------------------------------------------------------------------------------
 -- Balas
 function actualizarTiempo( event )
    tiempo = tiempo- 1 
    textoTiempo.text = "Tiempo: " .. tiempo
    if tiempo == 0 then
        detenerJuego(  )
        
    end

    return true
end
 -- Balas
 function crearBalas( )
     -- body
    puntajeBorde = display.newRect(40,630,240,120)
    puntajeBorde.anchorX = 0;  puntajeBorde.anchorY = 0
    puntajeBorde:setStrokeColor(0,0,0);puntajeBorde.strokeWidth = 4
    puntajeBorde.alpha = 0.7 ; 
    bala1 = display.newImageRect("bala.png",40,75)
    bala1.x=100; bala1.y = 700
    bala2 = display.newImageRect("bala.png",40,75)
    bala2.x=135; bala2.y = 700
    bala3 = display.newImageRect("bala.png",40,75)
    bala3.x=170; bala3.y = 700

    table.insert(manejadorBalas,bala1)
    table.insert(manejadorBalas,bala2)
    table.insert(manejadorBalas,bala3)
    acualizarBalas(  )

end
function acualizarBalas(  )
    -- body
    print(#manejadorBalas)
    print(contadorBalasF , contadorBalasI)
    if contadorBalasI == 0 or puntaje>=puntajeMax then
        return
    end
    if contadorBalasF<3 then 
        if contadorBalasF < contadorBalasI then
            manejadorBalas[contadorBalasI].isVisible = false
        else
            manejadorBalas[contadorBalasF].isVisible = true
        end
    end
    contadorBalasI = contadorBalasF
    if contadorBalasF == 0 then
        detenerJuego(  )
        
    end
    return true
end
--- Objeto
function crearObjeto()
    dir1 = math.random(0,1)
    initX=0 ; intiY=0
    if dir1 == 1 then
        initX = -300
    else
        initX = 1400
    end
    
    if contadorBalasI ~= 0 and puntaje<puntajeMax then 
        circulo = display.newImageRect(grupo_intermedio,"globo.jpg",40,60)
        circulo.x = initX  ; circulo.y = ch/2
        transition.to(circulo, { x=initX, y= math.random(50,600), time=100,onComplete=mover,tag = "objeto"})
        circulo.touch = destruirObjeto
        circulo:addEventListener("touch",circulo)
    end
    return true
end
function mover()
    dir1 = math.random(0,1)
    dir2 = math.random(0,1)
    posY =0 ;   posX =0
    if dir1==1 then
        posY= math.random(30,600)
        if dir2 ==1 then
            posX = 30 
        else 
            posX = 1224 
        end
    else
        posX= math.random(30,1224)
        if dir2 ==1 then
            posY=30
        else 
            posY=600
        end 
    end
    distancia = dist_puntos(circulo.x, circulo.y,posX, posY)
    time = (distancia*5 )/ velocidad
    transition.to(circulo, { x=posX, y=posY, time=time, transition=easing.inOutSine,onComplete=mover, tag = "objeto"  })
    return true
end

function destruirObjeto(self, event) 
    transition.cancel("objeto")
    self:removeSelf( )
    puntaje = puntaje +10
    textoPuntaje.text = "Puntaje: " .. puntaje
    contadorBalasF = contadorBalasF +1
    print("do")
    acualizarBalas(  )
    if puntaje >= puntajeMax then
        detenerJuego()
    end
    crearObjeto()
end
--- Crear arma 
function dispararObjeto(self,event)
    if event.phase == "ended" then
        rectangulo= self.arma
        angulo = (math.atan(math.abs(rectangulo.y-event.y)/math.abs(event.x-rectangulo.x)))
        angulo = angulo * 180/math.pi
        if event.x > rectangulo.x then
            angulo = 90-angulo
        else 
            angulo = angulo-90
        end 
        rectangulo.rotation =  angulo
        contadorBalasF = contadorBalasF -1 
        acualizarBalas(  )
    end
    return true
end
function crearRecta(  )
    -- body
    rectangulo = display.newRect(cw/2, ch, 50,150)
    rectangulo.anchorY = 0.9
    rectangulo.pointX = rectangulo.x
    rectangulo.pointY = rectangulo.y + 80
    rectangulo:setFillColor(178/255,172/255,157/255)
    return rectangulo
end
---- Mensajes 
function pasasarNivel( )
    -- body
    momeEscenario = ""
    momNivel = velocidad + 1
    if (velocidad%2)==0 then
        momeEscenario = "fondo3.png"
    else
        momeEscenario = "fondo2.png"
    end
    composer.gotoScene( "juegoNivel", {
            effect = "slideLeft",
            time =  2000,
            params = {
                nivel = momNivel,
                balasInicio  =contadorBalasI+2,
                balasFinal = contadorBalasI+2,
                puntaje = puntaje,
                tiempo = 33,
                escenario = momeEscenario
            } 
        })
end
function crearMensajes( )
    -- body
    mensajeRectGameOver = display.newRect(cw/2,ch/2,310,151)
    mensajeRectGameOver:setStrokeColor( 0, 0 ,0 )
    mensajeRectGameOver.strokeWidth = 5
    mensajeRectGameOver.isVisible = false

    textoGameOver=display.newText("Game Over", cw/2,ch/2, "arial", 60) 
    textoGameOver:setFillColor(0,0,0)
    textoGameOver.isVisible = false

    bottonNext = display.newImageRect( "bottonNext.png", 300, 150)
    bottonNext.x = cw/2; bottonNext.y = ch/2+60
    bottonNext.isVisible = false
    bottonNext:addEventListener("touch",pasasarNivel)

end


-- Eventos  Juego
function detenerJuego(  )
    -- body
    transition.cancel("objeto" )
    timer.pause(manejadorTiempo)
    if puntaje >=puntajeMax then
        siguienteNivel(  )
    else
        fondo.arma:removeEventListener("touch",acualizarBalas)
        juegoTerminado(  )
    end
    
end
function juegoTerminado(  )
    -- body
    mensajeRectGameOver.isVisible = true
    textoGameOver.isVisible = true
end
function siguienteNivel(  )
    -- body
    bottonNext.isVisible = true

end
------------------ Game
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    grupo_background = display.newGroup( )
    grupo_intermedio = display.newGroup( )
    grupo_delantero = display.newGroup()
    

    textoPuntaje = display.newText(grupo_delantero,"Puntaje: " .. puntaje, 100,50, "arial", 40) 
    textoTiempo = display.newText(grupo_delantero,"Tiempo: " .. tiempo, cw-400,50, "arial", 40)
    crearBalas( )
    arma =crearRecta( )

    crearMensajes()


end
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        ---- Reinstanciarlas de la anterior pagina 
        velocidad = event.params.nivel
        contadorBalasF = event.params.balasInicio  
        contadorBalasI = event.params.balasFinal
        puntaje = event.params.puntaje
        tiempo = event.params.tiempo 
        momentEs = event.params.escenario

        print(momentEs)
        fondo = display.newImageRect(grupo_background, momentEs, cw, ch+40 )
        fondo.x = 0; fondo.y = 0
        fondo.anchorX = 0;  fondo.anchorY = 0

        fondo.arma = arma
        fondo.touch = dispararObjeto
        fondo:addEventListener("touch",fondo)
        -- textoPuntaje = display.newText("Puntaje: " .. puntaje, 100,50, "arial", 40) 
        -- textoTiempo = display.newText("Tiempo: " .. tiempo, cw-400,50, "arial", 40) 
        manejadorTiempo = timer.performWithDelay( 1000, actualizarTiempo,33 )
        puntajeMax = 20 * velocidad
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        crearObjeto()
        fondoD = display.newRect(grupo_delantero,-400,0,400,ch)
        fondoD.anchorX = 0;  fondo.anchorY = 0
        fondoD:setFillColor(0,0,0)
        fondoI = display.newRect(grupo_delantero,-400,0,400,ch)
        fondoI.anchorX = 0;  fondo.anchorY = 0
        fondoI:setFillColor(0,0,0)
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        bottonNext.isVisible= false

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