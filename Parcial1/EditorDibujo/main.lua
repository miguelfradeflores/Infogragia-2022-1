-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local cw,ch
cw = display.contentWidth
ch = display.contentHeight
-- Colores
gris={146/255,141/255,140/255}
negro={0,0,0}
rojo={1,0,0}
amarillo={1,1,0}
verde={0,223/255,0}
cian={0,1,1}
magenta={1,0,1}
azul={0,0,1}

Backcolor={1,1,1,1}

local canvas = display.newRect(0,0,cw,ch)
canvas.anchorX=0;canvas.anchorY=0
canvas:setFillColor(unpack(Backcolor))

-- Edition setings
local idTool = 0 
local strok=5
local eraStrok=30
local baseColor={1,0,0}
-- Grupo de dibujos
local grp_drawings=display.newGroup()
local moveRectP3

-- Elementos del menu
menuBar = display.newRoundedRect( 20,ch/8,cw/15, (ch/8)*6,10)
menuBar:setFillColor(146/255,141/255,140/255,0.6)
menuBar.anchorX=0;menuBar.anchorY=0

-- Paleta de colores
colorBox = display.newRoundedRect(cw-20,10,(cw/15)*5,cw/15*1.5,10)
colorBox:setFillColor(146/255,141/255,140/255,0.6)
colorBox.anchorX=1;colorBox.anchorY=0

iconsIm = {"pencil.png","eraser.png","square.png","dotted-circle.png","triangle.png"}
-- menu actions
function selectTool(self,event)
	if event.phase == "ended" then
		idTool=self.id
		print(idTool)
	end
	return
end

local icons = {}
for i,v in ipairs(iconsIm) do
	icons[i] = display.newImageRect(v,50,50)
	icons[i].anchorX=1;icons[i].anchorY=1
	icons[i].x=menuBar.x+60;icons[i].y=menuBar.y+70*i
	icons[i].path.width = 50
	icons[i].touch = selectTool
	icons[i]:addEventListener("touch",icons[i])
	icons[i].id = i
end
-- Paleta de colores
function selColor(self,event)
	if event.phase == "ended" then
		baseColor = self.color
		print("entrado")
	end
	return
end
local colors = {negro,rojo,amarillo,verde,azul,cian,magenta,gris}
colorCells={}
for i,v in ipairs(colors) do
	colorCells[i] = display.newRect(colorBox.x-(cw/15)*5+41*i,cw/15*1.5-12,35,35)
	colorCells[i]:setFillColor(unpack(v))
	colorCells[i].anchorX=1;colorCells[i].anchorY=0.5
	colorCells[i].color=v
	colorCells[i].touch = selColor
	colorCells[i]:addEventListener("touch",colorCells[i])
end

-- Alter rectangle
function moveRectP3(rect,xo,yo,x,y)
	rect.path.x3=x-xo
	rect.path.y3=y-yo

	rect.path.x4=x-xo
	rect.path.y2=y-yo
end
function alterRadius(circ,xo,yo,xi,yi)
	x=math.pow(xi-xo,2)
	y=math.pow(yi-yo,2)
	circ.path.radius = math.sqrt(x+y)
end

-- Canva actions
function canvas:touch(event)
	-- Caso lapiz
	if(idTool==1) then
		if event.phase=="began" then
			x1 = event.x
			y1 = event.y
			line = display.newLine(grp_drawings,x1,y1,event.x,event.y)
			line.strokeWidth=strok
			line:setStrokeColor(unpack(baseColor))
		end
		if(event.phase== "moved") then
			line:append(event.x,event.y)
		end
		return
	elseif (idTool==2) then
		if event.phase=="began" then
			x1 = event.x
			y1 = event.y
			line = display.newLine(grp_drawings,x1,y1,event.x,event.y)
			line.strokeWidth=eraStrok
			line:setStrokeColor(unpack(Backcolor))		
		end
		if(event.phase== "moved") then
			line:append(event.x,event.y)
		end
		return
	elseif (idTool==3) then
		if event.phase=="began" then
			x1 = event.x
			y1 = event.y
			cuadrado = display.newRect(grp_drawings,x1,y1,50,50)
			cuadrado.strokeWidth=strok
			cuadrado:setStrokeColor(unpack(baseColor))
			cuadrado:setFillColor(unpack(Backcolor))
			cuadrado.anchorX = 1 ; cuadrado.anchorY=1
		end
		if(event.phase== "moved") then
			moveRectP3(cuadrado,x1,y1,event.x,event.y)
		end
		return
	elseif (idTool==4) then
		if event.phase=="began" then
			x1 = event.x
			y1 = event.y
			circulo = display.newCircle(grp_drawings,x1,y1,5)
			circulo.strokeWidth=strok
			circulo:setStrokeColor(unpack(baseColor))
			circulo:setFillColor(unpack(Backcolor))
			circulo.anchorX = 0 ; circulo.anchorY=0
		end
		if(event.phase== "moved") then
			alterRadius(circulo,x1,y1,event.x,event.y)
		end
		return
	elseif (idTool==5) then
		if event.phase=="began" then
			x1 = event.x
			y1 = event.y
			vertex = {0,18 ,24,18 ,12,0}
			triangulo = display.newPolygon(grp_drawings,x1,y1,vertex)
			triangulo.strokeWidth=strok
			triangulo:setStrokeColor(unpack(baseColor))
			triangulo:setFillColor(unpack(Backcolor))
			triangulo.anchorX = 0.5 ; triangulo.anchorY=0.5
		end
		if(event.phase== "moved") then
			if x1 > cw/2 then
				triangulo.xScale = (x1/event.x)*6
			else
				triangulo.xScale = (event.x/x1)*6
			end
			if y1 > ch/2 then
				triangulo.yScale = (y1/event.y)*6
			else
				triangulo.yScale = (event.y/y1)*6
			end
			Tstroke = math.max(triangulo.strokeWidth/math.log10(triangulo.xScale+triangulo.yScale),1)
			if Tstroke <= strok then
				triangulo.strokeWidth = Tstroke
			end
		end
		return
	end

	return
end

canvas:addEventListener("touch",canvas)
