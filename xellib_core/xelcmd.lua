-- > XelLib
-- >> Created by Benjamin Gwynn
-- >> Licensed under the GNU GENERAL PUBLIC LICENSE V2

-- >>> xellib_core/xelcmd.lua
-- >>> Commands for the XelLib diagnostic console

-- defaultCommands (default command list)
function defaultCommands()
	createCommand("exit", "cmdExit", false, "XelLib")
	createCommand("quit", "cmdQuit", false, "XelLib")
	createCommand("close", "cmdClose", false, "XelLib")
	createCommand("kill", "cmdKill", false, "XelLib")
	createCommand("pinkman", "cmdPinkman", false, "XelLib")
	createCommand("argtest", "cmdArgumentTest", true, "XelLib")
end

-- handleCommand (handles text inputted into the console)
function handleCommand(cmd)
	-- XelLib must be loaded correctly before using this function.
	checkXelLib()
	
	if allow_xellib == true then
		if cmd == nil then
			commandFailed()
		else
			cmddone = false
			for p = 1, cmd_total_count do
				if string.find(cmd, cmd_name[p]) then
					cmddone = true
					if not cmd_supports_arguments[p] then
						if #cmd_name[p] == #cmd then
							_G[cmd_function[p]]()
						elseif #cmd_name[p] > #cmd then
							printToConsole("This command does not support arguments.")
						else
							printToConsole("Command entered incorrectly.")
						end
					else
						if string.find(cmd, cmd_name[p] .. "%s") then
								-- Find and isolate stuff after space
								cmd_argument = string.sub(cmd, (#cmd_name[p] + 2))
								if #cmd - #cmd_name[p] - #cmd_argument - 1 == 0 then
									-- Launch the command
									_G[cmd_function[p]](cmd_argument)
								else
									commandFailed()
								end
						else
							printToConsole("Usage: " .. cmd_name[p] .. " (arguments)")
						end
					end
				end
			end
			if not cmddone then
				commandFailed()
			end
		end
	end
end

-- createCommand (creates a command)
function createCommand(new_cmd_name, new_cmd_function, new_cmd_supports_arguments, new_cmd_hostapp)
	-- XelLib must be loaded correctly before using this function.
	checkXelLib()
	
	if allow_xellib == true then
		if not new_cmd_name or not new_cmd_function or new_cmd_supports_arguments == nil or not new_cmd_hostapp then
			consoleLog("XelLib couldn't create a command as instructed by an application. Review the command creation arguments.", "E", "XelLib")
		else
			cmd_total_count = cmd_total_count + 1
			cmd_name[cmd_total_count] = new_cmd_name
			cmd_function[cmd_total_count] = new_cmd_function
			cmd_supports_arguments[cmd_total_count]= new_cmd_supports_arguments
			cmd_hostapp[cmd_total_count] = new_cmd_hostapp
			consoleLog("Created command " .. cmd_name[cmd_total_count] .. " successfully.", "I", "XelLib")
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