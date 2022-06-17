-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"

local street_object = require( "gameStreet" )
local car_object = require( "gameCar" )
local tl_object = require( "trafficLight" )
local crossw_object = require( "cross_walk" )

local gStreets, gCars = {}, {}
local gCar_index = 1

local gTrafficL1, gTrafficL2 = {}, {}

local timer_initialize, timer_move_cars

local pause_state = false

local background = display.newGroup()
local front = display.newGroup()

--------------------------------------------

local pause_button = display.newImageRect( front, "assets/boton_pausa.png", 50, 50 )
pause_button.x = 160; pause_button.y = 73
pause_button:addEventListener( "touch", pause_button )

function pause_button:touch( e )
    if e.phase == "ended" then
        if pause_state then
            timer.resume( "1" )
            timer.resume( "2" )
            timer.resume( "simul" )
            physics.start( )
        else
            timer.pause( "1" )
            timer.pause( "2" )
            timer.pause( "simul" )
            physics.pause( )
        end
        pause_state = not pause_state
    end
end

--------------------------------------------

local warning_text = display.newText( front, "Iniciando", cw/2, ch/2, "font/29LTArapixTRIAL-RegularTRIAL.otf", 20 )
warning_text:setFillColor( 1, 0, 0 )
warning_text.alpha = 0

--------------------------------------------

function deployVerticalStreet(posx, width)
    temp = display.newImageRect(background, "assets/vertical-street.png", width, 145)
    temp.anchorY = 0
    temp.x = posx; temp.y = 0

    temp = display.newImageRect(background, "assets/vertical-street.png", width, 130)
    temp.anchorY = 0
    temp.x = posx; temp.y = 175

    temp = display.newImageRect(background, "assets/vertical-street.png", width, 145)
    temp.anchorY = 0
    temp.x = posx; temp.y = 335
end

function deployHorizontalStreet(posy, width)
    temp = display.newImageRect(background, "assets/horizontal-street.png", 92, width)
    temp.anchorX = 0
    temp.x = 0; temp.y = posy

    temp = display.newImageRect(background, "assets/horizontal-street.png", 77, width)
    temp.anchorX = 0
    temp.x = 122; temp.y = posy

    temp = display.newImageRect(background, "assets/horizontal-street.png", 92, width)
    temp.anchorX = 0
    temp.x = 229; temp.y = posy
end

--------------------------------------------

function changeToRed1( )
    -- timer.pause( timer_initialize )
    for i=1, #gTrafficL1 do
        tl_object.changeToR( gTrafficL1[i] )
    end
    timer.performWithDelay( 7000, changeToGreen1, "1")
end

function changeToYellow1( )
    for i=1, #gTrafficL1 do
        tl_object.changeToY( gTrafficL1[i] )
    end

    timer.performWithDelay( 2000, changeToRed1, "1")
end

function changeToGreen1( )
    -- timer.resume( timer_initialize )
    for i=1, #gTrafficL1 do
        tl_object.changeToG( gTrafficL1[i] )
    end
    timer.performWithDelay( 5000, changeToYellow1, "1")
end

function changeToRed2( )
    -- timer.pause( timer_initialize )
    for i=1, #gTrafficL2 do
        tl_object.changeToR( gTrafficL2[i] )
    end
    timer.performWithDelay( 7000, changeToGreen2, "2")
end

function changeToYellow2( )
    for i=1, #gTrafficL2 do
        tl_object.changeToY( gTrafficL2[i] )
    end

    timer.performWithDelay( 2000, changeToRed2, "2")
end

function changeToGreen2( )
    -- timer.resume( timer_initialize )
    for i=1, #gTrafficL2 do
        tl_object.changeToG( gTrafficL2[i] )
    end
    timer.performWithDelay( 5000, changeToYellow2, "2")
end

---------------------------------------

function moveCar( car, index )
    if (next(car) and (car ~= nil)) then
        res = car_object.advance(car)

        if (not res) then 
            street_object.carLeavingStreet( car )
            gCars[index] = {}
        end
    end
end

function moveAllCars(  )
    for i=1, #gCars do
        moveCar(gCars[i], i)
    end
end

---------------------------------------

function initializeCar( )
    street_index = (math.random( 1, 16 ) % 4) + 1
    -- print( "Street index", street_index )
    -- print( "Street name", gStreets[street_index].name )
    --print("Adding car "..gCar_index.." to street ", gStreets[street_index].name)
    table.insert(gCars, car_object.createCar( gCar_index, 4, gStreets[street_index] ))
    gCar_index = gCar_index + 1
end

---------------------------------------
-- forward declarations and other locals
local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX

function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view

	-- We need physics started to add bodies, but we don't want the simulaton
	-- running until the scene is on the screen.
	physics.start()
	physics.pause()
	--physics.setDrawMode("hybrid")
	physics.setGravity( 0, 0 )

	gStreets = {
        [1] = street_object.newStreet( "blanco_galindo", 1,  1, 107, 30, {x=107,y=0  } ),
        [2] = street_object.newStreet( "america",        1, -1, 160, 30, {x=0  ,y=160} ),
        [3] = street_object.newStreet( "uyuni",         -1,  1, 214, 30, {x=214,y=ch } ),
        [4] = street_object.newStreet( "heroinas",      -1, -1, 320, 30, {x=cw ,y=320} )
    }

    deployVerticalStreet(107, 30) -- blanco_galindo
    deployVerticalStreet(214, 30) -- uyuni
    deployHorizontalStreet(160, 30) -- america
    deployHorizontalStreet(320, 30) -- heroinas

    gTrafficL1 = {
        [1] = tl_object.newLight( 1, 107, 175, gStreets[1], 
        	crossw_object.newCrossWalk( 107, 145, {x=30, y=5},warning_text ) ),

        [2] = tl_object.newLight( 2, 92, 320, gStreets[4], 
        	crossw_object.newCrossWalk( 122, 320, {x=5, y=30}, warning_text ) ),

        [3] = tl_object.newLight( 3, 214, 145, gStreets[3], 
        	crossw_object.newCrossWalk( 214, 175, {x=30, y=5}, warning_text ) ),

        [4] = tl_object.newLight( 4, 214, 305, gStreets[3], 
        	crossw_object.newCrossWalk( 214, 335, {x=30, y=5}, warning_text ) ),

    }

    gTrafficL2 = {
        [1] = tl_object.newLight( 5, 122, 160, gStreets[2], 
        	crossw_object.newCrossWalk( 92, 160, {x=5, y=30}, warning_text ) ),

        [2] = tl_object.newLight( 6, 107, 335, gStreets[1], 
        	crossw_object.newCrossWalk( 107, 305, {x=30, y=5}, warning_text ) ),

        [3] = tl_object.newLight( 7, 229, 160, gStreets[2], 
        	crossw_object.newCrossWalk( 199, 160, {x=5, y=30}, warning_text ) ),

        [4] = tl_object.newLight( 8, 199, 320, gStreets[4], 
        	crossw_object.newCrossWalk( 229, 320, {x=5, y=30}, warning_text ) ),

    }
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )

    for i=1, #gStreets, 1 do
        sceneGroup:insert( gStreets[i].street_group )
    end

    sceneGroup:insert( front )
	-- sceneGroup:insert( grass)
	-- sceneGroup:insert( crate )
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
		b1 = display.newImageRect( "assets/building.png", 100, 140 )
        b1.x = 46; b1.y = 73
        b2 = display.newImageRect( "assets/building2.png", 80, 110 )
        b2.x = 274; b2.y = 73
        b3 = display.newImageRect( "assets/building3.png", 80, 120 )
        b3.x = 46; b3.y = 407
        b4 = display.newImageRect( "assets/building4.png", 80, 110 )
        b4.x = 274; b4.y = 407

        b5 = display.newImageRect( "assets/building5.png", 90, 100 )
        b5.x = 46; b5.y = 240
        b6 = display.newImageRect( "assets/building6.png", 90, 100 )
        b6.x = 274; b6.y = 240
        b7 = display.newImageRect( "assets/building7.png", 70, 90 )
        b7.x = 160; b7.y = 407

	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
        
        changeToRed1()
        changeToGreen2()
		timer.performWithDelay( 2000, initializeCar, 30, "simul" )
        timer.performWithDelay( 700, moveAllCars, 0, "simul" )
		physics.start()
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
