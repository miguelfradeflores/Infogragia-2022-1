local composer = require("composer")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local nodeGroup = display.newGroup()
local background, ship, backButton

local function createImageRectObject(group, file, w, h, x, y)
	local object = display.newImageRect(group, file, w, h, x, y)
	object.anchorX = 0
	object.anchorY = 0
	object.x = x
	object.y = y

	return object
end

local function onBackButtonTouch(self, event)
	if event.phase == "ended" then
		composer.gotoScene("title", "slideRight", 2000)
	end
	return true
end

local function onNodeOneTouch(self, event)
	local function t_rotateShip()
		transition.to(ship, { rotation = -10, time = 1000 })
	end

	if event.phase == "ended" then
		transition.to(ship, { x = cw * 0.27, y = ch * 0.74, time = 1000, onComplete = t_rotateShip })
	end
end

local function onNodeTwoTouch(self, event)
	local function t_rotateShip()
		transition.to(ship, { rotation = 90, time = 1000 })
	end

	if event.phase == "ended" then
		transition.to(ship, { x = cw * 0.54, y = ch * 0.3, time = 1000, onComplete = t_rotateShip })
	end
end

local function onNodeThreeTouch(self, event)
	local function t_rotateShip()
		transition.to(ship, { rotation = -10, time = 1000 })
	end

	if event.phase == "ended" then
		transition.to(ship, { x = cw * 0.62, y = ch * 0.75, time = 1000, onComplete = t_rotateShip })
	end
end

local function onNodeFourTouch(self, event)
	local function t_rotateShip()
		transition.to(ship, { rotation = 5, time = 1000 })
	end

	if event.phase == "ended" then
		transition.to(ship, { x = cw * 0.8, y = ch * 0.36, time = 1000, onComplete = t_rotateShip })
		transition.fadeIn(backButton, { time = 1000 })
	end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create(event)

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	background = createImageRectObject(sceneGroup, "images/boris/level06/level06-bg.png", cw, ch, 0, 0)
	backButton = createImageRectObject(sceneGroup, "images/back-button.png", cw * 0.2, ch * 0.1, cw * 0.1, ch * 0.2)
	backButton.alpha = 0

	node1 = display.newRect(nodeGroup, cw * 0.33, ch * 0.79, 100, 100)
	node1.alpha = 0.005
	node2 = display.newRect(nodeGroup, cw * 0.5, ch * 0.36, 100, 100)
	node2.alpha = 0.005
	node3 = display.newRect(nodeGroup, cw * 0.67, ch * 0.79, 100, 100)
	node3.alpha = 0.005
	node4 = display.newRect(nodeGroup, cw * 0.85, ch * 0.41, 100, 100)
	node4.alpha = 0.005

	ship = createImageRectObject(sceneGroup, "images/boris/level06/level06-ship.PNG", cw * 0.1, ch * 0.1, cw * 0.22, ch * 0.52)
	ship.rotation = 80

end

-- show()
function scene:show(event)

	local sceneGroup = self.view
	local phase = event.phase

	node1.touch = onNodeOneTouch
	node1:addEventListener("touch", node1)
	node2.touch = onNodeTwoTouch
	node2:addEventListener("touch", node2)
	node3.touch = onNodeThreeTouch
	node3:addEventListener("touch", node3)
	node4.touch = onNodeFourTouch
	node4:addEventListener("touch", node4)

	backButton.touch = onBackButtonTouch
	backButton:addEventListener("touch", backButton)

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
