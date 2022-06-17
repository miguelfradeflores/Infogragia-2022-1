module(..., package.seeall)

function newLight( i, posx, posy, street, crossw )
	tl = display.newCircle( posx, posy, 5 )
	tl.in_street = street
	tl.crossw = crossw

	return tl
end

function changeToG( tl )
    tl:setFillColor( 0, 1, 0)
    tl.crossw.color = "green"
    --tl.in_street.street_group:remove( tl.on_display )
    --tl.on_wait:insert( tl.on_display )
end

function changeToR( tl )
	tl:setFillColor( 1, 0, 0 )
	tl.crossw.color = "red"
	--tl.on_wait:remove( tl.on_display )
	--tl.in_street.street_group:insert( tl.on_display )
end

function changeToY( tl )
	tl:setFillColor( 1, 1, 0 )
	tl.crossw.color = "yellow"
end
