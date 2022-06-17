module(..., package.seeall)

local car_options = {
    width = 24,
    height = 24,
    numFrames = 24
}

local explosion_options = {
	width = 64,
	height = 64,
	numFrames = 14,
}

local sprite_car = graphics.newImageSheet( "assets/DinoSprites - doux.png", car_options )
local sprite_explosion = graphics.newImageSheet( "assets/Fire-bomb.png", explosion_options )

local sequence = {
		{
		name = "Avanzar",
		start = 1,
		count = 11,
		loopCount = 0,
		time = 1000,
		sheet = sprite_car
	},
	{
		name = "Explosion",
		start = 1,
		count = 14,
		loopCount = 1,
		time = 670,
		sheet = sprite_explosion
	}
}

function createCar( i, dis, street )
	car = display.newSprite( sprite_car, sequence )
	car.xScale = 1.3; car.yScale = 1.3
    car.xScale = car.xScale * street.direction
	car:translate( street.spawn_point.x, street.spawn_point.y )

	street.street_group:insert( car )
	car.in_street = street
	car.index = i
	
    car.noRespect = (math.random() < 0.3)
    car.step = 1
    car.t = "car"
    car.on_play = true
    car.dis = dis
    car.sensor = dis * 12

    physics.addBody( car, "dynamic", {bounce=0} )

    local function preCollisionEvent( self, event )
        if ( event.other.t == "car" ) then
            self:setSequence( "Explosion" )
            self:play( )
            event.other:setSequence( "Explosion" )
            event.other:play( )

            transition.to( self, {
            	time=670,
            	onComplete=function()
            		event.other.on_play = false
		            self.on_play = false

            		self.alpha = 0
            		event.other.alpha = 0
            	end
            } )
        end
    end
    
    car.preCollision = preCollisionEvent
    car:addEventListener( "preCollision" )

    car:play()

    return car
end

function advance( car )
	local forcex = 0
	local forcey = 0
	-- local isAvailable = isCarAvailableToMove( car )

    --print("En calle", car.in_street.name)
    if car.on_play then
	    if isInsideFrame( car.x, car.y ) then

	    	if (car.in_street.orientation > 0) then
			    forcey = car.in_street.direction * (car.dis/(12 + car.step))
		    else
			    forcex = car.in_street.direction * (car.dis/(12 + car.step))
			end

		    if isCarAvailableToMove( car ) then
		    	if car.bodyType == "static" then
		    		car.bodyType = "dynamic"
		    	end
			    --print("Is Available")
	            --car:applyLinearImpulse( forcex, forcey )
	            car:applyForce( forcex, forcey, car.x, car.y )
	            car.step = car.step + 1
	        else
	        	car.bodyType = "static"
	        	car.step = 1
	        end

	        return true
	    end
	end
	--print( "Leaving street" )
	return false
	-- return res
end

function isInsideFrame ( posx, posy )
    --print("Actual localizacion", car.x, car.y )
    return (posx >= 0) and (posx <= cw) and (posy >= 0) and (posy <= ch)
end

function isCarAvailableToMove( car )
	for i=1, car.in_street.street_group.numChildren, 1 do
		local child = car.in_street.street_group[i]
		local pos_sensor

		if (car ~= child) then
			-- If the street is vertical
			if (car.in_street.orientation > 0) and (child.y ~= car.y) then
				pos_sensor = car.y + (car.in_street.direction * car.sensor)

				-- If the street goes from the top to the bottom
				if (car.in_street.direction > 0) and (child.y > car.y) then -- check if child is in front
					if (pos_sensor > child.y) then	-- check if sensor has already met or passed child's center
						return false
					end
				-- If the street ges from the bottom to the top
				elseif (car.in_street.direction < 0) and (child.y <= car.y) then -- check if child is in front
					if (pos_sensor < child.y) then	-- check if sensor has already met or passed child's center
						return false
					end
				end

			-- If the street is horizontal
			elseif (car.in_street.orientation < 0) and (child.x ~= car.x) then
				pos_sensor = car.x + (car.in_street.direction * car.sensor)

				-- If the street goes from left to right
				if (car.in_street.direction > 0) and (child.x > car.x) then	-- check if child is in front
					if (pos_sensor >= child.x) then 	-- check if sensor has already met or passed child's center
						return false
					end
				-- If the street goes from right to left
				elseif (car.in_street.direction < 0) and (child.x < car.x) then -- check if child is in front
					if (pos_sensor < child.x) then	-- check if sensor has already met or passed child's center
						return false
					end
				end
			end
		end
	end

	return true
end
