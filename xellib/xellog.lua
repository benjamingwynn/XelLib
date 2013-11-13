-- > XelLib - xellog.lua
-- >> Created by Benjamin Gwynn
-- >> Licenced under the GNU GENERAL PUBLIC LICENSE V2

-- >>> xellib\xellog.lua
-- >>> Clever logging.

-- consoleLog (prints log to in game console and LUA console)

function consoleLog(fnmessage, fnlevel, fnapp)
	-- XelLib must be loaded correctly before using this function.
	checkXelLib()
	
	if allow_xellib == true then

		-- Allows function variables to be modified in function:
		message = fnmessage
		level = fnlevel
		app = fnapp
		
		-- Call commonLog stuff
		commonLog()
		
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
		else
			logmsgcolour = "white"		-- Any other messages should be white
		end
		
		-- Print to game console:
		printToConsole("[" .. level .. "] " .. app .. ": " .. message, logmsgcolour) -- TODO: code printToConsole
		
		-- Print to native LUA console:
		print("[" .. level .. "] " .. app .. ": " .. message)
		
	end
end

-- simpleLog (logs to only LUA console in same style as consoleLog. Doesn't require XelLib to be loaded)

function simpleLog(fnmessage2, fnlevel2, fnapp2)
	level = fnlevel2
	commonLog()
	print(fnlevel2 .. "/ " .. fnapp2 .. ": " .. fnmessage2)
end

-- commonLog (Common Logging functions)

function commonLog()
	if level == "F" then
		fatalcalled = true -- Mark that a fatal error has been called
	end
end