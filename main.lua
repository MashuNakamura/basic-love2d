-- local image
-- local imageData

-- local screen_w, screen_h
-- local image_w, image_h
-- local scale_x, scale_y

-- -- Load something, for example i want load some image
-- function love.load()
-- 	-- love.graphics.print("Hello World!", 400, 300)

-- 	-- Load the original Image
-- 	imageData = love.image.newImageData("hatsune-miku-4.jpg")

-- 	-- Convert and save as PNG
--     imageData:encode("png", "hatsune-miku-4.png")

-- 	-- Create drawable Image for drawing
--     image = love.graphics.newImage(imageData)
	
-- 	-- If you want to save the encoded image data that can be renamed
-- 	-- love.filesystem.write("hatsune-miku-4.png", encodedImageData)
-- 	-- The image will saved to ~/.local/share/love/<nama_game>/ -> Arch, if youre windows find it by yourself :v
-- end

-- -- Draw it here by using love.draw
-- function love.draw()
-- 	screen_w = love.graphics.getWidth()
-- 	screen_h = love.graphics.getHeight()

-- 	image_w = image:getWidth()
-- 	image_h = image:getHeight()

-- 	scale_x = screen_w / image_w
-- 	scale_y = screen_h / image_h

-- 	love.graphics.draw(image, 0, 0, 0, scale_x, scale_y)
-- end

function love.load()
	animation = newAnimation(love.graphics.newImage("heart.png"), 32, 32, 1)
end

-- function love.update(dt)
-- 	if animation.isPlaying == true then
-- 		animation.currentTime = animation.currentTime + dt
-- 		if animation.currentTime >= animation.duration then
-- 			animation.currentTime = animation.currentTime - animation.duration
-- 			animation.isPlaying = false
-- 		end
-- 	end
-- 	-- animation.currentTime = animation.currentTime + dt
-- 	-- if animation.currentTime >= animation.duration then
-- 	-- 	animation.currentTime = animation.currentTime - animation.duration
-- 	-- end
-- end

function love.keypressed(key)
	if key == "space" then
		-- animation.isPlaying = true
		-- animation.currentTime = 0
		-- Take other frame
		local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1

		-- Adjust duration to change frame rate
		animation.currentTime = animation.currentTime + animation.duration / #animation.quads

		-- If the duration is more than the total duration, reset it
		if animation.currentTime >= animation.duration then
			-- if you want to not loop, uncomment this
			-- animation.currentTime = animation.duration

			-- if you want to loop, uncomment this
			animation.currentTime = animation.currentTime - animation.duration

			-- or you can set it to 0
			-- animation.currentTime = 0
		end
	end
end

function love.draw()
    local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
    love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], 0, 0, 0, 4)
end

function newAnimation(image, width, height, duration)
	local animation = {}
	animation.spriteSheet = image
	animation.quads = {}

	for y = 0, image:getHeight() - height, height do
		for x = 0, image:getWidth() - width, width do
			table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
		end
	end

	animation.duration = duration or 1
	animation.currentTime = 0
	animation.isPlaying = false

	return animation
end
