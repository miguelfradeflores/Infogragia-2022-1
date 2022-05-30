-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

cw = display.contentWidth
ch = display.contentHeight

local grupo_background, grupo_intermedio, grupo_delantero, grupo_astros

grupo_background = display.newGroup()
grupo_intermedio = display.newGroup()
grupo_delantero = display.newGroup()
grupo_astros = display.newGroup()

grupo_intermedio.isVisible = false
grupo_delantero.isVisible = true
grupo_astros.isVisible = false

local random = true

-------IMPPORTANTE
display.setDefault( "isAnchorClamped", false )

fondo = display.newImageRect("/Imagenes/Fondo.jpg", cw, ch)
fondo.x = 0;
fondo.y = 0
fondo.anchorX = 0
fondo.anchorY = 0

grupo_background:insert(fondo)

titulo = display.newImageRect("/Imagenes/titulo.png", 350,350)
titulo.x = -15;
titulo.y = 10
titulo.anchorX = 0
titulo.anchorY = 0
grupo_background:insert(titulo)

--Sol
sol=display.newImageRect(grupo_intermedio, "/Imagenes/Sol.png", 40,40)
sol.x = cw/2; sol.y = ch/2
sol.rotation=90

--Planetas

mercurio=display.newImageRect(grupo_intermedio, "/Imagenes/Mercurio.png", 20,20)
mercurio.x = cw/2; mercurio.y = ch/2
mercurio.r=30; mercurio.t=2
mercurio.ro={-1,1,1.5,1.5,1,-1,-0.8,0}

venus=display.newImageRect(grupo_intermedio, "/Imagenes/Venus.png", 20,20)
venus.x = cw/2; venus.y = ch/2
venus.r=50; venus.t=3
venus.ro={-1.7,1.7,2.3,2.3,2.3,-1.3,-1.3,-1.3}

tierra=display.newImageRect(grupo_intermedio, "/Imagenes/Tierra.png", 20,20)
tierra.x = cw/2; tierra.y = ch/2
tierra.r=70; tierra.t=4 
tierra.ro={-2.4,2.4,3,3,2.9,-1.9,-1.9,-1.9}

marte=display.newImageRect(grupo_intermedio, "/Imagenes/Marte.png", 15,10)
marte.x = cw/2; marte.y = ch/2
marte.r=90; marte.t=5
marte.ro={-4.8,4.8,5.5,5.5,5.1,-5.1,-4.6,-4.6}

jupiter=display.newImageRect(grupo_intermedio, "/Imagenes/Jupiter.png", 30,30)
jupiter.x = cw/2; jupiter.y = ch/2
jupiter.r=110; jupiter.t=6
jupiter.ro={-2.6,2.6,3.1,3.1,2.5,-2.5,-2.1,-2.1}

saturno=display.newImageRect(grupo_intermedio, "/Imagenes/Saturno.png", 30,20)
saturno.x = cw/2; saturno.y = ch/2
saturno.r=130; saturno.t=7
saturno.ro={-3.4,3.4,4.1,4.1,3.8,-3.8,-3.1,-3.1}

urano=display.newImageRect(grupo_intermedio, "/Imagenes/Urano.png", 20,20)
urano.x = cw/2; urano.y = ch/2
urano.r=150; urano.t=8
urano.ro={-5.1,5.4,5.8,5.8,5.3,-5.3,-4.8,-4.8}


--orbitas
gris = {125/255,120/255,107/255}
borde = {0,0,0,0}

myCircle1 = display.newCircle(grupo_astros,cw/2,ch/2,30)
myCircle1:setFillColor(unpack(borde))
myCircle1.strokeWidth = 1
myCircle1:setStrokeColor(unpack(gris))

myCircle2 = display.newCircle(grupo_astros,cw/2,ch/2,50)
myCircle2:setFillColor(unpack(borde))
myCircle2.strokeWidth = 1
myCircle2:setStrokeColor(unpack(gris))

myCircle3 = display.newCircle(grupo_astros,cw/2,ch/2,70)
myCircle3:setFillColor(unpack(borde))
myCircle3.strokeWidth = 1
myCircle3:setStrokeColor(unpack(gris))

myCircle4 = display.newCircle(grupo_astros,cw/2,ch/2,90)
myCircle4:setFillColor(unpack(borde))
myCircle4.strokeWidth = 1
myCircle4:setStrokeColor(unpack(gris))

myCircle5 = display.newCircle(grupo_astros,cw/2,ch/2,110)
myCircle5:setFillColor(unpack(borde))
myCircle5.strokeWidth = 1
myCircle5:setStrokeColor(unpack(gris))

myCircle6 = display.newCircle(grupo_astros,cw/2,ch/2,130)
myCircle6:setFillColor(unpack(borde))
myCircle6.strokeWidth = 1
myCircle6:setStrokeColor(unpack(gris))

myCircle7 = display.newCircle(grupo_astros,cw/2,ch/2,150)
myCircle7:setFillColor(unpack(borde))
myCircle7.strokeWidth = 1
myCircle7:setStrokeColor(unpack(gris))


--Botones intercativos con el usuario
pausa=display.newImageRect(grupo_intermedio, "/Imagenes/pausa.png",18,18)
pausa.x = cw/2-15; pausa.y = ch-70
play=display.newImageRect(grupo_intermedio, "/Imagenes/play.png",21,21)
play.x = cw/2+15; play.y = ch-70

local myCircle
function creacion_orbitas()
    for i=30, 160,20 do
        myCircle = display.newCircle(grupo_astros,cw/2,ch/2, i)
        myCircle:setFillColor(0,0,0,0 )
        myCircle.strokeWidth = 1
        myCircle:setStrokeColor(125/255,120/255,107/255)
    end
    
end

opciones_texto = {
	text = "Hola mundo!",
	x = cw/2,
	y= ch/2+60,
	font = font_default,
	fontSize = 20

}

--Boton inicio
inicio = display.newText(opciones_texto)
inicio.font = "Arial Black"
inicio.text = "Start"
grupo_delantero:insert(inicio)

opciones_texto.x = cw/2
opciones_texto.y = ch-40
restore = display.newText(opciones_texto)
restore.font = "Arial Black"
restore.text = "Restore"
grupo_intermedio:insert(restore)

function detenidos(planeta)
    transition.to(planeta,{anchorX=0.5,anchorY=0.5, time=1000})
end   

function traslacion(planeta)
    transition.to(planeta,{rotation=3060, time=1000000, delay=1000, tag= "objeto",onPause= detenidos(planeta)})
end

function rand_anchor(planeta)
    rand=math.random(1,4)
    if(rand==1) then
        x=planeta.ro[1]
        y=planeta.ro[2]
    elseif (rand==2)then
        x=planeta.ro[3]
        y=planeta.ro[4]
    elseif (rand==3) then
        x=planeta.ro[5]
        y=planeta.ro[6]
    elseif (rand==4) then
        x=planeta.ro[7]
        y=planeta.ro[8]
    end
    return {x,y}
end

function mover(planeta)
    puntos = rand_anchor(planeta)
    transition.to(planeta,{anchorX=puntos[1], anchorY=puntos[2], time=1000, onComplete=traslacion(planeta)})    
end

function big_bang()
    mover(mercurio)
    mover(venus)
    mover(tierra)
    mover(marte)
    mover(jupiter)
    mover(saturno)
    mover(urano)
end

function inicio:touch(e)
    if e.phase == "ended" then
        if grupo_intermedio.isVisible then
            grupo_intermedio.isVisible = false
        else
            grupo_intermedio.isVisible = true
            grupo_delantero.isVisible = false
            grupo_astros.isVisible=true

            big_bang()
            transition.to(sol,{rotation=18000, time=1000000})
            print(mercurio.x)
            transition.to(titulo,{x=cw/5,y=-15,width=200,height=110, time=1000})
            grupo_astros:toBack()
            grupo_background:toBack()
        end
    end
    return true
end
inicio:addEventListener( "touch", inicio)

function pausa:touch(e)
    print("evento stop")
    if e.phase == "ended" then
        transition.pause("objeto")
        transition.pause(sol)
        transition.to(mercurio,{anchorX=0.5,anchorY=0.5, time=3000})
        transition.to(venus,{anchorX=0.5,anchorY=0.5, time=3000})
        transition.to(tierra,{anchorX=0.5,anchorY=0.5, time=3000})
        transition.to(marte,{anchorX=0.5,anchorY=0.5, time=3000})
        transition.to(jupiter,{anchorX=0.5,anchorY=0.5, time=3000})
        transition.to(saturno,{anchorX=0.5,anchorY=0.5, time=3000})
        transition.to(urano,{anchorX=0.5,anchorY=0.5, time=3000})
    end
end
pausa:addEventListener("touch",pausa)

function play:touch(e)
    if(e.phase) then
        big_bang()
        transition.to(sol,{rotation=18000, time=1000000})
        print(mercurio.x)
    end
end    
play:addEventListener("touch",play)

function prueba(planeta)  transition.to(planeta,{rotation=10, time=9000}) end

function tierra:touch(e)  tierra.isVisible=false myCircle3.isVisible=false end
function mercurio:touch(e) mercurio.isVisible=false myCircle1.isVisible=false end
function venus:touch(e)  venus.isVisible=false myCircle2.isVisible=false end
function marte:touch(e) marte.isVisible=false myCircle4.isVisible=false end
function jupiter:touch(e)  jupiter.isVisible=false myCircle5.isVisible=false end
function urano:touch(e) urano.isVisible=false myCircle7.isVisible=false end
function saturno:touch(e) saturno.isVisible=false myCircle6.isVisible=false end
function sol:touch(e) sol.isVisible= false end

tierra:addEventListener("touch",tierra)
mercurio:addEventListener("touch",mercurio)
venus:addEventListener("touch",venus)
marte:addEventListener("touch",marte)
jupiter:addEventListener("touch",jupiter)
saturno:addEventListener("touch",saturno)
urano:addEventListener("touch",urano)
sol:addEventListener("touch",sol)

function restore:touch(e) 
    tierra.isVisible=true; myCircle3.isVisible=true
    mercurio.isVisible=true; myCircle1.isVisible=true 
    venus.isVisible=true; myCircle2.isVisible=true
    marte.isVisible=true; myCircle4.isVisible=true
    jupiter.isVisible=true; myCircle5.isVisible=true
    urano.isVisible=true; myCircle7.isVisible=true
    saturno.isVisible=true; myCircle6.isVisible=true
    sol.isVisible=true
end
restore:addEventListener("touch",restore)



