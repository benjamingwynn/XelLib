-- > XelLib
-- >> Created by Benjamin Gwynn
-- >> Licensed under the GNU GENERAL PUBLIC LICENSE V2

-- >>> xellib_component/xellib_data.lua
-- >>> Handles data I/O for XelLib

-- dataOnLoad (this function is loaded during XelLib initialization and is used for startup I/O commands.)
function dataOnLoad()
	if not love.filesystem.isDirectory("XelLib") then
		setupXelLibDir()
	end
end

-- setupXelLibDir (sets up the XelLib directory for settings to be stored in the future.)
function setupXelLibDir()
	consoleLog("XelLib folder not created. Creating now...", "I", "XelLib")
	if not love.filesystem.createDirectory("XelLib") then
		consoleLog("Could not create XelLib settings folder.", "E", "XelLib")
	else
		consoleLog("Created settings folder.", "I", "XelLib")
	end
end

-- readScreenRes (reads the screen resolution from saved settings)
function readGraphicsData()
	xelres_settings = Tserial.unpack(love.filesystem.read("XelLib/xelres_settings.dat"))
	print(xelres_settings.fullscreen)
end

-- writeScreenRes (writes the current screen resolution to the settings file)
function writeGraphicsData()
	love.filesystem.write("XelLib/xelres_settings.dat", Tserial.pack(xelres_settings, false, true)) -- table name, skip errors, human-readable
	-- writeXelLibVariable(xelres_settings, "xelres_settings")
end

-- writeXelLibVariable (writes a XelLib variable)
function writeXelLibVariable(var, file)
	if not love.filesystem.write("XelLib/" .. file.. ".dat", var) then
		consoleLog("Output error writing to the file '" .. file .. ".dat'", "W", "XelLib")
	else
		consoleLog("Successfully wrote variable '" .. var .. "' to '" .. file .. ".dat'", "I", "XelLib")
	end
end

function removeOldData()
	if love.filesystem.exists("XelLib/y_res.dat") then if love.filesystem.remove("XelLib/y_res.dat") then okRemove("y_res.dat") end end
	if love.filesystem.exists("XelLib/x_res.dat") then if love.filesystem.remove("XelLib/x_res.dat") then okRemove("x_res.dat") end end
end

function okRemove(file_removed)
	consoleLog("Removed file '" .. file_removed .. ".dat' as it is no longer needed by XelLib.", "W", "XelLib")
end
