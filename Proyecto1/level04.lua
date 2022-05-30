local composer = require("composer")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local scanGroup = display.newGroup()
local background, bean, scanButton, backButton, scanCompleteText, progressBar, topScanText, bottomScanText
local scanSound = audio.loadStream("sounds/level04/level04-scanSound.mp3")

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
        scanGroup.isVisible = false
        audio.play(closeTaskSound)
    end
    return true
end

local function onScanButtonTouch(self, event)
    audio.play(scanSound)
    local aura = createImageRectObject(scanGroup, "images/boris/level04/level04-scan-circle.png", cw * 0.2, ch * 0.1, cw * 0.55, ch * 0.8)
    topScanText = createImageRectObject(scanGroup, "images/boris/level04/level04-scan-text-top.png", cw * 0.5, ch * 0.35, cw * 0.4, ch * 0.24)
    topScanText.alpha = 0
    bottomScanText = createImageRectObject(scanGroup, "images/boris/level04/level04-scan-text-bottom.png", cw * 0.5, ch * 0.1, cw * 0.4, ch * 0.9)
    bottomScanText.alpha = 0

    -- Transitions
    local function createScanCompleteText()
        scanCompleteText = createImageRectObject(scanGroup, "images/boris/level04/level04-scancomplete-text.PNG", cw * 0.22, ch * 0.04, cw * 0.45, ch * 0.95)
        transition.pause(blinkyBoi)
        backButton.isVisible = true
        aura.isVisible = false
        audio.play(completedTaskSound)
    end

    local function t_auraDown()
        transition.to(aura, { y = ch * 0.8, time = 2000, onComplete = createScanCompleteText })
    end

    local blinkyBoi = transition.blink(bean, { time = 2000 })
    transitionAura = transition.to(aura, { y = ch * 0.65, time = 2000, onComplete = t_auraDown })
    transition.fadeIn(topScanText, { time = 1000 })
    transition.fadeIn(bottomScanText, { time = 1000 })

    progressBar = display.newRect(scanGroup, cw * 0.42, ch * 0.91, cw * 0.05, ch * 0.025)
    progressBar.anchorX = 0
    progressBar.anchorY = 0
    progressBar:setFillColor(0, 1, 0.4)
    progressBar:toFront()

    transition.to(progressBar, { xScale = cw * 0.009, time = 4000 })

    self.isVisible = false
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create(event)

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    background = createImageRectObject(sceneGroup, "images/boris/level04/level04-bg.png", cw, ch, 0, 0)
    backButton = createImageRectObject(sceneGroup, "images/back-button.png", cw * 0.15, ch * 0.1, cw * 0.845, ch * 0.1)
    backButton.isVisible = false
    bean = createImageRectObject(sceneGroup, "images/bean-right.png", cw * 0.2, ch * 0.2, cw * 0.55, ch * 0.67)
    scanButton = createImageRectObject(scanGroup, "images/boris/level04/level04-save-button.png", cw * 0.15, ch * 0.15, cw * 0.15, ch * 0.75)
end

-- show()
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    audio.play(startTaskSound)
    scanButton.touch = onScanButtonTouch
    scanButton:addEventListener("touch", scanButton)

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
