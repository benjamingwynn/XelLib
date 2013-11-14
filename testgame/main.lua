-- > XelLib
-- >> Created by Benjamin Gwynn
-- >> Licensed under the GNU GENERAL PUBLIC LICENSE V2

-- >>> testgame/main.lua
-- >>> A small test game to show XelLib in action.

require("xellib_core/xellib")

function love.load()
	-- Setup XelLib stuff
	
	xellib_game_name = "Test game"
	xellib_game_version = 1.0
	xellib_requested_version = 0.1
	
	loadXelLib()
	
	-- Start with console
	toggleXelLibConsole()
	
	-- Background
	love.graphics.setBackgroundColor(60, 100, 255, 255)
	
	-- Testing
	printToConsole("Welcome to the XelLib test game. This console is launched automatically.", "yellow")
	printToConsole("All XelLib updating in this version of the test game is handled by XelLib.", "yellow")
end

function love.update(dt)
	-- Nothing here yet.
end

function love.draw()
	updateXelLibDraw()
end

function love.keypressed(t)
	updateXelLibKeyboard(t)
end