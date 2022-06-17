-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"
 --------------------------------------------


-- forward declarations and other locals
cw = display.contentWidth
ch = display.contentHeight +200
local grupo_background, grupo_intermedio, grupo_delantero
season = 1   
gameTime = 0 
countPrey = 20
preysLive = 20
deadPreys = {}
countHunter = 4
deadHunters = 0

local preys = {}
local hunters = {}

local options = {
		width = 576/12,
		height= 384/8,
		numFrames = 96
	}

local spritePrey = graphics.newImageSheet( "cerdos.png", options )
local spriteHunter = graphics.newImageSheet( "lobos.png", options )

function createSequencePrey( i )
	-- bodyPRey
	local sequence = {
		{
			name = "goDown",
			frames = {1+(i*3),2+(i*3),3+(i*3)},
			loopCount =0,
			time = 670,
			sheet = spritePrey
		},
		{
			name = "goLeft",
			frames = {13+(i*3),14+(i*3),15+(i*3)},
			loopCount =0,
			time = 670,
			sheet = spritePrey
		},
		{
			name = "goRight",
			frames = {25+(i*3),26+(i*3),27+(i*3)},
			loopCount =0,
			time = 670,
			sheet = spritePrey
		},
		{
			name = "goLeft",
			frames = {13+(i*3),14+(i*3),15+(i*3)},
			loopCount =0,
			time = 670,
			sheet = spritePrey
		},
		{
			name = "goUp",
			frames = {37+(i*3),36+(i*3),38+(i*3)},
			loopCount =0,
			time = 670,
			sheet = spritePrey
		}
	}
	return sequence
end

function createSequenceHunter( i )
	-- bodyPRey
	local sequence = {
		{
			name = "goDown",
			frames = {1+(i*3),2+(i*3),3+(i*3)},
			loopCount =0,
			time = 670,
			sheet = spriteHunter
		},
		{
			name = "goLeft",
			frames = {13+(i*3),14+(i*3),15+(i*3)},
			loopCount =0,
			time = 670,
			sheet = spriteHunter
		},
		{
			name = "goRight",
			frames = {25+(i*3),26+(i*3),27+(i*3)},
			loopCount =0,
			time = 670,
			sheet = spriteHunter
		},
		{
			name = "goLeft",
			frames = {13+(i*3),14+(i*3),15+(i*3)},
			loopCount =0,
			time = 670,
			sheet = spriteHunter
		},
		{
			name = "goUp",
			frames = {37+(i*3),36+(i*3),38+(i*3)},
			loopCount =0,
			time = 670,
			sheet = spriteHunter
		}
	}
	return sequence
end
---- Functions 
--- Aux 
function dist_puntos(ax, ay, bx, by)
    -- body
    return math.sqrt(math.pow(ax-bx,2)+math.pow(ay-by,2))

end
function movement(self)
	dir1 = math.random(0,1)
    dir2 = math.random(0,1)
    posY =0 ;   posX =0
    if dir1==1 then
        posY= math.random(240,980)
        if dir2 ==1 then
       		self:setSequence( "goLeft" )
            posX = 30 
        else 
            posX = cw-25 
			self:setSequence( "goRight" )
        end
    else
        posX= math.random(30,cw-25)
        if dir2 ==1 then
            posY=240
         	self:setSequence( "goUp" )
        else 
            posY=980
        	self:setSequence( "goDown" )
        end 
    end
    distancia = dist_puntos(self.x, self.y,posX, posY)
    time = (distancia*10 )/ self.velocidad
    self:play();
    --r1 = math.random(-1,1);   r2 = math.random(-1,1);    r3 = math.random(-1,1)
    --timer.performWithDelay(1000, function() self:applyLinearImpulse(r1,r2,self.x, self.y); movement(self)  end, 1)

    transition.to(self, { x=posX, y=posY, time=time,onComplete=movement, tag = "objeto"  }) --- forceaply
    return true
end
---- prey
function createPrey(i) 
	countSecuence = i%4
	newSequence = createSequencePrey(countSecuence)
	preys[i] = display.newSprite(spritePrey, newSequence)
	preys[i]:translate( cw/2, 900 )
	preys[i].velocidad = 1
	preys[i].live = true --- crear antes usar despues
	preys[i].index = i
	physics.addBody(preys[i], "dynamic",{density = 2})
	preys[i].isFixedRotation = true
	preys[i]:play( )
	transition.to(preys[i], {time = 50/preys[i].velocidad, onComplete= movement} )
	preys[i].collision = impactPreyHunter
	preys[i]:addEventListener("collision", preys[i])
end 
function reproduction( )
	-- body
	if preysLive >4 then
		newPreys = preysLive / 4
		for i=1, newPreys do
			countPrey = countPrey + 1
			createPrey(countPrey)
		end
	end
end
function preyEaten( n )
	-- body
	preys[n]:pause()
	transition.pause(preys[n])
	table.insert(deadPreys, n)
	preys[n].live = false
	preys[n].isVisible = false
	timer.performWithDelay(100, function() preys[n].x = 0; preys[n].y=0 end, 1)

end
---- hunter
function  impactPreyHunter(self,event )
	-- body
	if event.phase == "ended" then 
		lobo = event.other 
		if lobo.number ~= nil then
			prey = self
			preyEaten( prey.index)
	 		eatHunter (lobo.number)
		end
	end
end
function eatHunter(n)
	-- body
	if hunters[n].lifes < 5 then
		hunters[n].lifes = hunters[n].lifes + 1
	end
end
function createHunter(i) 
	newSequence = createSequenceHunter(1) 
	hunters[i] = display.newSprite(spriteHunter, newSequence)
	hunters[i]:translate( cw/2, 300 )
	hunters[i].number = i
	hunters[i].velocidad = 2
	hunters[i].lifes = 2
	hunters[i].live = true
	physics.addBody(hunters[i], "dynamic",{density = 2})
	hunters[i].isFixedRotation = true
	hunters[i]:play()
	transition.to(hunters[i], {time = 500/hunters[i].velocidad, onComplete= movement} )
end
function hunterHunger( ) 
	-- body
	for i=1, countHunter do
		if hunters[i].live then 
			hunters[i].lifes = hunters[i].lifes -1
			if hunters[i].lifes == 0 then
				hunters[i].live = false
				deadHunters = deadHunters + 1
				hunters[i]:pause()
				transition.pause(hunters[i])
				hunters[i].x = cw/2 ;hunters[i].y = 1100
			end
		end
	end
end
-- timer
function updateTime( event )
    gameTime = gameTime + 1 
    timeText.text = "Tiempo: " .. gameTime
    if gameTime > (season * 10) then 
    	season = season + 1
    	textoPuntaje.text =  "Temporada: " ..season
    	reproduction( )
    	hunterHunger( )
  	    print("Presas vivas : "..preysLive )

    end 
	preysLive = countPreysLive()

    if preysLive == 0 or deadHunters == 4 then 
    	gameOver()
    end
    return true
end

function countPreysLive()
	local preysLive = 0 
	for i=1, countPrey do
		if preys[i].live then
			preysLive = preysLive + 1
		end
	end
	return preysLive 
end

function gameOver() 
	transition.pause( "objeto")
    timer.pause(timeHandler)
end

--------------------------------------------------- init
function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view
	grupo_background = display.newGroup( )
	grupo_intermedio = display.newGroup( )
	grupo_delantero = display.newGroup()
	-- We need physics started to add bodies, but we don't want the simulaton
	-- running until the scene is on the screen.
	physics.start()
	physics.pause()


	-- create object, add physic, add fuction 

	-- create a grass object and add physics (with custom shape)
	local fondo = display.newImageRect(grupo_background, "fondo2.jpg", cw, ch )
	fondo.anchorX = 0 ;	fondo.anchorY = 0
	fondo.alpha = 0.75

	local marcador = display.newRect(grupo_background, cw/2, 100, cw -200, 150)
	marcador.fill = {0.30,0.70,0.5}
	marcador:setStrokeColor( 0, 0 ,0 )
	marcador.strokeWidth = 5
	-- -- define a shape that's slightly shorter than image bounds (set draw mode to "hybrid" or "debug" to see)
	-- local grassShape = { -halfW,-34, halfW,-34, halfW,34, -halfW,34 }
	-- physics.addBody( grass, "static", { friction=0.3, shape=grassShape } )
	local muroR = display.newRect(grupo_background, cw-25, ch/2, 10, ch-460)
	physics.addBody(muroR, "static")
	muroR.isVisible = false
	local muroL = display.newRect(grupo_background, 25, ch/2, 10, ch-460)
	physics.addBody(muroL, "static")
	muroL.isVisible = false
	local muroU = display.newRect(grupo_background, cw/2, 240, cw+100, 10)
	physics.addBody(muroU, "static")
	muroU.isVisible = false
	local muroD = display.newRect(grupo_background, cw/2, 980, cw-60, 10)
	physics.addBody(muroD, "static")
	muroD.isVisible = false
	local muroV = display.newRect(grupo_background, cw/2, 1200, cw+10, 10)
	physics.addBody(muroV, "static")
	muroV.isVisible = false

	hunterSpawning = display.newImageRect(grupo_delantero, "cueva.png", 40, 40 )
	hunterSpawning.x = cw/2 ;	hunterSpawning.y = 300
	hunterSpawning.alpha = 0.75

	preySpawning = display.newImageRect(grupo_delantero, "granja.png", 40, 40 )
	preySpawning.x = cw/2 ;	preySpawning.y = 900
	preySpawning.alpha = 0.75


	textoPuntaje = display.newText(grupo_delantero,"Temporada: " ..season, cw-400,60, "arial", 40) 
    timeText = display.newText(grupo_delantero,"Tiempo: " .. gameTime, cw-400,120, "arial", 40)

end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
		physics.setGravity( 0, 0)

		--physics.setDrawMode( "hybrid" )
		for i=1, countPrey do
			createPrey(i)
		end
		for i=1, countHunter do
			createHunter(i)
		end
        timeHandler = timer.performWithDelay( 1000, updateTime,100000 )

	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene