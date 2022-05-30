display.setStatusBar(display.HiddenStatusBar)

cw = display.contentWidth
ch = display.contentHeight
completedTaskSound = audio.loadStream("sounds/taskCompleted.mp3")
startTaskSound = audio.loadStream("sounds/taskStarted.mp3")
closeTaskSound = audio.loadStream("sounds/taskClosed.mp3")

local composer = require "composer"
composer.gotoScene("title", "fade")
