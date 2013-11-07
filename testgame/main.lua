-- A small test game for testing XelLib

require("xellib")

function love.load()
	-- Setup XelLib stuff
	
	xellib_game_name = "Test game"
	xellib_game_version = 1.0
	xellib_requested_version = 0.1
	
	loadXelLib()
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
end