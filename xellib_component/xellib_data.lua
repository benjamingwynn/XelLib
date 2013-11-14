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
	if not love.filesystem.mkdir("XelLib") then
		consoleLog("Could not create XelLib settings folder.", "E", "XelLib")
	else
		consoleLog("Created settings folder.", "I", "XelLib")
	end
end

-- readScreenRes (reads the screen resolution from saved settings)
function readScreenRes()
	y_res = love.filesystem.read("XelLib/y_res.dat")
	x_res = love.filesystem.read("XelLib/x_res.dat")
end

-- writeScreenRes (writes the current screen resolution to the settings file)
function writeScreenRes()
	writeXelLibVariable(love.graphics.getHeight(), "y_res")
	writeXelLibVariable(love.graphics.getWidth(), "x_res")
end

-- writeXelLibVariable (writes a XelLib variable)
function writeXelLibVariable(var, file)
	if not love.filesystem.write("xellib/" .. file.. ".dat", var) then
		consoleLog("Output error writing to the file '" .. file .. ".dat'", "W", "XelLib")
	else
		consoleLog("Successfully wrote variable '" .. var .. "' to '" .. file .. ".dat'", "I", "XelLib")
	end
end