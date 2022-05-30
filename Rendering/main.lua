-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

--deberías implementar el scanLine rendering, 
--variando con los métodos del "painter's algorithym" y el "z-buffering"

cw = display.contentWidth 
ch = display.contentHeight

negro = {0,0,0}
blanco = {255,255,255}

-- fondo = display.newRect(0, 0, cw, ch)
-- fondo.anchorX = 0 ; fondo.anchorY = 0
-- fondo:setFillColor( 49 /255, 158/255, 163/255 )

local trianguloUno = {{20,180},{40,40},{80,120}}


-- local function crearObjeto(event)
--     local params = event.source.params

--     circ = display.newCircle(params.pol[params.j][1], params.pol[params.j][2], params.rad)
--     circ:setFillColor(unpack(blanco))
-- end



dens = 20

local function crearObjeto(pol, rad)
    
    for j=1,#pol do
       
        circ = display.newCircle(pol[j][1], pol[j][2], 10)
        circ:setFillColor(unpack(blanco))
        --transition.to(circ,{time = 1000})
    end
end

crearObjeto(trianguloUno, 200/dens )

-- function animarPuntos(poligono, dens)
--     len = # poligono
--     for i=1, len do
--         while(runed) do
--             local tm = timer.performWithDelay( 1000, crearObjeto )
--             tm.params = { pol = poligono, rad = 200/dens , j=i}
--         end
--     end
-- end
-- print("largo tri: ",#trianguloUno)

-- animarPuntos(trianguloUno,dens)

awc = cw/dens
ahc = ch/dens

for i=0, dens do
	display.newLine(0, i*(ahc), cw, i*(ahc) )
end

for i=0, dens do
	display.newLine(i*(awc), 0, i*(awc), ch )
end

-- frente = display.newRect(awc*8, ahc*5, awc*5, ahc)
-- frente:setFillColor( unpack( negro) )
-- frente.anchorX = 0; frente.anchorY=0

function limites(polig)
    ymax = 0
    ymin = polig[1][2]
    val = {ymax,ymin}    
    for i=1, #polig do
        if polig[i][2] > ymax then
            ymax = polig[i][2]
        end
    end
    --print("YMAX: ",ymax)
    for i=1, #polig do
        if polig[i][2] < ymin then
            ymin = polig[i][2]
        end
    end
    --print("YMIN: ",ymin)
    return val
end

ar = limites(trianguloUno)
