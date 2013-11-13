-- > XelLib - main.lua
-- >> Created by Benjamin Gwynn
-- >> Licenced under the GNU GENERAL PUBLIC LICENSE V2

-- >>> testgame\main.lua
-- >>> A small test game to show XelLib in action.

require("xellib")

function love.load()
	-- Setup XelLib stuff
	
	xellib_game_name = "Test game"
	xellib_game_version = 1.0
	xellib_requested_version = 0.1
	game_handles_xellib_updating = true
	
	loadXelLib()
	
	-- Start with console
	showconsole = true
	
	-- Background
	love.graphics.setBackgroundColor( 230, 25, 300)
	
	-- Testing
	printToConsole("Welcome to the XelLib test game. This console is launched automatically.", "yellow")
end

function love.update(dt)
	-- Nothing here yet.
end

function love.draw()
	if showconsole == true then
		-- Draw the XelLib console.
		drawConsole()
	end
end

function love.keypressed(t)
	if showconsole == true then
		consoleInput(t)
	end
end