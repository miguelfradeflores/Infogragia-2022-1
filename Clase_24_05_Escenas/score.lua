
module(..., package.seeall)

print("Iniciando archivo")

function crear_score( posx, posy )
	
	local puntos = 0
	local score = display.newText( "SCORE: " .. puntos, posx, posy, "arial", 30)
	score.anchorY = 0; score.anchorX =0.5


	return score
end

function describir()

	print( "algo" )
end