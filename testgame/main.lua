-- > XelLib
-- >> Created by Benjamin Gwynn
-- >> Licensed under the GNU GENERAL PUBLIC LICENSE V2

-- >>> testgame/main.lua
-- >>> A small test game to show XelLib in action.

require("xellib_core/xellib")

function love.load()
	-- Define information about our test game
	testgame = {}
	testgame.name = "Test Game"
	testgame.apiversion = 0.3
	testgame.version = 0.1

	-- Load XelLib
	loadXelLib(testgame.name, testgame.apiversion, testgame.version)
	
	-- Start with console
	toggleXelLibConsole()
	
	-- Background
	love.graphics.setBackgroundColor(60, 100, 255, 255)
	
	-- Test text
	printToConsole("Welcome to the XelLib test game. This console is launched automatically.", "yellow", testgame.name)
	printToConsole("All XelLib updating in this version of the test game is handled by XelLib.", "yellow", testgame.name)

	-- Create an example command
	createCommand("example", "myExampleCommandFunction", false, testgame.name)

	-- Create a test float
	registerFloatValue("This is a 'float' - They are a work in progress.")
end

function love.update(dt)
	updateXelLibCPU(dt)
end

function love.draw()
	updateXelLibDraw()
end

function love.keypressed(t)
	updateXelLibKeyboard(t)
end

-- An example command function
function myExampleCommandFunction()
	local rand = math.random(5)
	local food
	if rand == 0 then food = "Cookie" end
	if rand == 1 then food = "Biscuit" end
	if rand == 2 then food = "Cake" end
	if rand == 3 then food = "Foodstuffs" end
	if rand == 4 then food = "Potato" end
	if rand == 5 then food = "Candy" end
	if food == "Cake" then
		printToConsole("The cake is a lie.", "red", testgame.name)
	else
		printToConsole(food .. " for you!", "blue", testgame.name)
	end
end
