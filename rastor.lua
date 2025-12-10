Metal.spawnWindow(WINTER_SCREEN_X, WINTER_SCREEN_Y, '<game name> | WinterMoon Engine ' .. WINTER_ENGINE_VERSION .. ' | ' .. WINTER_ENGINE_POSTFIX)
framecolour = {255, 0, 255}
drawFrame = true
frames = 0

whiteVertex = Winter.contents(Winter.getPath() .. '../Resources/scripts/white.vShader')
whiteFragment = Winter.contents(Winter.getPath() .. '../Resources/scripts/white.fShader')

renderer = Plush.spawnRenderer(480, 272, whiteVertex, whiteFragment)
camera = Plush.spawnCamera()
Plush.updateCamera(camera)
Plush.useCamera(renderer, camera)

playerx = 0
playery = 0
playerh = 5 + (7 / 12)

walls = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/walls.png')
wall1 = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/wall1.png')
wall2 = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/wall2.png')
wall3 = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/wall3.png')
wall4 = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/wall4.png')
wall5 = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/wall5.png')
wall6 = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/wall6.png')
pogwall = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/pog.png')
roof = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/floor.png')
floor = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/roof.png')
coheth = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/coheth.png')
cohetht = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/cohetht.png')
bricks1 = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/bricks1.png')
bricks2 = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/bricks2.png')
bricks3 = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/bricks3.png')
bricks4 = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/bricks4.png')
bricks5 = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/bricks5.png')
aestya = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/aestya.png')
plushiesolid = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/plushiesolid.png')
transparent = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/transparent.png')
signeast = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/signeast.png')
signnorth = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/signnorth.png')
furry = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/furry.png')
monji = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/monji.png')
monjic = Plush.loadPNG(Winter.getPath() .. '../Resources/package/characters/monji/test/nuetral.png')
reflection = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/reflections/roof.png')
Plush.insertReflection(floor, reflection)
Plush.killImage(reflection)
whitebox = Plush.createImage(1, 1, 255, 30, 30, 120)
longbox = Plush.createImage(1, 1, 190, 120, 80, 254)
Plush.fog(15, 0, 10)

imageVector = {walls, floor, roof, pogwall, wall1, wall2, wall3, wall4, wall5, wall6, coheth, bricks1, bricks2, bricks3, bricks4, bricks5, aestya, cohetht, plushiesolid, transparent, signeast, signnorth, furry, monji, whitebox, monjic, longbox}

cube = Plush.createCube()
cubeObject = Plush.createObject(cube, whitebox)

eastVector = {
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 16,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 16,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,},
},

Plush.setPlayerHeight(5, 7)
WINTER_FRAMERATE = 1000 / 75

playerx = 0
playery = 0
direction = Plush.getPlayerRotation() / 0.0174533
angle = Plush.getTilt() / 0.0174533
threads = 12
alatch = false

while not Metal.checkClose() do
	wtime = Winter.getClock()
	if (debugger == true) then
		debuglog = 'LOG: ' .. WINTER_PROCESSOR_NAME .. ':' .. WINTER_OS_PLATFORM .. ':' .. WINTER_OS_VERSION .. '\n'
		debugentries = 0
	end

	Plush.spawnObject(renderer, cubeObject, math.random(), math.random(), math.random(), math.random(), math.random(), math.random())

	Metal.updateInput()
	oldx = playerx
	oldy = playery
	playerx, playery = Plush.getPlayerPosition()

	if (WINTER_KEY_W) then
		Plush.movePlayer(1, true)
		alatch = false
	end
	if (WINTER_KEY_S) then
		Plush.movePlayer(-1, true)
		alatch = false
	end
	if (WINTER_KEY_Q) then
		Plush.movePlayer(-1, false)
		alatch = false
	end
	if (WINTER_KEY_E) then
		Plush.movePlayer(1, false)
		alatch = false
	end
	if (WINTER_KEY_A) then
		direction = direction - 15
		alatch = false
	end
	if (WINTER_KEY_D) then
		direction = direction + 15
		alatch = false
	end
	if (WINTER_KEY_UP) then
		angle = angle - 15
		alatch = false
	end
	if (WINTER_KEY_DOWN) then
		angle = angle + 15
		alatch = false
	end
	if (Plush.checkWall(playerx + (#eastVector[1] / 2), playery + (#eastVector / 2), eastVector)) then
		playerx = oldx
		playery = oldy
		Plush.setPlayerPosition(playerx, playery)
	end
	Plush.setPlayerRotation(direction * 0.0174533)
	Plush.setTilt(angle * 0.0174533)

	if (alatch == false) then
		Plush.updateCamera(camera)
		Plush.rastor(renderer, WINTER_FRAMEBUFFER)
		alatch = true
		--Plush.dither(WINTER_FRAMEBUFFER, 12.5, false)
		--Plush.bilinearSolid(WINTER_FRAMEBUFFER)
	end

	if (WINTER_KEY_RETURN == true) then
		window = Metal.getWindow()
		Plush.saveImage('/Users/plushie/Desktop/test.png', window)
	end

	if (drawFrame) then
		Render.renderImage(WINTER_FRAMEBUFFER)
		Metal.forceUpdate()
		Metal.clearBuffer(framecolour[1], framecolour[2], framecolour[3])
	end
	wtime = Winter.getClock()
	if (wtime <= WINTER_FRAMERATE) then
		Winter.sleep(math.floor(WINTER_FRAMERATE - wtime + 0.5))
	else
		if (debugger == true) then
			debugentries = debugentries + 1
			debuglog = debuglog .. debugentries .. ': Frame took too long to draw!!\n   Drawtime: ' .. wtime .. 'ms\n'
		end
	end
	if (debugger == true) then
		frames = frames + 1
		debugentries = debugentries + 1
		debuglog = debuglog .. debugentries .. ': Frame #' .. frames .. '\n   render time: ' .. wtime .. 'ms\n   drawtime: ' .. WINTER_FRAMERATE - wtime .. 'ms\n'
		print(debuglog)
	end
end

Metal.killWindow()
Plush.saveImage('/Users/plushie/Desktop/framebuffer.png', WINTER_FRAMEBUFFER)