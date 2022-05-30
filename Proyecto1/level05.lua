local composer = require("composer")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local wireGroup = display.newGroup()
local background, backButton
local redWireMark, blueWireMark, yellowWireMark, pinkWireMark
local redComplete = false
local blueComplete = false
local yellowComplete = false
local pinkComplete = false

local colorBlue = { 49 / 255, 40 / 255, 1 }
local colorRed = { 253 / 255, 0, 2 / 255 }
local colorYellow = { 253 / 255, 235 / 255, 1 / 255 }
local colorPink = { 253 / 255, 2 / 255, 251 / 255 }

local function createRectObject(group, color, x, y, w, h)
	local object = display.newRect(group, x, y, w, h)
	object:setFillColor(unpack(color))
	return object
end

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
		wireGroup.isVisible = false
	end
	return true
end

local function checkCompletion()
	if redComplete and blueComplete and yellowComplete and pinkComplete then
		backButton.isVisible = true
	end
end

function handleRedWire(self, event)
	local finalX, finalY

	if (event.phase == "moved") then
		self.x = event.x
		self.y = event.y
	elseif (event.phase == "ended") then
		finalX = event.x
		finalY = event.y
		if (finalX > cw * 0.8 and finalX < cw * 0.85 + 30 and finalY > ch * 0.1 and finalY < ch * 0.2 + 30) then
			redWireMark.isVisible = false
			aux = createRectObject(wireGroup, colorRed, cw * 0.48, ch * 0.3, cw * 0.8, 30)
			aux.rotation = -11
			redComplete = true
			checkCompletion()
		end
	end
end

function handleBlueWire(self, event)
	local finalX, finalY

	if (event.phase == "moved") then
		self.x = event.x
		self.y = event.y
	elseif (event.phase == "ended") then
		finalX = event.x
		finalY = event.y
		if (finalX > cw * 0.8 and finalX < cw * 0.85 + 30 and finalY > ch * 0.4 and finalY < ch * 0.4 + 30) then
			blueWireMark.isVisible = false
			aux = createRectObject(wireGroup, colorBlue, cw * 0.48, ch * 0.3, cw * 0.8, 30)
			aux.rotation = 11
			blueComplete = true
			checkCompletion()
		end
	end
end

function handleYellowWire(self, event)
	local finalX, finalY

	if (event.phase == "moved") then
		self.x = event.x
		self.y = event.y
	elseif (event.phase == "ended") then
		finalX = event.x
		finalY = event.y
		if (finalX > cw * 0.8 and finalX < cw * 0.85 + 30 and finalY > ch * 0.6 and finalY < ch * 0.61 + 30) then
			yellowWireMark.isVisible = false
			aux = createRectObject(wireGroup, colorYellow, cw * 0.48, ch * 0.71, cw * 0.8, 30)
			aux.rotation = -11
			yellowComplete = true
			checkCompletion()
		end
	end
end

function handlePinkWire(self, event)
	local finalX, finalY

	if (event.phase == "moved") then
		self.x = event.x
		self.y = event.y
	elseif (event.phase == "ended") then
		finalX = event.x
		finalY = event.y
		if (finalX > cw * 0.8 and finalX < cw * 0.85 + 30 and finalY > ch * 0.8 and finalY < ch * 0.81 + 30) then
			pinkWireMark.isVisible = false
			aux = createRectObject(wireGroup, colorPink, cw * 0.48, ch * 0.71, cw * 0.8, 30)
			aux.rotation = 11
		end
		pinkComplete = true
		checkCompletion()
	end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create(event)

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	background = createImageRectObject(sceneGroup, "images/boris/level05/level05-bg.jpg", cw, ch, 0, 0)
	backButton = createImageRectObject(sceneGroup, "images/back-button.png", cw * 0.2, ch * 0.1, cw * 0.42, ch * 0.05)
	backButton.isVisible = false

	-- Create wires
	redWireMark = createRectObject(wireGroup, colorRed, cw * 0.12, ch * 0.41, 30, 30)
	blueWireMark = createRectObject(wireGroup, colorBlue, cw * 0.12, ch * 0.2, 30, 30)
	yellowWireMark = createRectObject(wireGroup, colorYellow, cw * 0.12, ch * 0.82, 30, 30)
	pinkWireMark = createRectObject(wireGroup, colorPink, cw * 0.12, ch * 0.61, 30, 30)

end

-- show()
function scene:show(event)

	local sceneGroup = self.view
	local phase = event.phase

	redWireMark.touch = handleRedWire
	redWireMark:addEventListener("touch", redWireMark)
	blueWireMark.touch = handleBlueWire
	blueWireMark:addEventListener("touch", blueWireMark)
	yellowWireMark.touch = handleYellowWire
	yellowWireMark:addEventListener("touch", yellowWireMark)
	pinkWireMark.touch = handlePinkWire
	pinkWireMark:addEventListener("touch", pinkWireMark)

	backButton.touch = onBackButtonTouch
	backButton:addEventListener("touch", backButton)

end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
-- -----------------------------------------------------------------------------------

return scene
