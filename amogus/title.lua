-----------------------------------------------------------------------------------------
--
-- title.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()

--------------------------------------------

-- forward declaration
local level1Text
local level2Text
local level3Text

-- Touch listener function for background object
local function onBackgroundTouch(self, event)
	if event.phase == "ended" or event.phase == "cancelled" then
		-- go to page1.lua scene
		composer.gotoScene("juego", "slideLeft", 800)

		return true -- indicates successful touch
	end
end

local function createText(text, x, y, size)
	text = display.newText(text, x, y, "arial", size)
	text.anchorX = 0;
	text.anchorY = 0
	return text
end

function scene:create(event)
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	--
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	--local background = display.newImageRect( sceneGroup, "images/mathias/cover.jpg", display.contentWidth, display.contentHeight )
	--background.anchorX = 0
	--background.anchorY = 0
	--background.x, background.y = 0, 0

	-- Add more text
	level1Text = createText("LEVEL 1", cw * 0.5, ch * 0.5, 50)
	level2Text = createText("LEVEL 2", cw * 0.5, ch * 0.6, 50)
	level3Text = createText("LEVEL 3", cw * 0.5, ch * 0.7, 50)

	-- all display objects must be inserted into group
	--sceneGroup:insert( background )
	sceneGroup:insert(level1Text)
	sceneGroup:insert(level2Text)
	sceneGroup:insert(level3Text)
end

function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		--
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.

		level1Text.touch = onBackgroundTouch
		level1Text:addEventListener("touch", level1Text)
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

		-- remove event listener from background
		level1Text:removeEventListener("touch", background)

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

