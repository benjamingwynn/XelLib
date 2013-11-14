-- > XelLib
-- >> Created by Benjamin Gwynn
-- >> Licensed under the GNU GENERAL PUBLIC LICENSE V2

-- >>> xellib_core/xelres.lua
-- >>> Screen resolution management

-- fullscreenToggle (a fullscreen toggle system, originally coded for Natura and modified for XelLib.)
function fullscreenToggle()
	fullscreen = not fullscreen
	if fullscreen == true then
		if love.filesystem.exists("XelLib/x_res.dat") == true and love.filesystem.exists("XelLib/y_res.dat") == true then -- If settings exist:
			readScreenRes()
			love.graphics.setMode(x_res, y_res, true, vsync)
		else -- If the required settings data doesn't exist:
			love.graphics.setMode(0, 0, true, vsync) -- 0x0 = auto
			-- There is currently a bug with LOVE that causes the screen to stay white when AUTOxAUTO is used. Refresh the screen res to fix this:
			love.graphics.setMode(love.graphics.getWidth(),love.graphics.getHeight(), true, vsync)
			-- Write screen res
			writeScreenRes()
		end
	else
		love.graphics.setMode(800, 600, false, vsync)
	end
end