module(..., package.seeall)

function newLight( i, street )
	o = {
		index = i,
		in_street = nil,
		on_display = nil,
		on_wait = display.newGroup()
	}

	return o
end

function changeToG( tl )
    tl.on_display:setFillColor( 0, 1, 0)
    tl.in_street.street_group:remove( tl.on_display )
    tl.on_wait:insert( tl.on_display )
end

function changeToR( tl )
	tl.on_display:setFillColor( 1, 0, 0 )
	tl.on_wait:remove( tl.on_display )
	tl.in_street.street_group:insert( tl.on_display )
end

function changeToY( tl )
	tl.on_display:setFillColor( 1, 1, 0 )
end