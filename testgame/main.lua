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
	
	loadXelLib()
	
	-- Testing
	printToConsole("Line before long text", "pink")
	printToConsole("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut  in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", "blue")
	printToConsole("Line after long text", "yellow")
	printToConsole("Hello there :)")
	printToConsole("Yet another line", "red")
	printToConsole("Test with no colour argument")
	printToConsole("Test with no colour argument")
	printToConsole("Test with no colour argument")
	printToConsole("Test with no colour argument")
	printToConsole("Test with no colour argument")
	printToConsole("Soma smells lololololol", "blue")
	printToConsole("Test with no colour argument")
	printToConsole("Test with no colour argument")
	printToConsole("Test with no colour argument")
	printToConsole("Test with no colour argument")
	printToConsole("Test with no colour argument")
	printToConsole("Test with no colour argument")
	printToConsole("Test with no colour argument")
	printToConsole("Test with no colour argument")
	printToConsole("Test with no colour argument")
	printToConsole("Test with no colour argument")
	printToConsole("Like, he smells REALLY bad", "yellow")
end

function love.update(dt)
	-- Nothing here yet.
end

function love.draw()
	-- Draw the XelLib console.
	drawConsole()
end


function love.keyreleased(key)
	-- Close this test application if escape is pushed
	if key == "escape" then
		love.event.quit()
	end
	
	if key == "return" then
		printToConsole("Enter!")
	end
end