local composer = require( "composer" )
local objeto_score = require "score"
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
-- cw = display.contentWidth
-- ch = display.contentHeight
--Groups
local grupo_background, grupo_intermedio, grupo_delantero, puntaje
grupos = {grupo_background, grupo_intermedio, grupo_delantero}

--Global variables
local puntos = 0
local cant_toc = 0
local cant_mal = 0
local cant_man = 0
local waiting = false
local clock = os.clock
local manzanas = {}

--Create images
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
local punt_portal= display.newImageRect("rmportal.png",80,80)
punt_portal.x=900
punt_portal.y=680
punt_portal.anchorX=0
punt_portal.anchorY=0
local punt_squanchy= display.newImageRect("squanchy.png",80,80)
punt_squanchy.x=30
punt_squanchy.y=680
punt_squanchy.anchorX=0
punt_squanchy.anchorY=0

--Pause boton
local pauseB = display.newImageRect("pauseB.png", cw, ch)
	pauseB.x = cw/2-50
	pauseB.y = 710
	pauseB.anchorX = 0
	pauseB.anchorY = 0
	pauseB:scale( 0.1, 0.1 )

--Debe ser creado aca!!!
local gun= display.newImageRect("gun.png",150,150)
	gun.x = 200
	gun.y = 650

--Resue and restart button 
local restartB = display.newImageRect("restartB.png", 0, 0)
local resumeB = display.newImageRect("resumeB.png", 0, 0)

--Countdown 1 min
local time = 1
local secondsLeft = time * 60   -- 20 minutes * 60 seconds
local clockText = display.newText(time..":00", cw*0.85, 50, "ARCADE_N.TTF", 50)
clockText:setFillColor( 1, 1, 1 )
--Countdowntext
local function updateTime()
	   
	    secondsLeft = secondsLeft - 1
	    local minutes = math.floor( secondsLeft / 60 )
	    local seconds = secondsLeft % 60
	    local timeDisplay = string.format( "%02d:%02d", minutes, seconds )
	    clockText.text = timeDisplay

	    if seconds==0 and minutes ==0 then
	    	perder()
	    end
	end	
local countDownTimer = timer.performWithDelay( 1000, updateTime, secondsLeft )

--Movimiento de R&M, BadMorty y gun
function mover(manzana)
	transition.to( manzana,{time=3000, x=math.random(0,cw), y=math.random(0,500), onComplete=mover, tag = "movimiento"} )
end
function moverM(malo)
	transition.to( malo,{time=3000, x=math.random(0,cw), y=math.random(0,500), onComplete=moverM, tag = "movimientoM"} )
end
function moverGun(gun)
	--print("Entra al metodo")
	-- transition.to( gun,{time=3000, x=50, y=550, onComplete=moverGun} )

	if gun.x == 200 then 
		transition.to( gun,{time=3000, x=750, y=650, onComplete=moverGun, tag = "movimientoG"} )
	else 
		transition.to( gun,{time=3000, x=200, y=650, onComplete=moverGun, tag = "movimientoG"} )
	end
end

--No funciona
-- function sleep(n)
--   os.execute("sleep " .. tonumber(n))
-- end


--Scenes manage
function perder()
    print( "INICIANDO METODO JUGAR" )

    composer.removeScene( "juego" )
    composer.gotoScene( "lose", {
          effect =  "crossFade", 
          time = 2000
         } )
    return true
end
function reiniciar()
    print( "INICIANDO METODO JUGAR" )

    composer.removeScene( "juego" )
    composer.gotoScene( "intro",{
          effect =  "fade", 
          time = 2000
         } )
    return true
end
function next()
    print( "INICIANDO METODO JUGAR" )

    composer.removeScene( "juego" )
    composer.gotoScene( "introN2",{
          effect =  "fade", 
          time = 2000
         } )
    return true
end
--Destruir y crear R&M y BadMorty
function destruirManzana(self, event)

	if event.phase == "ended" then
		-- desaparecer objeto
		--aumentar marcador 
		if self.se_puede_matar and waiting == false then
			gun.rotation = 0
			transition.pause("movimientoG")
			if self.x < cw then 
				gun.rotation = findAngle(self.x,self.y,gun.x,gun.y) + 180
			else 
				gun.rotation = findAngle(self.x,self.y,gun.x,gun.y) 
			end
			puntos = puntos + 5
			puntaje.text = "SCORE: " .. puntos
			self:removeSelf( )
			portal.x=event.x-100
			portal.y=event.y-100
			transition.to( portal,{time=1000, x=cw, y=ch,tag = "atraparB"} ) --timer perfomn delay
			cant_toc = cant_toc + 1
			puntajeB.text = "" .. cant_toc
			transition.resume("movimientoG")	
			if cant_toc == cant_man then
				next()
				timer.cancel(countDownTimer)
			end		
		end
	end
	return true
end
function destruirMalos(self, event)

	if event.phase == "ended" then
		-- desaparecer objeto
		--aumentar marcador 
		if self.se_puede_matar and waiting == false then
			gun.rotation = 0
			transition.pause("movimientoG")
			if self.x < cw then 
				gun.rotation = findAngle(self.x,self.y,gun.x,gun.y) + 180
			else 
				gun.rotation = findAngle(self.x,self.y,gun.x,gun.y) 
			end
			puntos = puntos - 3
			puntaje.text = "SCORE: " .. puntos
			self:removeSelf( )
			squanchy.x=event.x-50
			squanchy.y=event.y-50
			transition.to( squanchy,{time=1000, x=0, y=ch,tag = "atraparM"} ) --timer perfomn delay
			cant_mal = cant_mal + 1
			puntajeM.text = "" .. cant_mal
			transition.resume("movimientoG")
			if puntos <= 0 then
				perder()
				timer.cancel(countDownTimer)
			end
			if cant_mal >= 3 then
				perder()
				timer.cancel(countDownTimer)
			end
		end
	end
	return true
end

 function crearManzanas( cantidad, ancho, alto )
	-- body
	for i=1, cantidad,1 do
		manzanas[i] = display.newImageRect("riandmo.png", ancho,alto)
		manzanas[i].x = math.random(0,cw)
		manzanas[i].y = math.random(0,550)
		manzanas[i].touch = destruirManzana
		manzanas[i]:addEventListener( "touch", manzanas[i])
		manzanas[i].se_puede_matar = true

		posx = math.random(0, cw)
		posy = math.random(0, 550)
		grupo_intermedio:insert(  manzanas[i] )
		manzanas[i].transition = transition.to(manzanas[i], {time =3000, x=posx, y=posy, onComplete= mover, tag = "movimiento"})

	end	
end
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
 

--No funciona, necesita ser creado globalmente
-- function crearGun( ancho, alto)
	
-- 	-- gun.touch = destruirManzana
-- 	-- gun:addEventListener( "touch", gun)
	
-- 	--dividir a la mitad 
-- 	--display.newSprite
-- end

--Resumir el juego, ponerle opacidad completa
function resumeP(self,event)
	if event.phase == "ended" then
		print("ENTRO A RESUME")
		-- desaparecer objeto
		--aumentar marcador 
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

--Add los botones de resume y restart
function pauseB:touch(event)
	--sleep(5000)
	if event.phase == "ended" then
		-- desaparecer objeto
		--aumentar marcador 
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



--Encontrar el angulo para gun	
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

	fondo = display.newImageRect("Couch.png", cw, ch)
	fondo.x = 0
	fondo.y = 0
	fondo.anchorX = 0
	fondo.anchorY = 0
	
    


	--Puntaje general, de buenos y malos
	puntaje = objeto_score.crear_score(70, 50)
	puntajeB = objeto_score.crear_scoreB(850, 690)
	puntajeM = objeto_score.crear_scoreB(100, 690 )
	

	grupo_background:insert( fondo )
	grupo_intermedio:insert( pauseB )
	grupo_intermedio:insert( puntaje )
	grupo_intermedio:insert( puntajeB )
	grupo_intermedio:insert( puntajeM )
	grupo_background:insert( portal )
	grupo_background:insert( squanchy)
	grupo_background:insert( punt_squanchy )
	grupo_background:insert( punt_portal )





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
            local cantidad_de_manzanas_del_nivel = event.params.cantidad_de_manzanas
            local cantidad_de_malos_del_nivel = event.params.cantidad_de_malos
            cant_man = cantidad_de_manzanas_del_nivel
    		print("cantidad_de_manzanas_del_nivel ", cantidad_de_manzanas_del_nivel)
	 		crearManzanas(cantidad_de_manzanas_del_nivel, 150,150)
	 		crearMalos(cantidad_de_manzanas_del_nivel/2, 80,80)
	 		--crearGun(150,150)
	 		posx = 750
			posy = 650
			transition.to( gun,{time=3000, posx, posy, onComplete=moverGun} )
			grupo_intermedio:insert( gun )
	 		pauseB:addEventListener( "touch", pauseB)
	 		
	 		grupo_intermedio:insert( clockText)
	 		--createGraphs()
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
        --Resume y restart 
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