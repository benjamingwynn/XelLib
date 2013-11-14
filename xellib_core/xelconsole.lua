-- > XelLib
-- >> Created by Benjamin Gwynn
-- >> Licensed under the GNU GENERAL PUBLIC LICENSE V2

-- >>> xellib_core/xelconsole.lua
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
			elseif consolemessagecolour[i] == "green" then
				love.graphics.setColor(60, 150, 30, 255)
			elseif consolemessagecolour[i] == "darkred" then
				love.graphics.setColor(180, 30, 30, 255)
			elseif consolemessagecolour[i] == "white" then
				love.graphics.setColor(255, 255, 255, 255)
			else
				love.graphics.setColor(255, 255, 255, 255) -- Set to white for unknown colours
			end
			
			if consolemessage[i] == nil then
				consoleLog("consolemessage count reaches nil", "XelLib", "E")
			else
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
				
				-- Print the text
				love.graphics.printf(consolemessage[i], 60, line_total * font:getHeight() + 50, love.graphics.getWidth() - 120)
			end
			-- Reset the colour
			love.graphics.setColor(0, 0, 0, 255)
			
			-- Draw consoleInput UI
			consoleInputUIComponent()
		end
	end
end

-- consoleInput (handles character input into the console)
function consoleInput(txt)
	-- XelLib must be loaded correctly before using this function.
	checkXelLib()
	
	if allow_xellib == true then
		if txt == "return" then
				clearConsoleInput()
				handleCommand(cmd)
				a = a + 1
				consoleinput[a] = cmd
		elseif txt == "backspace" then
			if txcount == 0 then
				-- TODO: add something to show you can not delete any more stuff
			else
				cmdp[txcount] = nil
				txcount = txcount - 1
			end
		elseif txt == "escape" then
			clearConsoleInput()
			printToConsole("Type 'exit' to view information on closing the console.")
		elseif txt == "up" then
			if b == 1 then
				b = b -- Do not modify b
			else
				b = (b - 1) + a -- (check this works with a maths person)
				cmd = consoleinput[b]
			end
		--elseif txt == "left" or "right" then
			-- do nothing
		else
			txcount = txcount + 1
			cmdp[txcount] = txt
		end
		cmd = ""
		for x = 1, txcount do
			cmd = cmd .. cmdp[x]
		end
	end
end

-- clearConsoleInput (clears consoleInput text)
function clearConsoleInput()
	txcount = 0
	for x = 1, txcount do
		cmd = nil
	end
end

-- consoleInputUIComponent (draws the input part of the console)
function consoleInputUIComponent()
	-- XelLib must be loaded correctly before using this function.
	checkXelLib()
	
	if allow_xellib == true then
		-- Draw text box
		love.graphics.setColor(240, 255, 60, 255)
		love.graphics.rectangle( "line", 50, love.graphics.getHeight() - 72 , love.graphics.getWidth() - 100, font:getHeight() + 6)
		-- Draw the text in the box
		love.graphics.printf(cmd, 52, love.graphics.getHeight() - 72, love.graphics.getWidth())
		-- Reset the colour
		love.graphics.setColor(0, 0, 0, 255)
	end
end

-- printToConsole (prints messages to the console)
function printToConsole(msg, colour)
	-- XelLib must be loaded correctly before using this function.
	checkXelLib()
	
	if allow_xellib == true then
		msgcount = msgcount + 1
		consolemessage[msgcount] = msg
		if not colour then
			consolemessagecolour[msgcount] = "white"
		else
			consolemessagecolour[msgcount] = colour
		end
	end
end

-- toggleXelLibConsole (toggles the console)
function toggleXelLibConsole()
	show_xellib_console = not show_xellib_console
end