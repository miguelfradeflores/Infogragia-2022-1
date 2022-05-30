local composer = require( "composer" )
local street_object = require( "gameStreet" )
local car_object = require( "gameCar" )
local tl_object = require( "trafficLight" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local gStreets = {}

local gCars = {}
local gCar_index = 1

local gTrafficL1 = {} -- Set one of traffic lights
local gTrafficL2 = {} -- Set two of traffic lights

local timer_initialize, timer_move_cars

local pause_state = false
pause_button = display.newImageRect( "boton_pausa.png", 50, 50 )
pause_button.x = cw/2; pause_button.y = ch/2
pause_button:addEventListener( "touch", pause_button )

function moveCar( car, index )
    if next(car) then
        print( "Moving car of index "..car.index )
        res = car_object.advance(car)

        if res > 0 then 
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

function initializeCar( )
    table.insert(gCars, car_object.createCar( tostring(gCar_index), 3, 15 ))
    street_index = (math.random( 1, 16 ) % 4) + 1
    -- print( "Street index", street_index )
    -- print( "Street name", gStreets[street_index].name )
    print("Adding car "..gCars[gCar_index].index.." to street", gStreets[street_index].name)
    street_object.addCarToStreet( gCars[gCar_index], gStreets[street_index] )
    gCar_index = gCar_index + 1
end

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

    timer_yellow1 = timer.performWithDelay( 2000, changeToRed1, "1")
end

function changeToGreen1( )
    -- timer.resume( timer_initialize )
    for i=1, #gTrafficL1 do
        tl_object.changeToG( gTrafficL1[i] )
    end
    timer_green1 = timer.performWithDelay( 5000, changeToYellow1, "1")
end

function changeToRed2( )
    -- timer.pause( timer_initialize )
    for i=1, #gTrafficL2 do
        tl_object.changeToR( gTrafficL2[i] )
    end
    timer_red2 = timer.performWithDelay( 7000, changeToGreen2, "2")
end

function changeToYellow2( )
    for i=1, #gTrafficL2 do
        tl_object.changeToY( gTrafficL2[i] )
    end

    timer_yellow2 = timer.performWithDelay( 2000, changeToRed2, "2")
end

function changeToGreen2( )
    -- timer.resume( timer_initialize )
    for i=1, #gTrafficL2 do
        tl_object.changeToG( gTrafficL2[i] )
    end
    timer_green2 = timer.performWithDelay( 5000, changeToYellow2, "2")
end

function pause_button:touch( e )
    if e.phase == "ended" then
        if pause_state then
            timer.resume( "1" )
            timer.resume( "2" )
            timer.resume( timer_initialize )
            timer.resume( timer_move_cars )
        else
            timer.pause( "1" )
            timer.pause( "2" )
            timer.pause( timer_initialize )
            timer.pause( timer_move_cars )
        end

        pause_state = not pause_state
    end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
    gStreets = {
        [1] = street_object.newStreet( "blanco_galindo", 1,  1, 107, 30, {x=107,y=0  } ),
        [2] = street_object.newStreet( "america",        1, -1, 160, 30, {x=0  ,y=160} ),
        [3] = street_object.newStreet( "uyuni",         -1,  1, 214, 30, {x=214,y=ch } ),
        [4] = street_object.newStreet( "heroinas",      -1, -1, 320, 30, {x=cw ,y=320} )
    }

    gTrafficL1 = {
        [1] = tl_object.newLight( 1 ),
        [2] = tl_object.newLight( 2 ),
        [3] = tl_object.newLight( 3 ),
        [4] = tl_object.newLight( 4 ),

    }

    gTrafficL2 = {
        [1] = tl_object.newLight( 5 ),
        [2] = tl_object.newLight( 6 ),
        [3] = tl_object.newLight( 7 ),
        [4] = tl_object.newLight( 8 ),

    }

    -- Interseccion 107, 160
    street_object.addTrafficLightToStreet( gTrafficL1[1], 107, 165, gStreets[1] )
    street_object.addTrafficLightToStreet( gTrafficL2[1], 112, 160, gStreets[2] )

    -- Interseccion 107, 320
    street_object.addTrafficLightToStreet( gTrafficL1[2], 102, 320, gStreets[4] )
    street_object.addTrafficLightToStreet( gTrafficL2[2], 107, 325, gStreets[1] )

    -- Interseccion 214, 160
    street_object.addTrafficLightToStreet( gTrafficL1[3], 214, 155, gStreets[3] )
    street_object.addTrafficLightToStreet( gTrafficL2[3], 219, 160, gStreets[2] )
        
    -- Interseccion 214, 320
    street_object.addTrafficLightToStreet( gTrafficL1[4], 214, 315, gStreets[3] )
    street_object.addTrafficLightToStreet( gTrafficL2[4], 209, 320, gStreets[4] )

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

        b1 = display.newImageRect( "building.png", 100, 140 )
        b1.x = 53; b1.y = 80
        b2 = display.newImageRect( "building.png", 100, 140 )
        b2.x = 257; b2.y = 80
        b3 = display.newImageRect( "building.png", 100, 140 )
        b3.x = 53; b3.y = 400
        b4 = display.newImageRect( "building.png", 100, 140 )
        b4.x = 257; b4.y = 400

        changeToRed1()
        changeToGreen2()

    elseif ( phase == "did" ) then

        timer_initialize = timer.performWithDelay( 4000, initializeCar, 15 )
        timer_move_cars = timer.performWithDelay( 700, moveAllCars, 0 )
 
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