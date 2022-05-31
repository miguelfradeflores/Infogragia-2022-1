
module(..., package.seeall)

print("Iniciando archivo")

function crear_score( posx, posy)
	
	local puntos = 0
	local score = display.newText( "SCORE: " .. puntos, posx+40, posy, "ARCADE_N.TTF", 20)
	score.anchorY = 0; score.anchorX =0.5


	return score
end
function crear_scoreB( posx, posy)
	
	local cant_toc = 0
	local scoreB = display.newText( " "..cant_toc, posx, posy, "ARCADE_N.TTF", 30)
	scoreB.anchorY = 0; scoreB.anchorX =0.5
	


	return scoreB
end
function crear_scoreM( posx, posy)
	
	local cant_mal = 0
	local scoreM = display.newText( " "..cant_mal, posx, posy, "ARCADE_N.TTF", 30)
	scoreM.anchorY = 0; scoreM.anchorX =0.5


	return scoreM
end

function describir()

	print( "algo" )
end