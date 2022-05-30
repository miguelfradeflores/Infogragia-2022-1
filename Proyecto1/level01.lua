local composer = require("composer")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local grupo_background, grupo_intermedio, grupo_delantero, backText, scoreText, startText, score, count
grupos = { grupo_background, grupo_intermedio, grupo_delantero }
local fireSound = audio.loadStream("sounds/level01/fire.mp3")
local explosionSound = audio.loadStream("sounds/level01/explosion.mp3")

local function createText(text, x, y, size)
	text = display.newText(text, x, y, "arial", size)
	return text
end

local function playSound()
	if startText.isVisible == false then
		audio.play(fireSound)
	end
end

function destoryMeteor(self, event)
	local x,y
	if event.phase == "ended" then
		audio.play(explosionSound)
		score = score + 1
		scoreText.text = "Destroyed: " .. score
		x = self.x
		y = self.y
		self:removeSelf()

		explosion = display.newImageRect("images/mathias/level01/weaponsExplosion.png", 70, 70)
		explosion.x = x
		explosion.y = y
		transition.fadeOut(explosion, { time = 1650,  })

		if score == 10 then
			audio.play(completedTaskSound)
			taskCompletedText.isVisible = true
			scoreText.isVisible = false
		end
	end
	return true
end

local function hideMeteor(self)
	self.isVisible = false
	count = count + 1
	if count == 10 then
		backText.isVisible = true
	end
end

local function createMeteor( i )
	meteor = display.newImageRect("images/mathias/level01/weaponsMeteor.png", 70, 70)
	meteor.x = background.width * 1.25
	meteor.y = math.random(ch / 2 - background.height / 2, ch / 2 + background.height / 2)

	meteor.touch = destoryMeteor
	meteor:addEventListener("touch", meteor)

	posx = (cw / 2 - background.width / 2)
	posy = math.random(0, ch)
	grupo_intermedio:insert(meteor)
	transition.to(meteor, { time = 1650, x = posx, y = posy, onComplete = hideMeteor })
end

function createMeteors()
	scoreText.isVisible = true
	startText.isVisible = false
	backText.isVisible = false
	score = 0
	count = 0

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

	background = display.newImageRect("images/mathias/level01/weaponsScreen.png", cw * 0.6, ch * 0.75)
	background.x = cw / 2;
	background.y = ch / 2
	background:addEventListener("touch", playSound)

	backText = createText("BACK", 0, 30, 50)
	backText:addEventListener("touch", atras)
	backText.isVisible = false

	scoreText = createText("Destroyed: 0", cw / 2, ch*0.94, 80)
	scoreText.isVisible = false

	startText = createText("START", cw / 2, ch / 2, 50)
	startText:addEventListener("touch", createMeteors)
	startText.isVisible = false

	taskCompletedText = createText("Task Completed!", cw / 2, ch*0.94, 80)
	taskCompletedText.isVisible = false

	grupo_background:insert(background)
end

function scene:show(event)

	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		-- Code here runs when the scene is still off screen (but is about to come on screen)
		audio.play(startTaskSound)
	elseif (phase == "did") then
		-- Code here runs when the scene is entirely on screen
		backText.isVisible = true
		startText.isVisible = true
	end
end

function scene:hide(event)

	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		backText.isVisible = false
		startText.isVisible = false
		taskCompletedText.isVisible = false
		scoreText.isVisible = false
		scoreText.text = "Destroyed: 0"

		audio.play(closeTaskSound)

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

