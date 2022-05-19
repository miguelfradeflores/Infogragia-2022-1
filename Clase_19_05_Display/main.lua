-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

cw = display.contentWidth
ch = display.contentHeight


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

circulo = display.newCircle(  cw-50, ch-50, 50 )
circulo.x = cw/2; circulo.y = 50
