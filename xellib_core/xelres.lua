-- > XelLib
-- >> Created by Benjamin Gwynn
-- >> Licensed under the GNU GENERAL PUBLIC LICENSE V2

-- >>> xellib_core/xelres.lua
-- >>> Screen resolution management

function setupGraphics()
	-- Clean up older stuff
	if love.filesystem.exists("XelLib/y_res.dat") then love.filesystem.remove("XelLib/y_res.dat") end
	if love.filesystem.exists("XelLib/x_res.dat") then love.filesystem.remove("XelLib/x_res.dat") end
	
	if love.filesystem.exists("XelLib/xelres_settings.dat") then
		consoleLog("Previously created screen data exists.", "I", "XelLib")
		readGraphicsData()
	else
		consoleLog("Previously created screen data does not exist.", "W", "XelLib")
		createGraphicsData()
	end
	refreshGraphics()
end

function createGraphicsData()
	consoleLog("Creating graphics data.", "I", "XelLib")
	xelres_settings = {}
	xelres_settings.fullscreen = false
	xelres_settings.resizable = false
	xelres_settings.fullscreentype = "normal"
	xelres_settings.vsync = false
	xelres_settings.fsaa = 0
	xelres_settings.borderless = false
	xelres_settings.centered = true
	xelres_settings.display = 1
	xelres_settings.minwidth = 800
	xelres_settings.minheight = 600
	writeGraphicsData()
end

function refreshGraphics_default()
	love.window.setMode(xelres_settings.minwidth, xelres_settings.minheight, xelres_settings)
end

function refreshGraphics()
	readGraphicsData()
	consoleLog("Refreshing screen.", "I", "XelLib")
	love.window.setMode(love.graphics.getWidth(), love.graphics.getHeight(), xelres_settings)
end

-- These older functions below have been modified to work with the newer code.

-- fullscreenToggle (quick fullscreen toggle)
function fullscreenToggle()
	xelres_settings.fullscreen = not xelres_settings.fullscreen
	writeGraphicsData() refreshGraphics_default()
end

-- fsWindowToggle
function fsWindowToggle()
	if xelres_settings.fullscreentype == "normal" then
		consoleLog("Will now change res to fill screen.", "I", "XelLib")
		xelres_settings.fullscreentype = "desktop"
	else
		consoleLog("Will now strech to fill screen.", "I", "XelLib")
		xelres_settings.fullscreentype = "normal"
	end
	writeGraphicsData() refreshGraphics_default()
end
