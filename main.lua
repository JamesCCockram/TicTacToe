-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local widget = require("widget")

local background = display.newImageRect("background.jpg",1234, 750  )
background.x = 400
background.y = 250

CenterX = display.contentCenterX
CenterY = display.contentCenterY

--Text
lblTitle = display.newText("Tic Tac Toe", CenterX, 0 ,native.systemFontBold, 42)

padding = 5
squareWidth = ((display.contentWidth - (2*padding))/3)

turn = -1
turns = 0
squares = {0,0,0,0,0,0,0,0,0}
isGameOver = false

function squareListener( event )
	if event.phase == "ended" then
		squareID = event.target.id
			if squares[squareID] == 0 then
				if turn == 1 then
					icon = display.newImageRect("O.png", squareWidth, squareWidth)
				else
					icon = display.newImageRect("X.png", squareWidth, squareWidth)
				end

			icon.x = event.target.x
			icon.y = event.target.y
			squares[squareID] = turn
			turn = -turn
			turns = turns + 1


		aiTurn = GetAITurn()
		if turn == 1 then
			icon = display.newImageRect("O.png", squareWidth, squareWidth)
		else
			icon = display.newImageRect("X.png", squareWidth, squareWidth)
		end

		icon.x = boardSquares[aiTurn].x
		icon.y = boardSquares[aiTurn].y
		squares[aiTurn] = turn
		turn = -turn
		turns = turns + 1

		isGameOver = checkWin()
	end
	end
	print("Turn:", turns)	
end


function GetAITurn( ... )
	if turns <= 8 then
		aiTurn = math.random(1,9)
		while squares[aiTurn] ~= 0 do
		aiTurn = math.random(1,9)
		end
	else
		isGameOver = true
	end
return aiTurn
end

function resetGame( ... )
	turns = 0
	display.remove(lblGameOver)
	display.remove(resetButton)
	display.remove(drawBoard())
	squares = {0,0,0,0,0,0,0,0,0}
	drawBoard()
end


function checkWin( ... )
	if squares[1] == squares[2] and squares[2] == squares[3] and squares[1] ~= 0 then
		isGameOver = true
	elseif squares[4] == squares[5] and squares[5] == squares[6] and squares[4] ~= 0 then
		isGameOver = true
	elseif squares[7] == squares[8] and squares[8] == squares[9] and squares[7] ~= 0 then
		isGameOver = true
	elseif squares[1] == squares[4] and squares[4] == squares[7] and squares[1] ~= 0 then
		isGameOver = true
	elseif squares[2] == squares[5] and squares[5] == squares[8] and squares[2] ~= 0 then
		isGameOver = true
	elseif squares[3] == squares[6] and squares[6] == squares[9] and squares[3] ~= 0 then
		isGameOver = true
	elseif squares[1] == squares[5] and squares[5] == squares[9] and squares[1] ~= 0 then
		isGameOver = true
	elseif squares[3] == squares[5] and squares[5] == squares[7] and squares[3] ~= 0 then
		isGameOver = true
	elseif turns >= 9 then
		isGameOver = true
	end
	if isGameOver == true then
		print("Game Over!")
		lblGameOver = display.newText("Game Over" , CenterX, 425, native.systemFontBold, 42)


	resetButton = widget.newButton({
	label = "Reset",
	x = CenterX,
	y = 500,
	font = native.systemFontBold,
	fontSize = 20,
	shape="roundedRect",
	labelColor = {default={1,1,1}, over={0,0,0,0.5}},
	fillColor = {default={.5,.5,.5,1}, over={0.8,0.8,1,1}},
	strokeWidth = 4,
	onPress = resetGame
})
	end
end

boardSquares = {}

function drawBoard( ... )
	y = 100
	for i=1,3 do
		x = squareWidth/2
		for j=1,3 do
			square = display.newRect(x,y, squareWidth, squareWidth)
			square:setFillColor(1,1,1, 0.5)
			square:addEventListener("touch", squareListener)
			square.id = j + ((i-1)*3)
			x = x + squareWidth + padding
			boardSquares[square.id] = square
		end
		y = y + squareWidth + padding
	end
end
drawBoard()


--Radio Buttons

-- Handle press events for the buttons
local function onSwitchPress( event )
    local switch = event.target
    print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
end
 
-- Create a group for the radio button set
local radioGroup = display.newGroup()
 
-- Create two associated radio buttons (inserted into the same display group)
local PlayerVsPlayer = widget.newSwitch(
    {
        x = 100,
        y = 400,
        style = "radio",
        id = "PlayerVsPlayer",
        initialSwitchState = true,
        onPress = onSwitchPress
    }
)
radioGroup:insert( PlayerVsPlayer )
 
local AIPlayer = widget.newSwitch(
    {
        x = 200,
        y = 400,
        style = "radio",
        id = "AIPlayer",
        onPress = onSwitchPress
    }
)
radioGroup:insert( AIPlayer )
 