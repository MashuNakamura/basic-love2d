-- function newButton(text, fn)
-- 	return {
-- 			text = text,
-- 			fn = fn,

--             next = false,
--             last = false,
-- 		}
-- end

-- local buttons = {}
-- local font = nil

-- function love.load()
-- 	font = love.graphics.newFont(32)

-- 	table.insert(buttons, newButton (
-- 		"Start Game",
-- 		function()
-- 			print("Start Game")
-- 		end
-- 	))

-- 	table.insert(buttons, newButton (
-- 		"Options",
-- 		function()
-- 			print("Options")
-- 		end
-- 	))

-- 	table.insert(buttons, newButton (
-- 		"Quit",
-- 		function()
-- 			print("Quit")
-- 		end
-- 	))
-- end

-- function love.update(dt)
-- end

-- function love.draw()
-- 	w = love.graphics.getWidth()
-- 	h = love.graphics.getHeight()

-- 	local bw = w * (1/4)
-- 	local bh = 64 

-- 	local margin = 16

-- 	local total_height = (bh + margin) * #buttons

-- 	local cursor_y = 0

--     -- Append all Buttons from Button {}
-- 	for i, button in ipairs(buttons) do
--         button.now = button.last

-- 		local pos_x = (w * 0.5) - (bw * 0.5)
-- 		local pos_y = (h * 0.5) - (bh * 0.5) - (total_height * 0.5) + cursor_y

--         -- Button Color
--         local color = {0.4, 0.4, 0.5, 1}

--         -- Get mouse position
--         local mx, my = love.mouse.getPosition()

--         -- Check if mouse is over button
--         local hovered = mx >= pos_x and mx <= pos_x + bw and my >= pos_y and my <= pos_y + bh

--         -- Change color if hovered
--         if hovered then
--             color = {0.9, 0.9, 1, 1}
--         end

--         -- Background rectangle
--         local unpack = unpack or table.unpack
-- 		love.graphics.setColor(unpack(color))
-- 		love.graphics.rectangle(
-- 			"fill",
-- 			pos_x,
-- 			pos_y,
-- 			bw,
-- 			bh
-- 		)
		
--         -- Text
-- 		love.graphics.setColor(0, 0, 0, 1)

--         local text_width = font:getWidth(button.text)
--         local text_height = font:getHeight(button.text)
        
-- 		love.graphics.print(
-- 			button.text,
-- 			font,
-- 			(w * 0.5) - text_width * 0.5,
--             pos_y + text_height * 0.5
-- 		)

-- 		cursor_y = cursor_y + (bh + margin)
-- 	end
-- end
local buttons = {}
local font = nil

-- screen / button layout vars
local w = 0
local h = 0
local bw = 0
local bh = 0
local margin = 0
local total_height = 0
local cursor_y = 0

function newButton(text, fn)
	return {
		text = text,
		fn = fn,
	}
end

function love.mousepressed(x, y, button, istouch, presses)
	if button == 1 then -- left click
		w = love.graphics.getWidth()
		h = love.graphics.getHeight()

		bw = w * (1/4)
		bh = 64
		margin = 16
		total_height = (bh + margin) * #buttons
		cursor_y = 0

		for _, b in ipairs(buttons) do
			local pos_x = (w * 0.5) - (bw * 0.5)
			local pos_y = (h * 0.5) - (bh * 0.5) - (total_height * 0.5) + cursor_y

			if x >= pos_x and x <= pos_x + bw and y >= pos_y and y <= pos_y + bh then
				b.fn() -- run once per click
			end

			cursor_y = cursor_y + (bh + margin)
		end
	end
end

function love.load()
	font = love.graphics.newFont(32)

	table.insert(buttons, newButton("Start Game", function() print("Start Game") end))
	table.insert(buttons, newButton("Options", function() print("Options") end))
	table.insert(buttons, newButton("Quit", function() print("Quit") end))
end

function love.update(dt)
end

function love.draw()
	w = love.graphics.getWidth()
	h = love.graphics.getHeight()

	bw = w * (1/4)
	bh = 64
	margin = 16
	total_height = (bh + margin) * #buttons
	cursor_y = 0

	for _, b in ipairs(buttons) do
		local pos_x = (w * 0.5) - (bw * 0.5)
		local pos_y = (h * 0.5) - (bh * 0.5) - (total_height * 0.5) + cursor_y

		local mx, my = love.mouse.getPosition()
		local hovered = mx >= pos_x and mx <= pos_x + bw and my >= pos_y and my <= pos_y + bh

		local color = {0.4, 0.4, 0.5, 1}
		if hovered then
			color = {0.9, 0.9, 1, 1}
		end

		love.graphics.setColor(color)
		love.graphics.rectangle("fill", pos_x, pos_y, bw, bh)

		-- text centered
		love.graphics.setColor(0, 0, 0, 1)
		local text_width = font:getWidth(b.text)
		local text_height = font:getHeight(b.text)
		love.graphics.print(
			b.text,
			font,
			(w * 0.5) - text_width * 0.5,
			pos_y + (bh * 0.5) - (text_height * 0.5)
		)

		cursor_y = cursor_y + (bh + margin)
	end
end