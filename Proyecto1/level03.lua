local composer = require("composer")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local grupo_background, grupo_intermedio, grupo_delantero, backText, startText, taskCompletedText, activatedCount
grupos = { grupo_background, grupo_intermedio, grupo_delantero }
local availableNumbers = {}
local correctSound = audio.loadStream("sounds/level03/correctNumber.mp3")
local incorrectSound = audio.loadStream("sounds/level03/incorrectNumber.mp3")

local function createText(text, x, y, size)
	text = display.newText(text, x, y, "arial", size)
	return text
end

local function toggleShield(self, event)
	if event.phase == "began" then
        if self.activated == false and self.number == activatedCount+1 then
            audio.play(correctSound)

            self:setFillColor(0,1,0)
            self.activated = true
            activatedCount = activatedCount + 1
        else
            audio.play(incorrectSound)
        end
        if activatedCount == 10 then
            audio.play(completedTaskSound)
            taskCompletedText.isVisible = true
        end
	end
	return true
end

local function randomNumber()
    continue = true
    while continue do
        n = math.random(1,10)
        if n == availableNumbers[n] then
            availableNumbers[n] = 0
            continue = false
        end
    end
    return n
end

local function createNumberPad()
    startText.isVisible = false

    local height = reactorScreen.height*1/2
    local width = reactorScreen.width*1/5
    local x = reactorScreen.x-reactorScreen.width/2
    local y = reactorScreen.y-reactorScreen.height/2-10
    activatedCount = 0
    
    for i=1, 10, 1 do
        availableNumbers[i] = i
    end
    
    for i=1, 5, 1 do
        n = randomNumber()
		numberpad = display.newImageRect("images/mathias/level03/reactor" .. n .. ".png", width, height)
        numberpad.anchorX = 0
        numberpad.anchorY = 0
        numberpad.x = x
        numberpad.y = y
        numberpad.activated = false
        numberpad.number = n
        numberpad.touch = toggleShield
        numberpad:addEventListener("touch", numberpad)
        grupo_intermedio:insert(numberpad)

        x = x + width
	end	

    x = reactorScreen.x-reactorScreen.width/2
    for i=1, 5, 1 do
        n = randomNumber()
		numberpad = display.newImageRect("images/mathias/level03/reactor" .. n .. ".png", width, height)
        numberpad.anchorX = 0
        numberpad.anchorY = 0
        numberpad.x = x
        numberpad.y = y*2
        numberpad.activated = false
        numberpad.number = n
        numberpad.touch = toggleShield
        numberpad:addEventListener("touch", numberpad)
        grupo_intermedio:insert(numberpad)

        x = x + width
	end
    return true
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

	reactorBackground = display.newImageRect("images/mathias/level03/reactorBackground.png", cw, ch * 0.7)
	reactorBackground.x = cw / 2;
	reactorBackground.y = ch / 2

    reactorScreen = display.newImageRect("images/mathias/level03/reactorScreen.png", reactorBackground.width*6.7/8, reactorBackground.height*5.5/8)
    reactorScreen.x = cw / 2
    reactorScreen.y = ch / 2+5

	backText = createText("BACK", 0, 30, 50)
	backText:addEventListener("touch", atras)
	backText.isVisible = false

	startText = createText("START", cw / 2, ch / 2, 50)
	startText:addEventListener("touch", createNumberPad)
	startText.isVisible = false

    taskCompletedText = createText("Task Completed!", cw / 2, ch*0.94, 80)
	taskCompletedText.isVisible = false

	grupo_background:insert(reactorBackground)
    grupo_delantero:insert(reactorScreen)
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