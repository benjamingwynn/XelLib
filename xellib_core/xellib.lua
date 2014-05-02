-- > XelLib
-- >> Created by Benjamin Gwynn
-- >> Licensed under the GNU GENERAL PUBLIC LICENSE V2

-- >>> xellib_core/xellib.lua
-- >>> This is the primary XelLib script and is required to be called on game startup.

-- Load XelLib files:

require("xellib_core/xellog")
require("xellib_core/xelconsole")
require("xellib_core/xelcmd")
require("xellib_core/xelres")
require("xellib_core/xelsound")

require("../xellib_component/xellib_update")
require("../xellib_component/xellib_data")

require("../xellib_external/TSerial")

-- loadXelLib (loads XelLib stuff so other functions from XelLib can be called)

function loadXelLib(xellib_load_game_title, xellib_load_api_request, xellib_load_game_version)
	-- Set XelLib version variables:
	xellib = "XelLib"
	xellib_version = 0.3
	xellib_version_name = "The Massive Update"
	
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
	prevconsoleinput = {}
	logqueue_msg = {}
	logqueue_lvl = {}
	logqueue_app = {}
	logcount = 0
	cmdhandledcount = 0
	msgcount = 0
	consoleoverflow = 0
	z = 0
	uppresscount = -1
	inputcount = 0
	h = 0
	line_total = 0
	txcount = 0
	cmd_total_count = 0
	cmd = ""
	
	-- 0.3+ title check
	if not xellib_load_game_title then
		if xellib_game_name then
			simpleLog("XelLib 0.3+ title value was not given in load function, but xellib_game_name was. Please update to function arguments rather than defining xellib_game_name.", "F", "XelLib")
		else
			simpleLog("Game title was not given in load function. Please see documentation.", "F", "XelLib")
		end
	end
	
	-- 0.3+ game version check
	if not xellib_load_game_version then
		if xellib_game_version then
			simpleLog("XelLib 0.3+ version value was not given in load function, but xellib_game_version was. Please update to function arguments rather than defining xellib_game_version.", "F", "XelLib")
		else
			simpleLog("Game version was not given in load function. Please see documentation.", "F", "XelLib")
		end
	end
	
	-- 0.3+ API version check
	
	if not xellib_load_api_request then
		if xellib_requested_version then
			simpleLog("XelLib 0.3+ API target was not given in load function, but xellib_requested_version was. Please update to function arguments rather than defining xellib_requested_version.", "F", "XelLib")
		else
			simpleLog("API target was not given in load function. Please see documentation.", "F", "XelLib")
		end
	elseif xellib_load_api_request < 0.3 then
		simpleLog("Cannot use this method of loading prior to 0.3, therefore target version must be at least 0.3.", "F", "XelLib")
	elseif xellib_load_api_request < xellib_load_api_request then
		simpleLog("This version of XelLib is newer than the version your game has requested.", "W", "XelLib")
	elseif xellib_load_api_request > xellib_load_api_request then
		simpleLog("This version of XelLib is older than the version your game has requested. XelLib will continue to run, however some features may not work as expected.", "E", "XelLib")
	end

	-- Old definition check
	if xellib_game_name then simpleLog("xellib_game_name is still defined. It is recommended you remove this.", "W", "XelLib") end
	if xellib_game_version then simpleLog("xellib_game_version is still defined. It is recommended you remove this.", "W", "XelLib") end
	if xellib_requested_version then simpleLog("xellib_requested_version is still defined. It is recommended you remove this.", "W", "XelLib") end
	
	-- Legacy support
	xellib_game_name = xellib_load_game_title
	
	-- Allow other XelLib scripts to be used:
	if fatalcalled then
		allow_xellib = false
		simpleLog("XelLib has failed to start.", "E", "XelLib")
	else
		allow_xellib = true
	end

	if allow_xellib then
		-- Set up XelLib IO stuff
		dataOnLoad()
		
		-- Set up window
		consoleLog("Setting up XelRes...", "I", "XelLib")
		setupGraphics()
		
		-- Load XelLib font
		xellib_body_font = love.graphics.setNewFont("xellib_resources/font/Roboto-Regular.ttf")

		-- Set up XelLib default commands:
		defaultCommands()
		
		-- Say Hello, XelLib:
		consoleLog("XelLib '" .. xellib_version_name .. "' (" .. xellib_version .. ") is now ready.", "I", "XelLib")
		consoleLog("Created by Benjamin Gwynn (https://github.com/benjamingwynn)", "I", "XelLib")
	end
end

--checkxellib
function checkXelLib()
	simpleLog("checkXelLib() has moved to xelLibLoaded().", "E", "XelLib")
end

-- xelLibLoaded (checks to see if XelLib stuff has been loaded)
function xelLibLoaded()
	if not ignorecalls then
		if loadretry then
			simpleLog("Could not load XelLib. Any attempts to call XelLib functions after this point will be ignored.", "F", "XelLib")
			ignorecalls = true
			loadretry = false
		else
			if not allow_xellib then
				simpleLog("XelLib is not loaded or loaded inpropery. Attempting to load it...", "W", "XelLib")
				loadretry = true
				loadXelLib()
			end
		end
	end
	if not times_checked then times_checked = 0 end
	times_checked = times_checked + 1
	if allow_xellib then
		if times_checked == 500 then -- On 500'th call check if the game is updating XelLib.
			if not update_called_cpu then
				consoleLog("XelLib is not being called to update under this games love.update - Please resolve this or XelLib will behave incorrectly.", "E", "XelLib")
			end
			if not update_called_draw then
				consoleLog("XelLib is not being called to update under this games love.draw - Please resolve this or XelLib will behave incorrectly.", "E", "XelLib")
			end
		end
	end
	return allow_xellib
end

function zero()
	-- this function does nothing.
end
