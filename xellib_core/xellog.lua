-- > XelLib
-- >> Created by Benjamin Gwynn
-- >> Licensed under the GNU GENERAL PUBLIC LICENSE V2

-- >>> xellib_core/xellog.lua
-- >>> Clever logging.

-- consoleLog (prints log to in game console and LUA console)

function consoleLog(fnmessage, fnlevel, fnapp, ignorequeue)
	if xelLibLoaded() then
		-- Allows function variables to be modified in function:
		message = fnmessage
		level = fnlevel
		app = fnapp
		
		if not message then message = "Unknown" end
		if not level then level = "Unknown" end
		if not app then app = "Unknown" end
		
		-- Call commonLog stuff
		commonLog(level)
		
		if not ignorequeue then
			-- Since consoleLog has been called, spit out our queue.
			if logcount > 0 then
				for i = 1, logcount do
					consoleLog(logqueue_msg[i], logqueue_lvl[i], logqueue_app[i], true)
				end
				logcount = 0 -- Reset the counter
			end
		end
		
		-- If missing data
		if not message then
			message = "Something attempted to use consoleLog, but did not provide a message."
			level = "?"
			app = "XelLog"
		elseif not level then
			-- Assume the game did this, since we have no idea what could have done this. Use ? as the level.
			level = "?"
			app = xellib_game_name
		elseif not app then
			-- Assume the game did this, since we have no idea what could have done this.
			app = xellib_game_name
		end
		
		-- Mark the colour for the message to print as in the game console depending on the log message type:
		if level == "F" then
			logmsgcolour = "red"		-- Fatal messages should be red
		elseif level == "E" then
			logmsgcolour = "darkred"	-- Error messages should be dark red
		elseif level == "W" then
			logmsgcolour = "yellow"		-- Warning messages should be yellow
		elseif level == "?" then
			logmsgcolour = "pink"		-- Unknown messages should be pink
		elseif level == "I" then
			logmsgcolour = "blue"		-- Information messages should be in white
		else
			logmsgcolour = "white"		-- Any other messages should be white
		end
		
		-- Print to game console:
		printToConsole("[" .. level .. "] " .. app .. ": " .. message, logmsgcolour)
		
		-- Print to native LUA console:
		print("[" .. level .. "] " .. app .. ": " .. message)
	else
		simpleLog(fnmessage, fnlevel, fnapp)
	end
end

-- simpleLog (logs to only LUA console in same style as consoleLog. Doesn't require XelLib to be loaded)

function simpleLog(message, level, app)
	if not app then app = "UNKNOWN" end
	if not level then level = "?" end
	commonLog(level)
	print("[" .. level .. "] " .. app .. ": " .. message)
	addToLogQueue(message, level, app)
end

-- commonLog (Common Logging functions)

function commonLog(level)
	if level == "F" then
		fatalcalled = true -- Mark that a fatal error has been called
	end
end

-- addToLogQueue

function addToLogQueue(msg, lvl, app)
		logcount = logcount + 1
		logqueue_msg[logcount] = msg
		logqueue_lvl[logcount] = lvl
		logqueue_app[logcount] = app
end
