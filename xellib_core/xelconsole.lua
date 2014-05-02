-- > XelLib
-- >> Created by Benjamin Gwynn
-- >> Licensed under the GNU GENERAL PUBLIC LICENSE V2

-- >>> xellib_core/xelconsole.lua
-- >>> A diagnostic in-game developers console for LOVE2D

-- floatValue (floats a value at the top of the screen) (WIP)
function registerFloatValue(value)
	if xelLibLoaded() then
		if not value then
			consoleLog("floatValue requires an argument to be passed to it.", "E", "XelLib")
		else
			if not floatvalues then floatvalues = {} end
			if not floatvaluecount then floatvaluecount = -1 end
			floatvaluecount = floatvaluecount + 1
			floatvalues[floatvaluecount] = value
		end
	end
end

function displayFloatValues()
	if xelLibLoaded() then
		love.graphics.setFont(xellib_body_font)
		if floatvalues then
			for i = 0, floatvaluecount do
					love.graphics.printf(floatvalues[i], 0, i * xellib_body_font:getHeight(), love.graphics.getWidth())
			end
		end
	end
end

-- drawConsole (draws the console)
function drawConsole()
	if xelLibLoaded() then
		-- Set XelLib font
		love.graphics.setFont(xellib_body_font)
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
			
			if not consolemessage[i] then
				-- consoleLog("Console message was removed from the screen as resolution was changed.", "W", "XelLib")
			else
				-- Calculate the position of the text
				if i - 1 == 0 then
					lines = 0
				else
					width, lines = xellib_body_font:getWrap(consolemessage[i-1], love.graphics.getWidth() - 120)
				end
			
				if i == 1 then
					line_total = 1
				else
					line_total = line_total + lines
				end
				
				-- Calculate if the text exceeds the console height and if it does clear the screen
				
				if line_total * xellib_body_font:getHeight() + 50 >= love.graphics.getHeight() - 100 then
					consolemessage[1] = consolemessage[i]
					for q = 2, msgcount do
						consolemessage[q] = nil
					end
					msgcount = 1
				else
					-- Print the text
					love.graphics.printf(consolemessage[i], 60, line_total * xellib_body_font:getHeight() + 50, love.graphics.getWidth() - 120)
				end
			end
			-- Reset the colour
			love.graphics.setColor(255, 255, 255, 255)
		end
	end
end

-- consoleInput (handles character input into the console)
function consoleInput(txt)
	if xelLibLoaded() then
		if txt == "return" then
				clearConsoleInput()
				handleCommand(cmd)
		elseif txt == "backspace" then
			if txcount == 0 then
				-- TODO: add something to show you can not delete any more text
			else
				cmdp[txcount] = nil
				txcount = txcount - 1
			end
		elseif txt == "escape" then
			clearConsoleInput()
			printToConsole("Type 'exit' to view information on closing the console.")
		else
			txcount = txcount + 1
			cmdp[txcount] = txt
		end
		cmd = ""
		if txt == "up" then
			clearConsoleInput()
			uppresscount = uppresscount + 1
			w = cmdhandledcount - uppresscount
			if w > 0 then
				cmd = prevconsoleinput[w]
			else
				upresscount = -1
			end
		elseif txt == "down" then
			clearConsoleInput()
			uppresscount = uppresscount - 1
			w = cmdhandledcount - uppresscount
			if w < cmdhandledcount + 1 then
				cmd = prevconsoleinput[w]
			else
				upresscount = -1
			end
		else
			for x = 1, txcount do
				cmd = cmd .. cmdp[x]
			end
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
	if xelLibLoaded() then
		-- Set XelLib font
		love.graphics.setFont(xellib_body_font)
		-- Draw text box
		love.graphics.setColor(240, 255, 60, 255)
		love.graphics.rectangle( "line", 50, love.graphics.getHeight() - 72 , love.graphics.getWidth() - 100, xellib_body_font:getHeight() + 6)
		-- Draw the text in the box
		if cmd then
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.printf(cmd, 52, love.graphics.getHeight() - 72, love.graphics.getWidth())
		end
		-- Reset the colour
		love.graphics.setColor(255, 255, 255, 255)
	end
end

-- printToConsole (prints messages to the console)
function printToConsole(msg, colour)
	if xelLibLoaded() then
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
