-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

cw = display.contentWidth
ch = display.contentHeight

font_default = "The Californication"

print(cw, ch)

acw = display.actualContentWidth
ach = display.actualContentHeight

diferencia_altura = ach - ch


print(acw, ach, diferencia_altura)

display.setStatusBar( display.HiddenStatusBar )


linea = display.newLine(0 ,0 , cw, ch, cw/2, ch, cw/2, ch/2)
linea:append(0, ch/2, cw, ch/2)
linea.strokeWidth = 3
linea:setStrokeColor(1,0,0)
-- linea:setFillColor( 1,0,0  )  -- no disponible para el objeto display.line


cuadrado = display.newRect(cw/2, ch/2, 50, 150)
cuadrado.strokeWidth = 4
cuadrado:setStrokeColor( 0,0, 1 )
cuadrado:setFillColor( 1,1, 0 )
print(cuadrado.anchorX, cuadrado.anchorY)
cuadrado.anchorX = 0 ; cuadrado.anchorY=0.8


circulo = display.newCircle(  cw-50, ch-50, 50 )
circulo.x = cw/2; circulo.y = 0
circulo.anchorY = 0


roundedRect = display.newRoundedRect(cw/2-50,ch-550, 200,250, 53 )
print(roundedRect.path.radius)
roundedRect.path.radius = 30


cuadrado:toFront()

linea:toFront( )

local vertices = { 0,-110, 27,-35, 105,-35, 43,16, 65,90, 0,45, -65,90, -43,15, -105,-35, -27,-35 }

estrella = display.newPolygon( cw/2, ch/2, vertices )
estrella:setFillColor( 0,0,1 )


estrella2 = display.newLine( 0,-110, 27,-35, 105,-35, 43,16, 65,90, 0,45, -65,90, -43,15, -105,-35, -27,-35, 0, -110 )
estrella2.x = cw - cw/4
estrella2.y = ch/2

opciones_texto = {
	text = "Hola mundo!",
	x = cw/2,
	y= ch/4,
	font = font_default,
	fontSize = 50

}


texto = display.newText(opciones_texto)
texto.font = "Arial Black"
score = 50
texto.text = "hola mundo modificado " .. score


icon = display.newImage("Icon.png", cw/2, ch/6)
print(icon.width, icon.height)
-- icon.width = icon.width*2
-- icon.height = icon.height*2
icon.xScale = 2
icon.yScale = 3

fondo = display.newImageRect("lua_code_background.png", cw, ch)
fondo.x = cw/2;  fondo.y = ch/2
fondo:toBack( )
