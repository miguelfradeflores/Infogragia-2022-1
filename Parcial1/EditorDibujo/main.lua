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
Backcolor={1,1,1,1}

local canvas = display.newRect(0,0,cw,ch)
canvas.anchorX=0;canvas.anchorY=0
canvas:setFillColor(unpack(Backcolor))

-- Edition setings
local idTool = 0 
local strok=5
local eraStrok=30
local baseColor={1,0,0,1}
-- Grupo de dibujos
local grp_drawings=display.newGroup()
local moveRectP3

-- Elementos del menu
menuBar = display.newRoundedRect( 20,ch/8,cw/15, (ch/8)*6,10)
menuBar:setFillColor(146/255,141/255,140/255,0.6)
menuBar.anchorX=0;menuBar.anchorY=0

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
-- Alter rectangle
function moveRectP3(rect,xo,yo,x,y)
	rect.path.x3=x-xo
	rect.path.y3=y-yo

	rect.path.x4=x-xo
	rect.path.y2=y-yo
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
			print("x "..event.x,"y "..event.y)
		end
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
			print("x "..event.x,"y "..event.y)
		end
	elseif (idTool==3) then
		if event.phase=="began" then
			x1 = event.x
			y1 = event.y
			cuadrado = display.newRect(grp_drawings,x1,y1,50,50)
			cuadrado.strokeWidth=Strok
			cuadrado:setStrokeColor(unpack(baseColor))
			cuadrado:setFillColor(unpack(baseColor))
			cuadrado.anchorX = 1 ; cuadrado.anchorY=1
		end
		if(event.phase== "moved") then
			moveRectP3(cuadrado,x1,y1,event.x,event.y)
		end
	elseif (idTool==4) then
		if event.phase=="began" then
			x1 = event.x
			y1 = event.y
			circulo = display.newCircle(grp_drawings,x1,y1,25)
			circulo.strokeWidth=8
			circulo:setStrokeColor(0,0,0)
			circulo:setFillColor(unpack(baseColor))
			circulo.anchorX = 0 ; circulo.anchorY=0
		end
		if(event.phase== "moved") then
			print(event.x)
		end
	end

	return
end

canvas:addEventListener("touch",canvas)

-- cuadrado = display.newRect(cw/2, ch/2,50,50)
-- 			cuadrado.strokeWidth=5
-- 			cuadrado:setStrokeColor(unpack(baseColor))
-- 			cuadrado:setFillColor(unpack(Backcolor))
-- 			cuadrado.anchorX = 0 ; cuadrado.anchorY=0