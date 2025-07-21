Plush.setRenderDistance(75)
Plush.fog(white[1], white[2], white[3])
Plush.setFov(60)
Plush.setPlayerHeight(5, 7)
Plush.setPlayerRotation(0)

if (imageVector) then
	for i = 1, #imageVector do
		if (imageVector[i - 1]) then
			Plush.killImage(imageVector[i - 1])
			imageVector[i - 1] = nil
		end
	end
end

wall1 = Plush.loadPNG(rompath .. '/tiles/wall1.png')
wall2 = Plush.loadPNG(rompath .. '/tiles/wall2.png')
wall3 = Plush.loadPNG(rompath .. '/tiles/wall3.png')
wall4 = Plush.loadPNG(rompath .. '/tiles/wall4.png')
wall5 = Plush.loadPNG(rompath .. '/tiles/wall5.png')
wall6 = Plush.loadPNG(rompath .. '/tiles/wall6.png')
plushiesolid = Plush.loadPNG(rompath .. '/tiles/plushiesolid.png')
transparent = Plush.loadPNG(rompath .. '/tiles/transparent.png')
roof = Plush.loadPNG(rompath .. '/tiles/roof.png')
walls = Plush.loadPNG(rompath .. '/tiles/walls.png')
wall7 = Plush.loadPNG(rompath .. '/tiles/wall7.png')

imageVector = {nil, wall1, wall2, wall3, wall4, wall5, wall6, plushiesolid, transparent, roof, walls, wall7, wall7}
--				   0    1      2      3      4      5      6      7             8            9     10     11     12
doorclosed = 6
doorbuffer = 12
roofVector = {
	{  9,  9,  9,  9,  9,  9,  9,  9,  9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10},
	{  9,  9,  9,  9,  9,  9,  9,  9,  9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10},
	{  9,  9,  9,  9,  9,  9,  9,  9,  9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10},
	{  9,  9,  9,  9,  9,  9,  9,  9,  9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10},
	{  9,  9,  9,  9,  9,  9,  9,  9,  9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10},
	{  9,  9,  9,  9,  9,  9,  9,  9,  9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10},
	{  9,  9,  9,  9,  9,  9,  9,  9,  9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10},
	{  9,  9,  9,  9,  9,  9,  9,  9,  9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10},
	{  9,  9,  9,  9,  9,  9,  9,  9,  9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10},
}
roofOffsetVector = {
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  8, 16, 24,  0, 40, 48, 56, 64, 72, 80,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  8,  0, 24,  0, 40,  0, 56, 64, 72, 80,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  8,  0, 24,  0, 40,  0, 56, 64, 72, 80,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  8,  0, 24,  0, 40,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  8,  0, 24, 32, 40,  0, 56,  0, 72, 80,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  8,  0, 24,  0, 40,  0, 56, 64, 72, 80,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  8, 16, 24, 32, 40, 48, 56,  0, 72, 80,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
}                                                                                     
wallsVector = {                                                                       
	{  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1},
	{  1,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  0,  8,  0,  0,  0,  0,  0,  0,  1},
	{  1,  0,  1,  0,  0,  0,  0,  0,  1,  0,  8,  0,  8,  0,  8,  0,  0,  7,  0,  1},
	{  1,  0,  2,  0,  0,  0,  0,  0,  1,  0,  8,  0,  8,  0,  8,  0,  0,  0,  0,  1},
	{  6,  0,  3,  0,  8,  0,  0,  0,  0,  0,  8,  0,  8,  0,  8,  8,  8,  8,  8,  1},
	{  1,  0,  4,  0,  0,  0,  0,  0,  1,  0,  8,  0,  0,  0,  8,  0,  8,  0,  0,  1},
	{  1,  0,  5,  0,  0,  0,  0,  0,  1,  0,  8,  8,  8,  0,  8,  0,  0,  0,  0,  1},
	{  1,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  0,  0,  0,  0,  0,  8,  0,  0,  1},
	{  1,  1,  1,  1,  1,  1,  1,  5,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1},
}                                                                                                                                              
floorVector = {                                                                                                                                              
	{ 10, 10, 10, 10, 10, 10, 10, 10, 10,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1},
	{ 10, 10, 10, 10, 10, 10, 10, 10, 10,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1},
	{ 10, 10, 10, 10, 10, 10, 10, 10, 10,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1},
	{ 10, 10, 10, 10, 10, 10, 10, 10, 10,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1},
	{ 10, 10, 10, 10, 10, 10, 10, 10, 10,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1},
	{ 10, 10, 10, 10, 10, 10, 10, 10, 10,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1},
	{ 10, 10, 10, 10, 10, 10, 10, 10, 10,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1},
	{ 10, 10, 10, 10, 10, 10, 10, 10, 10,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1},
	{ 10, 10, 10, 10, 10, 10, 10, 10, 10,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1},
}                                                                                                                                              
floorOffsetVector = {                                                                       
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  8,  0,  8,  0,  8,  0,  8,  0,  8,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  8,  0,  8,  0,  8,  0,  8,  0,  8,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  8,  0,  8,  0,  8,  0,  8,  0,  8,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  8,  0,  8,  0,  8,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  8,  0,  8,  0,  8,  0,  8,  0,  8,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  8,  0,  8,  0,  8,  0,  8,  0,  8,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  8,  0,  8,  0,  8,  0,  8,  0,  8,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
}
eastVector = {
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
}
northVector = {
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  6,  0,  0,  0,  6,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
}
eventVector = {
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  3,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  2,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},
}
Plush.setMap(wallsVector, roofVector, floorVector, roofOffsetVector, floorOffsetVector, imageVector, eastVector, northVector)
eventTable = {}
eventTable[1] = [[
	for i = 1, #imageVector do
		if (imageVector[i - 1]) then
			Plush.killImage(imageVector[i - 1])
			imageVector[i - 1] = nil
		end
	end

	wx = playerx
	wy = playery

	location = 0
	file = io.open(rompath .. '/scripts/abyssdungeons/' .. location .. 'map0.lua')
	if (file) then
		file:close()
		dofile(rompath .. '/scripts/abyssdungeons/' .. location .. 'map0.lua')
	else
		dofile(rompath .. '/scripts/abyssdungeons/0map0.lua')
	end

	playery = wy
	playerx = wx
	alatch = false
]]
eventTable[2] = [[
	for i = 1, #imageVector do
		if (imageVector[i - 1]) then
			Plush.killImage(imageVector[i - 1])
			imageVector[i - 1] = nil
		end
	end

	wx = playerx
	wy = playery

	location = -1
	file = io.open(rompath .. '/scripts/abyssdungeons/' .. location .. 'map0.lua')
	if (file) then
		file:close()
		dofile(rompath .. '/scripts/abyssdungeons/' .. location .. 'map0.lua')
	else
		dofile(rompath .. '/scripts/abyssdungeons/0map0.lua')
	end

	playery = wy
	playerx = wx
	alatch = false
]]
eventTable[3] = [[
	if (textsurface) then
		Plush.killImage(textsurface)
		textsurface = nil
	end
	textsurface = Font.renderText('congrats you discovered plushie\ndid you know plushies name is beiyang?', meiyro25[1], 255, 255, 255, 255)
	displaytext = true
	approve = 'puts "Plush.setPlayerHeight(1, 2);Plush.setRenderDistance(750)"'
	disapprove = 'puts "Plush.setPlayerHeight(5, 7);Plush.setRenderDistance(75)"'
]]