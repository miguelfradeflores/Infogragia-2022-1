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

	local border = sw / 2

	if ori > 0 then
		--display.newLine( pc, 0, pc, ch )
		display.newLine( pc - border, 0, pc - border, ch )
		display.newLine( pc + border, 0, pc + border, ch )
	elseif ori < 0 then 
		--display.newLine( 0, pc, cw, pc )
		display.newLine( 0, pc - border, cw, pc - border )
		display.newLine( 0, pc + border, cw, pc + border )
	end

	return o
end

function carLeavingStreet( car )
	car.in_street.street_group:remove( car )
end
