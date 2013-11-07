-- > XelLib - xelconsole.lua
-- >> Created by Benjamin Gwynn
-- >> Licenced under the GNU GENERAL PUBLIC LICENSE V2

-- >>> xelconsole.lua
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
		-- If there are too many messages to fit in the console, rather than carry on printing them outside of the console, do the following: 
		--if (msgcount * fontheight) + 60 > love.graphics.getHeight() then
		--	if not consoleoverflow == true then
		--		consoleoverflow = true -- Make this true, causing the print co-ords to stay static
		--		consoleoverflow_value = ((msgcount - 1) * fontheight) + 60 -- These are the co-ords we will always print at from now on
		--	end
		--	z = z + 1 -- Start removing messages from the screen, starting with message 1
		--	consolemessage[z] = nil -- Remove the message
		--end
		-- Draw the console text
		for i = 1, msgcount do
			-- Set the colour
			if consolemessagecolour[msgcount] == "red" then
				love.graphics.setColor(255, 60, 60, 255)
			elseif consolemessagecolour[msgcount] == "blue" then
				love.graphics.setColor(60, 100, 255, 255)
			elseif consolemessagecolour[msgcount] == "pink" then
				love.graphics.setColor(255, 60, 180, 255)
			elseif consolemessagecolour[msgcount] == "yellow" then
				love.graphics.setColor(240, 255, 60, 255)
			elseif consolemessagecolour[msgcount] == "darkred" then
				love.graphics.setColor(60, 150, 30, 255)
			elseif consolemessagecolour[msgcount] == "white" then
				love.graphics.setColor(255, 255, 255, 255)
			else
				love.graphics.setColor(255, 255, 255, 255) -- Set to white for unknown colours
			end
			-- Print the text
			if consoleoverflow == true then
				love.graphics.print(consolemessage[i], 60, consoleoverflow_value)
			else
				love.graphics.print(consolemessage[i], 60, 60 + (i * fontheight))
			end
		end
		-- Reset the colour
		love.graphics.setColor(0, 0, 0, 255)
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