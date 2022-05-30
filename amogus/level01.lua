local composer = require("composer")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local grupo_background, grupo_intermedio, grupo_delantero, atrasText, scoreText, startText
grupos = { grupo_background, grupo_intermedio, grupo_delantero }
local puntos

local function createText(text, x, y, size)
	text = display.newText(text, x, y, "arial", size)
	return text
end

function destoryMeteor(self, event)
	local x,y
	if event.phase == "ended" then
		puntos = puntos + 1
		scoreText.text = "Destroyed: " .. puntos
		x = self.x
		y = self.y
		self:removeSelf()
		explosion = display.newImageRect("images/mathias/weaponsExplosion.png", 70, 70)
		explosion.x = x
		explosion.y = y
		transition.fadeOut(explosion, { time = 1650,  })

		if puntos == 10 then
			taskCompletedText.isVisible = true
			scoreText.isVisible = false
		end
	end
	return true
end

local function hideMeteor(self)
	self.isVisible = false
end

local function createMeteor( i )
	meteor = display.newImageRect("images/mathias/weaponsMeteor.png", 70, 70)
	meteor.x = fondo.width * 1.25
	meteor.y = math.random(ch / 2 - fondo.height / 2, ch / 2 + fondo.height / 2)

	meteor.touch = destoryMeteor
	meteor:addEventListener("touch", meteor[i])
	meteor.se_puede_matar = true

	posx = (cw / 2 - fondo.width / 2)
	posy = math.random(0, ch)
	grupo_intermedio:insert(meteor)
	transition.to(meteor, { time = 1650, x = posx, y = posy, onComplete = hideMeteor })
end

function createMeteors()
	scoreText.isVisible = true
	startText.isVisible = false
	puntos = 0

	timer.performWithDelay( 500, createMeteor, 10 )
end

function atras(e)
	if e.phase == "ended" then
		composer.gotoScene("title", "crossFade", 500)
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

	fondo = display.newImageRect("images/mathias/weaponsScreen.png", cw * 0.6, ch * 0.75)
	fondo.x = cw / 2;
	fondo.y = ch / 2

	atrasText = createText("BACK", 0, 30, 50)
	atrasText:addEventListener("touch", atras)
	atrasText.isVisible = false

	scoreText = createText("Destroyed: 0", cw / 2, ch*0.94, 80)
	scoreText.isVisible = false

	startText = createText("START", cw / 2, ch / 2, 50)
	startText:addEventListener("touch", createMeteors)
	startText.isVisible = false

	taskCompletedText = createText("Task Completed!", cw / 2, ch*0.94, 80)
	taskCompletedText.isVisible = false

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
	end
end

function scene:hide(event)

	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		atrasText.isVisible = false
		startText.isVisible = false
		taskCompletedText.isVisible = false

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

