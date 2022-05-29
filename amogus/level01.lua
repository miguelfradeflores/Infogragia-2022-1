local composer = require("composer")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local grupo_background, grupo_intermedio, grupo_delantero, atrasText, scoreText, startText, aim
grupos = { grupo_background, grupo_intermedio, grupo_delantero }
local puntos = 0

local manzanas = {}
local cantidad_de_manzanas = 10

local function createText(text, x, y, size)
	text = display.newText(text, x, y, "arial", size)
	return text
end

function followAim(event)
	if (event.phase == "began") then

	elseif (event.phase == "moved") then
		--aim.isVisible = true
		aim.x = event.x
		aim.y = event.y
	elseif (event.phase == "ended") then

	end
end

function destruirManzana(self, event)
	if event.phase == "ended" then
		puntos = puntos + 1
		scoreText.text = "Destroyed: " .. puntos
		self:removeSelf()
	end
	return true
end

local function hideApple(self)
	self.isVisible = false
end

function crearManzanas()
	scoreText.isVisible = true
	startText.isVisible = false

	for i = 1, cantidad_de_manzanas, 1 do
		manzanas[i] = display.newImageRect("images/mathias/f1.png", 50, 50)
		manzanas[i].x = fondo.width * 1.5
		manzanas[i].y = math.random(ch / 2 - fondo.height / 2, ch / 2 + fondo.height / 2)

		manzanas[i].touch = destruirManzana
		manzanas[i]:addEventListener("touch", manzanas[i])
		manzanas[i].se_puede_matar = true

		posx = (cw / 2 - fondo.width / 2) - manzanas[i].width / 2
		posy = math.random(0, ch)
		grupo_intermedio:insert(manzanas[i])
		manzanas[i].transition = transition.to(manzanas[i], { time = 5000, x = posx, y = posy, onComplete = hideApple, tag = "movimiento" })

	end
end

function atras(e)
	if e.phase == "ended" then
		composer.gotoScene("title", "slideRight", 2000)
	end
	return
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create(event)

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	grupo_background = display.newGroup()
	grupo_intermedio = display.newGroup()
	grupo_delantero = display.newGroup()

	sceneGroup:insert(grupo_intermedio)
	sceneGroup:insert(1, grupo_background)
	sceneGroup:insert(grupo_delantero)

	fondo = display.newImageRect("images/mathias/1.jpg", cw * 0.5, ch * 0.8)
	fondo.x = cw / 2;
	fondo.y = ch / 2

	--aim = display.newImageRect("images/mathias/aim.png", 70, 70)
	--aim.x = cw/2; aim.y = ch/2
	--aim:addEventListener( "touch", followAim)
	--aim.isVisible = false

	atrasText = createText("ATRAS", 0, 0, 50)
	atrasText:addEventListener("touch", atras)
	atrasText.isVisible = false

	puntos = 0
	scoreText = createText("Destroyed: 0", cw * 0.5, ch * 0.8, 50)
	scoreText.isVisible = false

	startText = createText("START", cw / 2, ch / 2, 50)
	startText:addEventListener("touch", crearManzanas)
	startText.isVisible = false

	grupo_background:insert(fondo)
end

function scene:show(event)

	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

		-- scoreText.text = "SCORE: 0"


	elseif (phase == "did") then
		-- Code here runs when the scene is entirely on screen
		atrasText.isVisible = true
		startText.isVisible = true


		print("cantidad_de_manzanas_del_nivel ", cantidad_de_manzanas)
		--crearManzanas(cantidad_de_manzanas, 50,50)
	end
end

function scene:hide(event)

	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		atrasText.isVisible = false

		scoreText.isVisible = false
		scoreText.text = "Destroyed: 0"

		for i = grupo_intermedio.numChildren, 1, -1 do
			grupo_intermedio[i]:removeSelf()
			grupo_intermedio[i] = nil
		end
	elseif (phase == "did") then
		-- Code here runs immediately after the scene goes entirely off screen
	end
end

-- destroy()
function scene:destroy(event)

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
-- -----------------------------------------------------------------------------------

return scene

