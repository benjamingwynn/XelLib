-- > XelLib - xelcmd.lua
-- >> Created by Benjamin Gwynn
-- >> Licenced under the GNU GENERAL PUBLIC LICENSE V2

-- >>> xellib\xelcmd.lua
-- >>> Commands for the XelLib diagnostic console

-- handleCommand (handles text inputted into the console)
function handleCommand(cmd)
	-- XelLib must be loaded correctly before using this function.
	checkXelLib()
	
	if allow_xellib == true then
		if cmd == nil then
			commandFailed()
		else
			cmddone = false
			xellibCommand("pinkman", "cmdPinkman", false)
			xellibCommand("exit", "cmdExit", false)
			xellibCommand("quit", "cmdQuit", false)
			xellibCommand("close", "cmdClose", false)
			xellibCommand("kill", "cmdKill", false)
			xellibCommand("argtest", "cmdArgumentTest", true)
			if not cmddone then
				commandFailed()
			end
		end
	end
end

-- xellibCommand (creates a command)
function xellibCommand(cmd_name, cmd_function, cmd_supports_arguments)
	-- XelLib must be loaded correctly before using this function.
	checkXelLib()
	
	if allow_xellib == true then
		if string.find(cmd, cmd_name) then
			cmddone = true
			if not cmd_supports_arguments then
				if #cmd_name == #cmd then
					_G[cmd_function]()
				elseif #cmd_name > #cmd then
					printToConsole("This command does not support arguments.")
				else
					printToConsole("Command not entered correctly [2]")
				end
			else
				if string.find(cmd, cmd_name .. "%s") then
						-- Find and isolate stuff after space
						cmd_argument = string.sub(cmd, (#cmd_name + 2))
						consoleLog(cmd_argument)
						if #cmd - #cmd_name - #cmd_argument - 1 == 0 then
							-- Launch the command
							_G[cmd_function](cmd_argument)
						else
							commandFailed()
						end
				else
					printToConsole("Usage: " .. cmd_name .. " (arguments)")
				end
			end
		end
	end
end

-- commandFailed (used for displaying a command failed)
function commandFailed()
	printToConsole("Unknown Command.", "darkred") -- Show that the command failed
	cmddone = false
end

-- cmdPinkman
function cmdPinkman()
	printToConsole("'Yeah, Science!'", "pink")
end

-- cmdExit (information about exiting the console)
function cmdExit()
	printToConsole("Please type one of the following: \r\n\r\n")
	printToConsole("quit: Quits " .. xellib_game_name)
	printToConsole("kill: Stops XelLib stuff from running (this is generally unsafe and not-recommended)")
	printToConsole("close: Closes this console")
end

-- cmdQuit (quits the game)
function cmdQuit()
	printToConsole("Quitting " .. xellib_game_name .. "...")
	love.event.quit()
end

-- cmdKill (stops XelLib stuff)
function cmdKill()
	consoleLog("XelLib killed by user. Goodbye then :'(", "F", "XelLib")
	allow_xellib = false
	loadretry = true
	ignorecalls = true
end

-- cmdClose (closes the console)
function cmdClose()
	if not game_handles_xellib_updating then
		toggleXelLibConsole()
	else
		printToConsole("Console cannot be opened/closed by XelLib as " .. xellib_game_name .. " is built so it handles all XelLib updating activity. This includes drawing/undrawing GUI's and managing keys strokes. We apologize for any inconvenience caused by this.")
	end
end

-- cmdArgumentTest (for testing argument support)
function cmdArgumentTest(testarg)
	if not testarg then
		printToConsole("Didn't get an argument.")
	else
		printToConsole("Argument: " .. testarg)
	end
end