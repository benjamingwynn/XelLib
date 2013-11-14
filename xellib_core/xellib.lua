-- > XelLib
-- >> Created by Benjamin Gwynn
-- >> Licensed under the GNU GENERAL PUBLIC LICENSE V2

-- >>> xellib_core/xellib.lua
-- >>> This is the primary XelLib script and is required to be called on game startup.

-- Load XelLib files:

require("xellib_core/xellog")
require("xellib_core/xelconsole")
require("xellib_core/xelcmd")

require("../xellib_component/xellib_update")

-- loadXelLib (loads XelLib stuff so other functions from XelLib can be called)

function loadXelLib()
	-- Set XelLib version variables:

	xellib = "XelLib"
	xellib_version = 0.1
	xellib_version_name = "Koala"
	
	-- Set XelLib required variables:
	consolemessage = {}
	consolemessagecolour = {}
	cmdp = {}
	consoleinput = {}
	xellibcommand = {}
	cmd_name = {}
	cmd_function = {}
	cmd_supports_arguments = {}
	cmd_hostapp = {}
	cmd_argument_individual = {}
	msgcount = 0
	consoleoverflow = 0
	z = 0
	b = 0
	a = 0
	h = 0
	line_total = 0
	txcount = 0
	cmd_total_count = 0
	cmd = ""
	
	-- Load XelLib font
	body = love.graphics.setNewFont( "xellib_resources/font/Roboto-Regular.ttf")
	
	-- Set font
	love.graphics.setFont(body)
	font = body -- Font calculations are done using 'font'

	-- Check variables:

	if not xellib_game_name then
		simpleLog("Variable 'xellib_game_name' not set correctly. Please resolve this or your game will not function with XelLib.", "F", "XelLib")
	end
	if not xellib_game_version then
		simpleLog("Variable 'xellib_game_version' not set correctly. Please resolve this or your game will not function with XelLib.", "F", "XelLib")
	end

	-- Version check:

	if not xellib_requested_version then
		simpleLog("Variable 'xellib_requested_version' not set correctly. Please resolve this or your game will not function with XelLib.", "F", "XelLib")
	elseif xellib_requested_version < xellib_version then
		simpleLog("This version of XelLib is newer than the version your game has requested.", "W", "XelLib")
	elseif xellib_requested_version > xellib_version then
		simpleLog("This version of XelLib is older than the version your game has requested. XelLib will continue to run, however some features may not work as expected.", "E", "XelLib")
	end
	
	-- Allow other XelLib scripts to be used:
	if fatalcalled == true then
		allow_xellib = false
	else
		allow_xellib = true
	end

	-- Set up XelLib default commands:
	defaultCommands()
	
	-- Say Hello, XelLib:
	consoleLog("XelLib '" .. xellib_version_name .. "' (" .. xellib_version .. ") is now ready.", "I", "XelLib")
	consoleLog("Created by Benjamin Gwynn (https://github.com/benjamingwynn)", "I", "XelLib")
end

-- checkXelLib (checks to see if XelLib stuff has been loaded)
function checkXelLib()
	if not ignorecalls then
		if loadretry == true then
			simpleLog("Could not load XelLib. Any attempts to call XelLib functions after this point will be ignored.", "F", "XelLib")
			ignorecalls = true
		else
			if not allow_xellib then
				simpleLog("XelLib is not loaded or loaded inpropery. Attempting to load it...", "W", "XelLib")
				loadretry = true
				loadXelLib()
			end
		end
	end
end