-- > XelLib - xelconsole.lua
-- >> Created by Benjamin Gwynn
-- >> Licenced under the GNU GENERAL PUBLIC LICENSE V2

-- >>> xellib\xelconsole.lua
-- >>> A diagnostic in-game developers console for LOVE2D

-- drawConsole (draws the console)
function drawConsole()
	-- XelLib must be loaded correctly before using this function.
	checkXelLib()
	
	if allow_xellib == true then
		-- Draw the console background
		love.graphics.setColor(0, 0, 0, 200)
		love.graphics.rectangle( "fill", 50, 50, love.graphics.getWidth() - 100, love.graphics.getHeight() - 100)
		-- Draw the console outline
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.rectangle( "line", 50, 50, love.graphics.getWidth() - 100, love.graphics.getHeight() - 100)
		-- Draw the console text
		for i = 1, msgcount do
			-- Set the colour
			if consolemessagecolour[i] == "red" then
				love.graphics.setColor(255, 60, 60, 255)
			elseif consolemessagecolour[i] == "blue" then
				love.graphics.setColor(60, 100, 255, 255)
			elseif consolemessagecolour[i] == "pink" then
				love.graphics.setColor(255, 60, 180, 255)
			elseif consolemessagecolour[i] == "yellow" then
				love.graphics.setColor(240, 255, 60, 255)
			elseif consolemessagecolour[i] == "darkred" then
				love.graphics.setColor(60, 150, 30, 255)
			elseif consolemessagecolour[i] == "white" then
				love.graphics.setColor(255, 255, 255, 255)
			else
				love.graphics.setColor(255, 255, 255, 255) -- Set to white for unknown colours
			end
			
			-- Calculate the position of the text
			if i - 1 == 0 then
				lines = 0
			else
				width, lines = font:getWrap(consolemessage[i-1], love.graphics.getWidth() - 120)
			end
		
			if i == 1 then
				line_total = 1
			else
				line_total = line_total + lines
			end
			
			-- Calculate if the text exceeds the console height and if it does clear the screen
			
			if line_total * font:getHeight() + 50 >= love.graphics.getHeight() - 100 then
				consolemessage[1] = consolemessage[i]
				for q = 2, msgcount do
					consolemessage[q] = nil
				end
				msgcount = 1
			end
			
			if not consolemessage[i] then
				-- meh
			else
				-- Print the text
				love.graphics.printf(consolemessage[i], 60, line_total * font:getHeight() + 50, love.graphics.getWidth() - 120)
			end
			
			-- Reset the colour
			love.graphics.setColor(0, 0, 0, 255)
		end
	end
end

-- consoleInput (handles input into the console)
function consoleInput()
	-- Input something
	-- Get command
	-- Launch consoleCommands(cmd)
end

-- consoleCommands (handles text inputted into the console)
function consoleCommands(cmd)
	-- List of commands that launch certain functions
	functions = {
		pinkman = cmdPinkman()
	}
	--if functions[cmd] == nil then
	--	printToConsole("Unknown Command.", "darkred") -- Show that the command failed
	--else
	--	_G[functions[cmd]] -- Launch the function
	--end
end

-- printToConsole (prints messages to the console)
function printToConsole(msg, colour)
	-- XelLib must be loaded correctly before using this function.
	checkXelLib()
	msgcount = msgcount + 1
	consolemessage[msgcount] = msg
	if not colour then
		consolemessagecolour[msgcount] = "white"
	else
		consolemessagecolour[msgcount] = colour
	end
end