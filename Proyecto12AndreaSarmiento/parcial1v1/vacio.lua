


local composer = require("composer")
 
local scene = composer.newScene()






function pauseGame(e)
    if e.phase == "began" then

        
    
    elseif e.phase == "ended" then
       

    end
    return
end


function scene:create( event )
 

end
 
 
-- show()
function scene:show( event )
 
    
end
 
 
-- hide()
function scene:hide( event )
 
   
end
 
 
-- destroy()
function scene:destroy( event )
 
    
 
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