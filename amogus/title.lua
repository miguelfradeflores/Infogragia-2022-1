local composer = require("composer")
local scene = composer.newScene()


-- Local variables
local level01Text, level02Text, level03Text, level04Text, level05Text, level06Text

-- Functions
local function onTextTouch(self, event)
	local text = self.text

	if event.phase == "ended" or event.phase == "cancelled" then
		if text == "LEVEL 1" then
			composer.gotoScene("level01", "slideLeft", 500)
		end
		--if text == "LEVEL 2" then
		--composer.gotoScene("level02", "slideLeft", 500)
		--end
		--if text == "LEVEL 3" then
		--composer.gotoScene("level03", "slideLeft", 500)
		--end
		if text == "LEVEL 4" then
			composer.gotoScene("level04", "slideLeft", 500)
		end
		--if text == "LEVEL 5" then
		--composer.gotoScene("level05", "slideLeft", 500)
		--end
		--if text == "LEVEL 6" then
		--composer.gotoScene("level06", "slideLeft", 500)
		--end
		return true
	end
end

local function createText(text, x, y, size)
	text = display.newText(text, x, y, "candara", size)
	text.anchorX = 0;
	text.anchorY = 0
	return text
end

-- Scene management
function scene:create(event)
	local sceneGroup = self.view

	-- Display backgroud image
	local background = display.newImageRect(sceneGroup, "images/title-screen/title-screen.jpg", cw, ch)
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0

	-- Add text levels
	level01Text = createText("LEVEL 1", cw * 0.23, ch * 0.4, 50)
	level02Text = createText("LEVEL 2", cw * 0.23, ch * 0.5, 50)
	level03Text = createText("LEVEL 3", cw * 0.23, ch * 0.6, 50)
	level04Text = createText("LEVEL 4", cw * 0.6, ch * 0.4, 50)
	level05Text = createText("LEVEL 5", cw * 0.6, ch * 0.5, 50)
	level06Text = createText("LEVEL 6", cw * 0.6, ch * 0.6, 50)

	-- insert text to sceneGroup
	sceneGroup:insert(level01Text)
	sceneGroup:insert(level02Text)
	sceneGroup:insert(level03Text)
	sceneGroup:insert(level04Text)
	sceneGroup:insert(level05Text)
	sceneGroup:insert(level06Text)
end

function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		level01Text.touch = onTextTouch
		level01Text:addEventListener("touch", level01Text)
		level02Text.touch = onTextTouch
		level02Text:addEventListener("touch", level02Text)
		level03Text.touch = onTextTouch
		level03Text:addEventListener("touch", level03Text)
		level04Text.touch = onTextTouch
		level04Text:addEventListener("touch", level04Text)
		level05Text.touch = onTextTouch
		level05Text:addEventListener("touch", level05Text)
		level06Text.touch = onTextTouch
		level06Text:addEventListener("touch", level06Text)
	end

end

function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase

	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)

	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy(event)
	local sceneGroup = self.view

	-- Called prior to the removal of scene's "view" (sceneGroup)
	--
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

-----------------------------------------------------------------------------------------

return scene
