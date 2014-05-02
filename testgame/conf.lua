-- Config for the LOVE engine

function love.conf(t)
    t.title = "XelLib Test"		-- The title of the window the game is in (string)
    t.author = "Benjamin Gwynn"	-- The author of the game (string)
    t.url = nil					-- The website of the game (string)
    t.identity = "XLtest"		-- The name of the save directory (string)
    t.version = "0.9.1"			-- The LÖVE version this game was made for (string)
    t.console = true			-- Attach a console (boolean, Windows only)
    t.release = false			-- Enable release mode (boolean)
    t.screen.width = 800		-- The window width (number)
    t.screen.height = 600		-- The window height (number)
    t.screen.fullscreen = false	-- Enable fullscreen (boolean)
    t.screen.vsync = true		-- Enable vertical sync (boolean)
    t.screen.fsaa = 0			-- The number of FSAA-buffers (number)
end
