Plush.killImage(WINTER_FRAMEBUFFER); WINTER_FRAMEBUFFER = Plush.createImage(12, 12, 255, 255, 255, 255) --change the size of the field with the first 2 numbers
appletile = Plush.createImage(1, 1, 255, 0, 0, 255)
emptytile = Plush.createImage(1, 1, 0, 0, 0, 255)
snaketile = Plush.createImage(1, 1, 0, 200, 0, 255)
headtile = Plush.Plush.createImage(1, 1, 0, 255, 0, 255)
x, y = Plush.imageSize(WINTER_FRAMEBUFFER); x = x - 2; y = y - 2; field = {}
repeat
	field[#field + 1] = {}
	for i = 1, x do
		field[#field][i] = 0
	end
until y == #field
field[math.random(#field)][math.random(#field[#field])] == 255
repeat
	x = math.random(#field[#field]); y = math.random(#field); length = 3
	if x > #field[#field] - 3 then;     direction = 2
	elseif x < #field[#field] + 3 then; direction = 0
	end
until field[y][x] == 0
field[y][x] = length
repeat
	for i = 1, #field, do
		for j = 1, #field[i] do
			colourpointer = field[i][j]
			if colourpointer == 0 then;          colourpointer = emptytile
			elseif colourpointer == 255 then;    colourpointer = appletile
			elseif colourpointer == length then; colourpointer = headtile
			else;                                colourpointer = snaketile
			end
			Plush.blitImage(WINTER_FRAMEBUFFER, colourpointer, j + 1, i + 1, false, 1.0, 0.0)
			if not field[i][j] == 255 or not field[i][j] == 0 then
				field[i][j] = field[i][j] - 1
			end
		end
	end
	Render.updateInput()
	if WINTER_KEY_W then;     direction = 3
	elseif WINTER_KEY_A then; direction = 0
	elseif WINTER_KEY_S then; direction = 1
	elseif WINTER_KEY_D then; direction = 2
	end
	if not Winter.between(direction, 0, 3) then
		direction = 0
	end
	if direction == 0 then;     x = x + 1
	elseif direction == 1 then; y = y + 1
	elseif direction == 2 then; x = x - 1
	elseif direction == 3 then; y = y - 1
	end
	if not Winter.between(y, #field, 1) or not Winter.between(x, #field[1], 1) then
		length = 0
	else
		if field[y][x] == 255 then
			length = length + 1
			field[math.random(#field)][math.random(#field[#field])] == 255 --yes this allows an apple to spawn on the snakes body, i am too lazy to add a check
		end
		field[y][x] = length
	end
	Render.renderImage(WINTER_FRAMEBUFFER); Render.forceUpdate()
until length == 0