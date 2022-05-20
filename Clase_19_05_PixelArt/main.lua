-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
cw = display.contentWidth
ch = display.contentHeight

fondo = display.newRect(0, 0, cw, ch)
fondo.anchorX = 0 ; fondo.anchorY = 0
fondo:setFillColor( 49 /255, 158/255, 163/255 )

negro = {0,0,0}
blanco = {1,1,1}
rosado = {240/255, 130/255, 180/255}
pelaje = {231/255, 183/255,111/255}
detalles = {176/255,120/255,34/255}


awc = cw/21
ahc = ch/21

for i=0, 21 do
	display.newLine(0, i*(ahc), cw, i*(ahc) )
end

for i=0, 21 do
	display.newLine(i*(awc), 0, i*(awc), ch )
end



frente = display.newRect(awc*8, ahc*5, awc*5, ahc)
frente:setFillColor( unpack( negro) )
frente.anchorX = 0; frente.anchorY=0

function crearOreja( posX, posY )
	oreja = display.newRect( posX, posY, awc, ahc*2)
	oreja:setFillColor( unpack(rosado) )
	oreja.anchorX = 0
end

crearOreja(awc*6, ahc*6)
crearOreja(awc*14, ahc*6)

raya_frente_medio = display.newRect(awc*10, ahc*6, awc, ahc*2)
raya_frente_medio.anchorY = 0; raya_frente_medio.anchorX=0
raya_frente_medio:setFillColor( unpack(detalles) )

raya_frente_izq = display.newRect(awc*8, ahc*6, awc, ahc*1)
raya_frente_izq.anchorY=0; raya_frente_izq.anchorX=0
raya_frente_izq:setFillColor(unpack(detalles))

raya_frente_der = display.newRect(awc*12, ahc*6, awc, ahc*1)
raya_frente_der.anchorY=0; raya_frente_der.anchorX=0
raya_frente_der:setFillColor(unpack(detalles))

function bordeNegroPixel( x, y , ax, ay )
	pixelN = display.newRect(x, y, awc + ax, ahc + ay)
	pixelN:setFillColor(0,0,0)
	pixelN.anchorX = 0 ; pixelN.anchorY = 0
end

borde = bordeNegroPixel(awc*7,ahc*4, 0 , 0)
borde = bordeNegroPixel(awc*6,ahc*3, 0 , 0)
borde = bordeNegroPixel(awc*5,ahc*4, 0 , 0)

borde = bordeNegroPixel(awc*13,ahc*4, 0 , 0)
borde = bordeNegroPixel(awc*14,ahc*3, 0 , 0)
borde = bordeNegroPixel(awc*15,ahc*4, 0 , 0)

function bigoteH( x,y)
	bigote = display.newRect( x,y, awc*3, ahc)
	bigote:setFillColor( unpack(negro) )
	bigote.anchorX=0; bigote.anchorY =0 
end

bigoteH(awc*1, ahc*11 )
bigoteH(awc*1, ahc*13 )

bigoteH(awc*17, ahc*11 )
bigoteH(awc*17, ahc*13 )

function crearOjo(posx, posy) 
	ojo = display.newRect(posx, posy, awc, ahc*3)
	ojo:setFillColor(unpack(negro))
	ojo.anchorX = 0
end
crearOjo(awc*7, ahc*10)
crearOjo(awc*13, ahc*10)

