module(..., package.seeall)

function newStreet( nm, dir, ori, pc, sw, spawn_point )
	o = {
		name = nm,
		direction = dir,
		orientation = ori,
		pos_center = pc,
		street_width = sw,
		spawn_point = spawn_point,
		street_group = display.newGroup()
	}

	if ori > 0 then
		display.newLine( pc, 0, pc, ch )
	elseif ori < 0 then 
		display.newLine( 0, pc, cw, pc )
	end

	return o
end

function addCarToStreet( car, street )
	if (street.orientation > 0) then
		car_width = street.street_width * (2/3)
		car_height = car.dis * 2
	else
		car_width = car.dis * 2
		car_height = street.street_width * (2/3)
	end

	car.on_display = display.newRect( street.street_group, street.spawn_point.x, 
			street.spawn_point.y, car_width, car_height )
	car.on_display.alpha = 0.5
	car.on_display:setFillColor( math.random( 0,255 )/255, math.random( 0,255 )/255, math.random( 0, 255 )/255 )
	car.in_street = street
end

function carLeavingStreet( car )
	car.in_street.street_group:remove( car.on_display )
	car.on_display:removeSelf( )
end

function addTrafficLightToStreet( tl, posx, posy, mstreet )
	tl.on_display = display.newCircle( posx, posy, 5 )
	tl.on_wait:insert( tl.on_display )
	tl.in_street = mstreet
end