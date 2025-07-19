Plush.setRenderDistance(75)
Plush.fog(black[1], black[2], black[3])
Plush.setFov(60)
Plush.setPlayerHeight(5, 7)
Plush.setPlayerRotation(0)

if (imageVector) then
	for i = 1, #imageVector do
		if (imageVector[i - 1]) then
			Render.killImage(imageVector[i - 1])
			imageVector[i - 1] = nil
		end
	end
end

wall1 = Render.loadPNG(rompath .. '/tiles/wall1.png')
wall2 = Render.loadPNG(rompath .. '/tiles/wall2.png')
wall3 = Render.loadPNG(rompath .. '/tiles/wall3.png')
wall4 = Render.loadPNG(rompath .. '/tiles/wall4.png')
wall5 = Render.loadPNG(rompath .. '/tiles/wall5.png')
wall6 = Render.loadPNG(rompath .. '/tiles/wall6.png')
plushiesolid = Render.loadPNG(rompath .. '/tiles/plushiesolid.png')
transparent = Render.loadPNG(rompath .. '/tiles/transparent.png')
roof = Render.loadPNG(rompath .. '/tiles/roof.png')
walls = Render.loadPNG(rompath .. '/tiles/walls.png')
wall7 = Render.loadPNG(rompath .. '/tiles/wall7.png')

imageVector = {nil, wall1, wall2, wall3, wall4, wall5, wall6, plushiesolid, transparent, roof, walls, wall7, wall7}
--				   0    1      2      3      4      5      6      7             8            9     10     11     12
doorclosed = 6
doorbuffer = 12
roofVector = {
	{  9,  9,  9,  9,  9,  9,  9,  9,  9},
	{  9,  9,  9,  9,  9,  9,  9,  9,  9},
	{  9,  9,  9,  9,  9,  9,  9,  9,  9},
	{  9,  9,  9,  9,  9,  9,  9,  9,  9},
	{  9,  9,  9,  9,  9,  9,  9,  9,  9},
	{  9,  9,  9,  9,  9,  9,  9,  9,  9},
	{  9,  9,  9,  9,  9,  9,  9,  9,  9},
	{  9,  9,  9,  9,  9,  9,  9,  9,  9},
	{  9,  9,  9,  9,  9,  9,  9,  9,  9},
}
roofOffsetVector = {
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
}
wallsVector = {
	{  1,  1,  1,  1,  5,  1,  1,  1,  1},
	{  1,  0,  0,  0,  0,  0,  0,  0,  1},
	{  1,  0,  2,  2,  2,  0,  2,  0,  1},
	{  1,  0,  2,  0,  2,  0,  2,  0,  1},
	{  1,  0,  3,  0,  0,  0,  3,  0,  1},
	{  1,  0,  1,  0,  1,  0,  1,  0,  1},
	{  1,  0,  1,  0,  1,  1,  1,  0,  1},
	{  1,  0,  0,  0,  0,  0,  0,  0,  1},
	{  1,  1,  1,  1,  1,  1,  1,  1,  1},
}
floorVector = {
	{ 10, 10, 10, 10, 10, 10, 10, 10, 10},
	{ 10, 10, 10, 10, 10, 10, 10, 10, 10},
	{ 10, 10, 10, 10, 10, 10, 10, 10, 10},
	{ 10, 10, 10, 10, 10, 10, 10, 10, 10},
	{ 10, 10, 10, 10, 10, 10, 10, 10, 10},
	{ 10, 10, 10, 10, 10, 10, 10, 10, 10},
	{ 10, 10, 10, 10, 10, 10, 10, 10, 10},
	{ 10, 10, 10, 10, 10, 10, 10, 10, 10},
	{ 10, 10, 10, 10, 10, 10, 10, 10, 10},
}
floorOffsetVector = {
	{-16,-16,-16,-16,-16,-16,-16,-16,-16},
	{-16,-16,-16,-16,-16,-16,-16,-16,-16},
	{-16,-16,-16,-16,-16,-16,-16,-16,-16},
	{-16,-16,-16,-16,-16,-16,-16,-16,-16},
	{-16,-16,-16,-16,-16,-16,-16,-16,-16},
	{-16,-16,-16,-16,-16,-16,-16,-16,-16},
	{-16,-16,-16,-16,-16,-16,-16,-16,-16},
	{-16,-16,-16,-16,-16,-16,-16,-16,-16},
	{-16,-16,-16,-16,-16,-16,-16,-16,-16},
}
eastVector = {
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
}
northVector = {
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  6,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
}
eventVector = {
	{  0,  0,  0,  0,  1,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  2,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
	{  0,  0,  0,  0,  0,  0,  0,  0,  0},
}
Plush.setMap(wallsVector, roofVector, floorVector, roofOffsetVector, floorOffsetVector, imageVector, eastVector, northVector)
eventTable = {}
eventTable[1] = [[
	for i = 1, #imageVector do
		if (imageVector[i - 1]) then
			Render.killImage(imageVector[i - 1])
			imageVector[i - 1] = nil
		end
	end

	wx = playerx
	wy = playery

	location = 0
	file = io.open(rompath .. '/scripts/abyssdungeons/' .. location .. 'map1.lua')
	if (file) then
		file:close()
		dofile(rompath .. '/scripts/abyssdungeons/' .. location .. 'map1.lua')
	else
		dofile(rompath .. '/scripts/abyssdungeons/0map0.lua')
	end

	playery = wy
	playerx = wx
	alatch = false
]]
eventTable[2] = [[
	if (textsurface) then
		Render.killImage(textsurface)
		textsurface = nil
	end
	textsurface = Font.renderText('debug message\nwalk into the door to open\n\nz: confirm, x: cancel', meiyro25[1], 255, 255, 255, 255)
	displaytext = true
	approve = 'puts "print(\'user approved action\')"'
	disapprove = 'puts "print(\'user disapproved action\')"'
]]