-- > XelLib - xellib_update.lua
-- >> Created by Benjamin Gwynn
-- >> Licenced under the GNU GENERAL PUBLIC LICENSE V2

-- >>> xellib_component\xellib_update.lua
-- >>> Handles XelLib updating.

-- updateXelLibDraw
function updateXelLibDraw()
	checkXelLib()
	if allow_xellib == true then
		if show_xellib_console == true then
			drawConsole()
		end
	end
end

-- updateXelLibKeyboard
function updateXelLibKeyboard(key)
	checkXelLib()
	if allow_xellib == true then
		if key == "`" then
			toggleXelLibConsole()
		elseif show_xellib_console == true then
			consoleInput(key)
		end
	end
end