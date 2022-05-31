-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

cw = display.contentWidth 
ch = display.contentHeight

dens = 15

awc = cw/dens
ahc = ch/dens

negro = {0,0,0}
blanco = {255,255,255}
azul = {0,0,255}

local trianguloUno = {{80,70},{210,120},{50,320}}


local function crearObjeto(pol, rad)
    --print(rad)
    for j=1,#pol do       
        circ = display.newCircle(pol[j][1], pol[j][2], rad)
        circ:setFillColor(unpack(blanco))
        --transition.to(circ,{time = 1000})
    end
end


function lineasTri(polig)
    display.newLine(polig[1][1],polig[1][2],polig[2][1],polig[2][2])
    display.newLine(polig[1][1],polig[1][2],polig[3][1],polig[3][2])
    display.newLine(polig[3][1],polig[3][2],polig[2][1],polig[2][2])
end

for i=0, dens do
	display.newLine(0, i*(ahc), cw, i*(ahc) )
end

for i=0, dens do
	display.newLine(i*(awc), 0, i*(awc), ch )
end

function limites(polig)
    ymax = 0
    ymin = polig[1][2]
     
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
    val = {ymax,ymin}   
    return val
end

--PROBAR INTERSECTION
function lineasInter( dens ,lim)
    med = ahc/2
    lineas = {}
    for i=0, dens do
        y = (i*(ahc)+med)
        --print("LIM Y BND ", lim[1], (y))
        if lim[1] > (y) and lim[2] < (y) then
            lin = display.newLine(0, y, cw, y )
            lin:setStrokeColor(1,0,0)
            y1 = y
            table.insert(lineas , y1)
        end
    end
    -- for j=1,#lineas do
    --     print("LIN", lineas[j])
    -- end
    return lineas
end

function segmentVsSegment(x1, y1, x2, y2, x3, y3, x4, y4)
    local dx1, dy1 = x2 - x1, y2 - y1
    local dx2, dy2 = x4 - x3, y4 - y3
    local dx3, dy3 = x1 - x3, y1 - y3
    local d = dx1*dy2 - dy1*dx2
    if d == 0 then
      return false
    end
    local t1 = (dx2*dy3 - dy2*dx3)/d
    if t1 < 0 or t1 > 1 then
      return false
    end
    local t2 = (dx1*dy3 - dy1*dx3)/d
    if t2 < 0 or t2 > 1 then
      return false
    end
    -- point of intersection
    res = {x1 + t1*dx1, y1 + t1*dy1}
    return res
end

crearObjeto(trianguloUno, awc/2 )

lineasTri(trianguloUno)

lim = limites(trianguloUno)

lineas_dentro = lineasInter(dens,lim)

function pintar_pix(argss)
    pix = math.floor(argss[1]/awc)
    piy = math.floor(argss[2]/ahc)
    pixel = display.newRect(awc*pix, ahc*piy, awc*1, ahc)
    pixel:setFillColor( unpack( blanco) )
    pixel.anchorX = 0; pixel.anchorY=0
    pixel.alpha = 0.8
    return pix
end

function pintar_piy(argss)
    pix = math.floor(argss[1]/awc)
    piy = math.floor(argss[2]/ahc)
    pixel = display.newRect(awc*pix, ahc*piy, awc*1, ahc)
    pixel:setFillColor( unpack( blanco) )
    pixel.anchorX = 0; pixel.anchorY=0
    pixel.alpha = 0.8
    return ahc*piy
end


function limites_polig(lineas_dentro,trianguloUno)
    for i=1,#lineas_dentro do
        limm = {}
        for j=1,2 do
            argss = segmentVsSegment(0, lineas_dentro[i], cw, lineas_dentro[i], 
            trianguloUno[j][1],trianguloUno[j][2],
            trianguloUno[j+1][1],trianguloUno[j+1][2])

            if argss ~= false then
                table.insert( limm,pintar_pix(argss))
            end
        end
        -- if #limm>1 then
        --     mi = math.min( unpack(limm) )
        --     ma = math.max( unpack(limm) )
        --     for j=mi,ma do
        --         pixel = display.newRect(awc*j, pintar_piy(argss), awc*1, ahc)
        --         pixel:setFillColor( unpack( azul) )
        --         pixel.alpha = 0.5
        --         pixel.anchorX = 0; pixel.anchorY=0
        --     end
        -- end        
        
        argss = segmentVsSegment(0, lineas_dentro[i], cw, lineas_dentro[i], 
        trianguloUno[1][1],trianguloUno[1][2],
        trianguloUno[3][1],trianguloUno[3][2])

        if argss ~= false then
            table.insert( limm, pintar_pix(argss))

            if #limm > 1 then
                mi = math.min( unpack(limm) )
                ma = math.max( unpack(limm) )
                for j=mi+1,ma-1 do                    
                    pixel = display.newRect(awc*j, pintar_piy(argss), awc*1, ahc)
                    pixel:setFillColor( unpack( azul) )
                    pixel.alpha = 0.5
                    pixel.anchorX = 0; pixel.anchorY=0
                end
            end

        end

        
        
        
    end

    

    -- for i=1,#lineas_dentro do
    --     print("LINEAS DENTRO:" , lineas_dentro[i])
    -- end
end

limites_polig(lineas_dentro,trianguloUno)

        

        