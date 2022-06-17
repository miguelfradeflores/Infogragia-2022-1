module(..., package.seeall)

function newCrossWalk( posx, posy, shape, d_text )
    local temp = display.newRect( posx, posy, shape.x, shape.y )
    temp.t = "cross_walk"
    temp.color = "undefined"
    temp.display_text = d_text
    box_body = {
        halfWidth = shape.x/3,
        halfHeight = shape.y/3,
        x = 0,
        y = 0,
        angle = 0
    }
    physics.addBody( temp, "static", {bounce=0, box=box_body} )
    
    local function preCollisionEvent( self, event )
        if ( event.other.noRespect and (self.color == "red") ) then
            new_text = "Car index: "..event.other.index.." passed during red light"
            self.display_text.text = new_text
            self.display_text.alpha = 1
            timer.performWithDelay( 2000, function() self.display_text.alpha = 0 end )

            print(new_text)
        end

        if ( event.other.noRespect or (self.color == "green")
            or (self.color == "yellow") ) then 
            event.contact.isEnabled = false
        end
    end

    temp.preCollision = preCollisionEvent
    temp:addEventListener( "preCollision" )

    return temp
end
