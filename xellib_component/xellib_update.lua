-- > XelLib
-- >> Created by Benjamin Gwynn
-- >> Licensed under the GNU GENERAL PUBLIC LICENSE V2

-- >>> xellib_component/xellib_update.lua
-- >>> Handles XelLib updating.

-- updateXelLibCPU
function updateXelLibCPU()
	if xelLibLoaded() then
		update_called_cpu = true
		
		-- Prevent Sound
		if preventsound then
			love.audio.pause()
		end
	end
end

-- updateXelLibDraw
function updateXelLibDraw()
	if xelLibLoaded() then
		update_called_draw = true
		displayFloatValues()
		if show_xellib_console then
			drawConsole()
			consoleInputUIComponent()
		end
	end
end

-- updateXelLibKeyboard
function updateXelLibKeyboard(key)
	if xelLibLoaded() then
		update_called_keyboard = true
		if key == "`" then
			toggleXelLibConsole()
		elseif show_xellib_console == true then
			consoleInput(key)
		end
	end
end