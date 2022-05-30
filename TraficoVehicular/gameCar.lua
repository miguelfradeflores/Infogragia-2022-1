module(..., package.seeall)

function createCar( i, mar, dis )
	o = {
		index = i,
		acc_rate = 1,
		max_acc_rate = mar,

		dis = dis,
		sensor = (dis * 3) + 2,

		on_display = nil,
		transition = nil,
		in_street = nil
	}

	return o
end

function advance( car )
	local newx, newy
	local isAvailable = isCarAvailableToMove( car )
	local res

	if isAvailable then
		print("Is Available")
		if (car.in_street.orientation > 0) then
			newx = car.on_display.x
			newy = car.on_display.y + (car.in_street.direction * car.dis)
		else
			newx = car.on_display.x + (car.in_street.direction * car.dis)
			newy = car.on_display.y
		end

		print("Actual localizacion", car.on_display.x, car.on_display.y )
		print("Nueva localizacion", newx, newy)
		print("En calle", car.in_street.name)

		-- If the car is still inside the limits
		if (newx > 0) and (newx < cw) and (newy > 0) and (newy < ch) then
			transition.to( car.on_display, {time = 700, x = newx, y = newy})
			--if (car.acc_rate < car.max_acc_rate) then car.acc_rate = car.acc_rate + 1 end
			res = 0
		else
			print( "Leaving street" )
			res = 1
		end
	else
		print("Not available")
		--car.acc_rate = 1
		res = 0
	end

	return res
end

function isCarAvailableToMove( car )
	for i=1, car.in_street.street_group.numChildren, 1 do
		local child = car.in_street.street_group[i]
		local pos_sensor

		if (car.on_display ~= child) then
			print("Entrando a verificar")
			-- If the street is vertical
			if (car.in_street.orientation > 0) and (child.y ~= car.on_display.y) then
				pos_sensor = car.on_display.y + (car.in_street.direction * car.sensor)

				-- If the street goes from the top to the bottom
				if (car.in_street.direction > 0) and (child.y > car.on_display.y) then -- check if child is in front
					if (pos_sensor > child.y) then	-- check if sensor has already met or passed child's center
						return false
					end
				-- If the street ges from the bottom to the top
				elseif (car.in_street.direction < 0) and (child.y <= car.on_display.y) then -- check if child is in front
					if (pos_sensor < child.y) then	-- check if sensor has already met or passed child's center
						return false
					end
				end

			-- If the street is horizontal
			elseif (car.in_street.orientation < 0) and (child.x ~= car.on_display.x) then
				pos_sensor = car.on_display.x + (car.in_street.direction * car.sensor)

				-- If the street goes from left to right
				if (car.in_street.direction > 0) and (child.x > car.on_display.x) then	-- check if child is in front
					if (pos_sensor >= child.x) then 	-- check if sensor has already met or passed child's center
						return false
					end
				-- If the street goes from right to left
				elseif (car.in_street.direction < 0) and (child.x < car.on_display.x) then -- check if child is in front
					if (pos_sensor < child.x) then	-- check if sensor has already met or passed child's center
						return false
					end
				end
			end
		end
	end

	return true
end