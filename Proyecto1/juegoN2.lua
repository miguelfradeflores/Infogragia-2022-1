local composer = require( "composer" )
local objeto_score = require "score"
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
--for i=1, cantidad,1 do
    --     local myAnimation[i] = display.newSprite( sheet1, sequenceData )
    --     -- myAnimation.width = cw/2
    --     -- myAnimation.height= ch/2
    --     myAnimation[i]:scale( math.random(0 , 3),math.random(0 , 3))
    --     myAnimation[i]n.x =  math.random(cw-50,cw) 
    --     myAnimation[i].y = math.random(0,ch)
    --     myAnimation[i]:play()
    --     myAnimation[i].touch = destruirMalos
    --     myAnimation[i]:addEventListener( "touch", manzanas[i])
    --     myAnimation[i].se_puede_matar = true

    --     posx = math.random(0, cw/4)
    --     posy = math.random(0, 250)
    --     grupo_intermedio:insert(  myAnimation[i] )
    --     myAnimation[i].transition = transition.to(myAnimation[i], {time =3000, x=posx, y=posy, onComplete= mover, tag = "movimiento"})

    -- end 
-- -----------------------------------------------------------------------------------
local grupo_background, grupo_intermedio, grupo_delantero, puntaje
grupos = {grupo_background, grupo_intermedio, grupo_delantero}
local puntos = 0
local cant_toc = 0
local cant_mal = 0
local cant_man = 0
local waiting = false
local round = 0
local clock = os.clock
local lives = 4
local manzanas = {}
local pickles = {}
local prueba = {}
local time = true
local countDownTimer
local portal= display.newImageRect("rmportal.png",200,200)
portal.x=cw
portal.y=ch
portal.anchorX=0
portal.anchorY=0
local squanchy= display.newImageRect("squanchy.png",150,150)
squanchy.x=cw
squanchy.y=ch
squanchy.anchorX=0
squanchy.anchorY=0
local pauseB = display.newImageRect("pauseB.png", cw, ch)
    pauseB.x = cw/2-50
    pauseB.y = 710
    pauseB.anchorX = 0
    pauseB.anchorY = 0
    pauseB:scale( 0.1, 0.1 )

--Spaceship
local circulo = display.newCircle(  100, 100, 80 )
circulo.x = 100; circulo.y = 100
circulo.anchorY = 0
circulo.anchorX = 0
--Snakes
local sheetData1 = { width=118,749 , height=57,5949, numFrames=5, sheetContentWidth=360, sheetContentHeight=120 }
local sheet1 = graphics.newImageSheet( "snakesprite.png", sheetData1)
local sequenceData = {
                    name="seq1", sheet=sheet1, start=1, count=5, time=1000, loopCount=0 
                    }
--Rick 
local sheetData2 = { width=506.8241 , height=337.8827, numFrames=3, sheetContentWidth=1600, sheetContentHeight=800  }
local sheet2 = graphics.newImageSheet( "spacesprite.png", sheetData1)
local sequenceData2 = {
                    name="seq2", sheet=sheet2, start=1, count=3, time=1000, loopCount=0 
                    }
local myAnimation = display.newSprite( sheet2, sequenceData2 )
    myAnimation:scale( 7, 7)
    myAnimation.x = 230; myAnimation.y = 230
    myAnimation:play()

  

local restartB = display.newImageRect("restartB.png", 0, 0)
local resumeB = display.newImageRect("resumeB.png", 0, 0)




function mover(manzana)
    transition.to( manzana,{time=8000, x=math.random(0,cw/4), y=math.random(0,250), onComplete=mover, tag = "movimiento"} )
end
function noMover(manzana)
    transition.to( manzana,{time=8000, x=cw, y=ch, onComplete=noMover, tag = "movimiento"} )
end
function moverM(malo)
    transition.to( malo,{time=3000, x=math.random(0,cw), y=math.random(0,500), onComplete=moverM, tag = "movimientoM"} )
end
function moverGun(gun)

    if gun.x == 200 then 
        transition.to( gun,{time=3000, x=750, y=650, onComplete=moverGun, tag = "movimientoG"} )
    else 
        transition.to( gun,{time=3000, x=200, y=650, onComplete=moverGun, tag = "movimientoG"} )
    end
end



function circunferencia(xc,yc,xp,yp,r)
    d= math.sqrt((xp-xc)^2 + (yp-yc)^2)
    --print("Distancia= ", d)
    if (d>r) then
        return false
    else
        return true
    end
end
function perder()
    print( "INICIANDO METODO JUGAR" )

    composer.removeScene( "juegoN2" )
    composer.gotoScene( "lose",{
          effect =  "crossFade", 
          time = 2000
         } )
end
function reiniciar()
    print( "INICIANDO METODO JUGAR" )

    composer.removeScene( "juegoN2" )
    composer.gotoScene( "introN2",{
          effect =  "fade", 
          time = 2000
         } )
    return true
end
function next()
    print( "INICIANDO METODO JUGAR" )

    composer.removeScene( "juegoN2" )
    composer.gotoScene( "win" ,{
          effect =  "crossFade", 
          time = 2000
         } )
    return true
end

function destruirManzana(self, event)

    if event.phase == "ended" then
        -- desaparecer objeto
        --aumentar marcador 
        if self.se_puede_matar and waiting == false then
            puntos = puntos + 5
            puntaje.text = "SCORE: " .. puntos
            self:removeSelf( )
            local dead= display.newImageRect("deadsnake.png",self.width,self.height)
            dead.x=event.x-100
            dead.y=event.y-100
            dead.scaleX = self.scaleX
            dead.scaleY = self.scaleY
            transition.to( dead,{time=4000, x=dead.x, y=ch,tag = "atraparB"} ) --timer perfomn delay
            
            cant_toc = cant_toc + 1
            grupo_intermedio:insert( dead ) 
            if cant_toc >= 10 then
                next()
                --timer.cancel(countDownTimer)
                time = false
            end    
        end
    end
    return true
end
-- function destruirMalos(self, event)

--     if event.phase == "ended" then
--         if self.se_puede_matar and waiting == false then
--             gun.rotation = 0
--             transition.pause("movimientoG")
--             if self.x < cw then 
--                 gun.rotation = findAngle(self.x,self.y,gun.x,gun.y) + 180
--             else 
--                 gun.rotation = findAngle(self.x,self.y,gun.x,gun.y) 
--             end
--             puntos = puntos - 3
--             puntaje.text = "SCORE: " .. puntos
--             self:removeSelf( )
--             squanchy.x=event.x-50
--             squanchy.y=event.y-50
--             transition.to( squanchy,{time=1000, x=0, y=ch,tag = "atraparM"} ) --timer perfomn delay
--             cant_mal = cant_mal + 1
--             puntajeM.text = "" .. cant_mal
--             transition.resume("movimientoG")
--             if puntos <= 0 then
--                 perder()
--                 timer.cancel(countDownTimer)
--             end
--         end
--     end
--     return true
-- end

 function crearManzanas( cantidad)
    -- body
    round = round +1

    for i=1, cantidad,1 do
        manzanas[i] = display.newSprite( sheet1, sequenceData )
        manzanas[i].x = math.random(cw-100,cw)
        manzanas[i].y = math.random(0,700)
        manzanas[i]:play()
        manzanas[i].touch = destruirManzana
        manzanas[i]:addEventListener( "touch", manzanas[i])
        manzanas[i].se_puede_matar = true
        manzanas[i].rotation = math.random(0,180)
        manzanas[i]:scale( math.random(1,3), math.random(1,3))
        posx = math.random(0, cw/4)
        posy = math.random(0, 250)
        grupo_intermedio:insert(  manzanas[i] )
        manzanas[i].transition = transition.to(manzanas[i], {time =8000, x=posx, y=posy, onComplete= mover, tag = "movimiento"})

    end 
    --crearManzanas(5)
end
function createLives(n)
    for i=1,n,1 do
        pickles[i]= display.newImageRect("pickleRick.png", cw, ch)
        pickles[i].x = cw/2-80+ (50*i)
        pickles[i].y = 30
        pickles[i].anchorX = 0
        pickles[i].anchorY = 0
        pickles[i]:scale( 0.1, 0.1 )
        grupo_delantero:insert( pickles[i])
    end
end
function cleanLives()
    lives = lives - 1
    if lives <= 0 then
        timer.cancel(countDownTimer)
        perder()

    end
    for i=grupo_delantero.numChildren, 1, -1 do
        grupo_delantero[i]:removeSelf( )
        grupo_delantero[i] = nil
        
    end
    pickles = {}
end
--Countdown timer
local time = 1

local secondsLeft = time * 60 

local clockText = display.newText(time..":00", cw*0.85, 50, "ARCADE_N.TTF", 50)
clockText:setFillColor( 1, 1, 1 )
local function updateTime()
  
        secondsLeft = secondsLeft - 1
        local minutes = math.floor( secondsLeft / 60 )
        local seconds = secondsLeft % 60  
        local timeDisplay = string.format( "%02d:%02d", minutes, seconds )
        clockText.text = timeDisplay

        if seconds==0 and minutes ==0 then
            perder()
        end
        
        print("cant_man ", cant_man)
        print("lives ", lives)
        if cant_toc == cant_man then 
            cant_man = cant_man + 5
            crearManzanas(1)
            print("cant_man ", cant_man)
        end
        --print("cant_ma ", cant_man)
        for i=1, table.getn(manzanas),1 do
            if circunferencia(100,100,manzanas[i].x,manzanas[i].y,80) then
                transition.to( manzanas[i],{time=100, x=cw, y=ch} )
                manzanas[i].x=cw; manzanas[i].y=ch
                cleanLives()
                createLives(lives)
                transition.to( manzanas[i],{time=100, x=cw, y=ch, onComplete=mover} )
                --table.remove(manzanas,i)
                
            end
        end

        
    end 
countDownTimer = timer.performWithDelay( 1000, updateTime, secondsLeft )


function crearMalos( cantidad, ancho, alto )
    -- body
    for i=1, cantidad,1 do
        manzanas[i] = display.newImageRect("badmorty.png", ancho,alto)
        manzanas[i].x = math.random(0,cw)
        manzanas[i].y = math.random(0,550)
        manzanas[i].touch = destruirMalos
        manzanas[i]:addEventListener( "touch", manzanas[i])
        manzanas[i].se_puede_matar = true

        posx = math.random(0, cw)
        posy = math.random(0, ch*500)
        grupo_intermedio:insert(  manzanas[i] )
        manzanas[i].transition = transition.to(manzanas[i], {time =3000, x=posx, y=posy, onComplete= moverM, tag = "movimientoM"})

    end 
end
 
function atras(e)
    if e.phase == "ended" then
        objeto_score.describir()
        composer.gotoScene( "menu", "slideRight", 2000 )

    end
    return
end


function resumeP(self,event)
    if event.phase == "ended" then
        print("ENTRO A RESUME")
        transition.resume("movimiento")
        transition.resume("movimientoM")
        transition.resume("atraparM")
        transition.resume("atraparB")
        transition.resume("movimientoG")
        timer.resume(countDownTimer)
        grupo_intermedio.alpha=1
        waiting = false
        for i=grupo_delantero.numChildren, 1, -1 do
            grupo_delantero[i]:removeSelf( )
            grupo_delantero[i] = nil
        end

    end
end

function pauseB:touch(event)
    --sleep(5000)
    if event.phase == "ended" then
        transition.pause("movimiento")
        transition.pause("movimientoM")
        transition.pause("atraparM")
        transition.pause("atraparB")
        transition.pause("movimientoG")
        timer.pause(countDownTimer)
        
        waiting = true
        
        restartB = display.newImageRect("restartB.png", cw, ch)
        resumeB = display.newImageRect("resumeB.png", cw, ch)
        restartB.x = cw/2-150
        restartB.y = ch/2-200
        restartB.anchorX = 0
        restartB.anchorY = 0
        restartB:scale( 0.3, 0.3 )
        restartB.touch=reiniciar
        restartB:addEventListener( "touch", restartB )
        grupo_delantero:insert(restartB )
        
        resumeB.x = cw/2-150
        resumeB.y = ch/2-50
        resumeB.anchorX = 0
        resumeB.anchorY = 0
        resumeB:scale( 0.3, 0.3 )
        resumeB.touch=resumeP
        resumeB:addEventListener( "touch", resumeB )
        grupo_delantero:insert(resumeB )
        grupo_intermedio.alpha=0.5
    end
    --transition.resume("movimiento")
end

function sleep(n)-- seconds
    local t0 = clock()
    while clock() - t0 <= n do end
end


    
function findAngle(x1,y1,x2,y2)
    angle = math.atan2( y2 - y1, x2 - x1 ) * ( 180 / math.pi )
    print("Angle"..angle)
    return angle
end
    -- run them timer
    
-- function createGraphs()
    
-- end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
 
    grupo_background = display.newGroup( )
    grupo_intermedio = display.newGroup( )
    grupo_delantero = display.newGroup()


    print("Paramaetros: ", event.params)
    for k,v in pairs(event.params) do
        print( k,v )
    end

    sceneGroup:insert( grupo_intermedio)
    sceneGroup:insert( 1, grupo_background )
    sceneGroup:insert( grupo_delantero )

    fondo = display.newImageRect("spaceBack.png", cw, ch)
    fondo.x = 0
    fondo.y = 0
    fondo.anchorX = 0
    fondo.anchorY = 0
    
    


    puntaje = objeto_score.crear_score(70, 50)
    

    grupo_background:insert( fondo )
    grupo_intermedio:insert( pauseB )
    grupo_intermedio:insert( puntaje )





end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase


 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
        -- puntaje.text = "SCORE: 0"

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
            grupo_intermedio:insert( clockText)
            grupo_intermedio:insert(circulo)
            grupo_intermedio:insert(myAnimation) 
            createLives(4) 
            local cantidad_de_manzanas_del_nivel = event.params.cantidad_de_manzanas
            cant_man = cantidad_de_manzanas_del_nivel
            local cantidad_de_malos_del_nivel = event.params.cantidad_de_malos
            print("cantidad_de_manzanas_del_nivel ", cantidad_de_manzanas_del_nivel)
            crearManzanas(cantidad_de_manzanas_del_nivel)
            posx = 750
            posy = 650
            transition.to( gun,{time=3000, posx, posy, onComplete=moverGun} )
            pauseB:addEventListener( "touch", pauseB)
            
             

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

        for i=grupo_intermedio.numChildren, 1, -1 do
            grupo_intermedio[i]:removeSelf( )
            grupo_intermedio[i] = nil
        end
        for i=grupo_delantero.numChildren, 1, -1 do
            grupo_delantero[i]:removeSelf( )
            grupo_delantero[i] = nil
        end

 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
        objeto_score=nil
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