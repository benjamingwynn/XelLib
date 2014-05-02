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
	createCommand("print", "cmdPrint", true, "XelLib")
	createCommand("setvar", "cmdSetVar", true, "XelLib")
	createCommand("togglefs", "fullscreenToggle", false, "XelLib")
	createCommand("togglefstype", "fsWindowToggle", false, "XelLib")
	createCommand("lorem", "cmdLorem", false, "XelLib")
	createCommand("refreshgfx", "refreshGraphics", false, "XelLib")
	createCommand("stopsound", "cmdKillSound", false, "XelLib")
	createCommand("pauseallsounds", "cmdPauseSound", false, "XelLib")
	createCommand("resumepausedsounds", "cmdResumeSound", false, "XelLib")
	createCommand("togglesoundprevention", "cmdPreventSound", false, "XelLib")
	createCommand("commands", "cmdListCommands", false, "XelLib")
	createCommand("makefloat", "cmdCreateFloat", true, "XelLib")
	createCommand("makefmany", "cmdCreateMultipleTestFloats", false, "XelLib")
end

-- handleCommand (handles text inputted into the console)
function handleCommand(cmd)
	if xelLibLoaded() then
		if cmd == nil then
			commandFailed()
		else
			-- Print the command we did to the console
			printToConsole("> " .. cmd)
			-- Keep the command logged in the table: prevconsoleinput
			cmdhandledcount = cmdhandledcount + 1
			prevconsoleinput[cmdhandledcount] = cmd
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
								-- Find and isolate arguments after first space:
								cmd_argument = string.sub(cmd, (#cmd_name[p] + 2))
								
								-- Isolate all arguments individually:
								cmd_argument_individual_count = 0
								for i in string.gmatch(cmd_argument, "%S+") do
									cmd_argument_individual_count = cmd_argument_individual_count + 1
									cmd_argument_individual[cmd_argument_individual_count] = i
								end
								
								-- If the command is the expected length
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
	if xelLibLoaded() then
		if not new_cmd_name or not new_cmd_function or new_cmd_supports_arguments == nil or not new_cmd_hostapp then
			consoleLog("XelLib couldn't create a command as instructed by an application. Review the command creation arguments.", "E", "XelLib")
		else
			cmd_total_count = cmd_total_count + 1
			cmd_name[cmd_total_count] = new_cmd_name
			cmd_function[cmd_total_count] = new_cmd_function
			cmd_supports_arguments[cmd_total_count]= new_cmd_supports_arguments
			cmd_hostapp[cmd_total_count] = new_cmd_hostapp
			if new_cmd_hostapp == "XelLib" then else
				consoleLog("Created command '" .. cmd_name[cmd_total_count] .. "' successfully.", "I", "XelLib")
			end
		end
	end
	
	if commandlist == nil then
		commandlist = new_cmd_name
	else
		commandlist = commandlist .. ", " .. new_cmd_name
	end
end

-- commandFailed (used for displaying a command failed)
function commandFailed()
	printToConsole("Unknown Command.", "darkred") -- Show that the command failed
	cmddone = false
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
	consoleLog("XelLib killed by user.", "F", "XelLib")
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

-- cmdPrint (prints text to console)
function cmdPrint(printarg)
	printToConsole(printarg)
end

-- cmdSetVar (sets a variable)
function cmdSetVar()
	if not cmd_argument_individual[2] then
		printToConsole("Usage: setvar [variable to change] [value to change to]", "red")
	elseif cmd_argument_individual[3] then
		printToConsole("Usage: setvar [variable to change] [value to change to]", "red")
	else
		-- Print what's happening
		printToConsole("Setting '" .. cmd_argument_individual[2] .."' as the value for '" .. cmd_argument_individual[1] .. "'", "green")
		-- Change the variable
		cmd_argument_individual[1] = _G[cmd_argument_individual[2]]
	end
end

-- cmdLorem (prints Lorem Ipsum to the console)
function cmdLorem()
	printToConsole("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus placerat dolor et tristique viverra. Praesent sapien metus, porta nec tortor ac, fermentum suscipit orci. Vestibulum nisi augue, auctor in egestas ut, accumsan convallis sapien. Donec pharetra ornare ultrices. Integer tempor nibh ut augue aliquet volutpat. Nulla sem mauris, faucibus at bibendum et, commodo a ipsum. Vestibulum id pulvinar libero. Fusce quam erat, congue at tristique sed, suscipit nec erat. Curabitur viverra mi leo, a rhoncus est venenatis interdum. Duis sodales dictum semper. Vivamus ornare sapien in ultricies molestie. Proin fringilla libero vitae tempor euismod. Ut eleifend ipsum leo, vitae cursus libero sagittis fringilla. Nullam sed eleifend lectus.", "yellow")
end

-- cmdKillSound (kills playing sounds)
function cmdKillSound()
	printToConsole("All sounds killed. The game may restart them.", "red")
	love.audio.stop()
end

-- cmdPauseSound (pauses playing sounds)
function cmdPauseSound()
	printToConsole("All sounds paused.", "yellow")
	love.audio.pause()
end

-- cmdResumeSound (resumes paused sounds)
function cmdResumeSound()
	printToConsole("All sounds resumed.", "yellow")
	love.audio.resume()
end

-- cmdPreventSound (prevents sounds from playing)
function cmdPreventSound()
	preventsound = not preventsound
	if preventsound then
		printToConsole("Preventing sounds from playing. This pauses a sound every time it starts.", "red")
	else
		printToConsole("Sounds no longer prevented from playing.", "green")
	end
end

-- cmdListCommands (lists all commands created)
function cmdListCommands()
	printToConsole("Commands available: " .. commandlist)
end

-- cmdCreateTestFloat
function cmdCreateFloat(floattext)
	printToConsole("Putting '" .. floattext .. "' into a float.")
	floatValue(floattext)
end

function cmdCreateMultipleTestFloats()
	local c = 0
	printToConsole("Creating 10 test floats.")
	while c < 10 do
		floatValue("Test Float #" .. c)
		c = c + 1
	end
end

function outdatedCommand()
	printToConsole("This command has not yet been updated for this version of LOVE2D. It may not function correctly.")
end
