local composer = require("composer")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local grupo_background, grupo_intermedio, grupo_delantero, atrasText, startText, taskCompletedText, activatedCounted
grupos = { grupo_background, grupo_intermedio, grupo_delantero }

local function createText(text, x, y, size)
	text = display.newText(text, x, y, "arial", size)
	return text
end

local function toggleShield(self, event)
	if event.phase == "began" then
		self:setFillColor(1,1,1)
        activatedCounted = activatedCounted -1
        if activatedCounted == 0 then
            taskCompletedText.isVisible = true
        end
	end
	return true
end

local function activated(shield)
    res = math.random(1,2)
    if res == 1 and activatedCounted <=4 then   
        activatedCounted = activatedCounted +1
        shield:setFillColor(1,0,0)
    end
end

local function createShieldHex()
    startText.isVisible = false

    local height = ch*0.22
    local width = cw*0.18
    local heightOffset = 15
    local widthOffset = 10
    activatedCounted = 0

    while activatedCounted < 2 do
        activatedCounted = 0

        for i = grupo_intermedio.numChildren, 1, -1 do
			grupo_intermedio[i]:removeSelf()
			grupo_intermedio[i] = nil
		end
        
        centerShield = display.newImageRect("images/mathias/shieldsHexagon.png", width, height)
        centerShield.x = cw/2
        centerShield.y = ch/2
        activated(centerShield)
        centerShield.touch = toggleShield
        centerShield:addEventListener("touch", centerShield)
        grupo_intermedio:insert(centerShield)
        

        upperShield = display.newImageRect("images/mathias/shieldsHexagon.png", width, height)
        upperShield.x = centerShield.x
        upperShield.y = centerShield.y-(height/2)*2-heightOffset
        activated(upperShield)
        upperShield.touch = toggleShield
        upperShield:addEventListener("touch", upperShield)
        grupo_intermedio:insert(upperShield)

        upperLeftShield = display.newImageRect("images/mathias/shieldsHexagon.png", width, height)
        upperLeftShield.x = centerShield.x-(width/2)*2-widthOffset
        upperLeftShield.y = centerShield.y-(height/2) - heightOffset
        activated(upperLeftShield)
        upperLeftShield.touch = toggleShield
        upperLeftShield:addEventListener("touch", upperLeftShield)
        grupo_intermedio:insert(upperLeftShield)

        upperRightShield = display.newImageRect("images/mathias/shieldsHexagon.png", width, height)
        upperRightShield.x = centerShield.x+(width/2)*2+widthOffset
        upperRightShield.y = centerShield.y-(height/2) - heightOffset
        activated(upperRightShield)
        upperRightShield.touch = toggleShield
        upperRightShield:addEventListener("touch", upperRightShield)
        grupo_intermedio:insert(upperRightShield)

        bottomShield = display.newImageRect("images/mathias/shieldsHexagon.png", width, height)
        bottomShield.x = centerShield.x
        bottomShield.y = centerShield.y+(height/2)*2+heightOffset
        activated(bottomShield)
        bottomShield.touch = toggleShield
        bottomShield:addEventListener("touch", bottomShield)
        grupo_intermedio:insert(bottomShield)

        bottomLeftShield = display.newImageRect("images/mathias/shieldsHexagon.png", width, height)
        bottomLeftShield.x = centerShield.x-(width/2)*2-widthOffset
        bottomLeftShield.y = centerShield.y+(height/2) + heightOffset
        activated(bottomLeftShield)
        bottomLeftShield.touch = toggleShield
        bottomLeftShield:addEventListener("touch", bottomLeftShield)
        grupo_intermedio:insert(bottomLeftShield)

        bottomRightShield = display.newImageRect("images/mathias/shieldsHexagon.png", width, height)
        bottomRightShield.x = centerShield.x+(width/2)*2+widthOffset
        bottomRightShield.y = centerShield.y+(height/2) + heightOffset
        activated(bottomRightShield)
        bottomRightShield.touch = toggleShield
        bottomRightShield:addEventListener("touch", bottomRightShield)
        grupo_intermedio:insert(bottomRightShield)
    end

    return true
end

function atras(e)
	if e.phase == "ended" then
		composer.gotoScene("title", "slideRight", 1000)
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

	shieldsBackground = display.newImageRect("images/mathias/shieldsBackground.png", cw * 0.7, ch * 0.85)
	shieldsBackground.x = cw / 2;
	shieldsBackground.y = ch / 2

    shieldsArea = display.newImageRect("images/mathias/shieldsArea.png", cw * 0.65, ch * 0.8)
    shieldsArea.x = cw / 2
    shieldsArea.y = ch / 2

	atrasText = createText("BACK", 0, 30, 50)
	atrasText:addEventListener("touch", atras)
	atrasText.isVisible = false

	startText = createText("START", cw / 2, ch / 2, 50)
	startText:addEventListener("touch", createShieldHex)
	startText.isVisible = false

    taskCompletedText = createText("Task Completed!", cw / 2, ch*0.94, 80)
	taskCompletedText.isVisible = false

	grupo_background:insert(shieldsBackground)
    grupo_background:insert(shieldsArea)
end

function scene:show(event)

	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		-- Code here runs when the scene is still off screen (but is about to come on screen)
        
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