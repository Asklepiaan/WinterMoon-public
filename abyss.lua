function loadscreen()
	Winter.cleanup()
	renderQueue = {{
		type = WINTER_IMAGE,
		surface = nil,
		layer = 1,
		text = Winter.getPath() .. '../Resources/package/backgrounds/load.png',
		x = 0,
		y = 0,
		scale = 1.0,
		rotation = 0.0
	}}
	Winter.renderStack()
	Render.renderImage(WINTER_FRAMEBUFFER, 0, 0, 1.0, 0.0)
	Render.killTexture(WINTER_FRAMEBUFFER)
	Render.forceUpdate()
	Render.exchangeBuffer()
	Winter.sleep(WINTER_FRAMERATE)
end

function Winter.saveGame(slot)
	file = io.open(Winter.getPath() .. '../Resources/volatile/save' .. slot * 2 .. '.plush', 'w')
	loadOffset = Audio.pause(oldAudio)
	Audio.play(oldAudio, true, loadOffset)
	savestring = ''
	savestring = savestring .. 'story = ' .. story .. '\n'
	savestring = savestring .. 'health = ' .. health .. '\n'
	savestring = savestring .. 'mana = ' .. mana .. '\n'
	savestring = savestring .. 'location = ' .. location .. '\n'
	savestring = savestring .. 'character = ' .. character .. '\n'
	savestring = savestring .. 'party0 = ' .. party0 .. '\n'
	savestring = savestring .. 'party1 = ' .. party1 .. '\n'
	savestring = savestring .. 'party2 = ' .. party2 .. '\n'
	savestring = savestring .. 'party3 = ' .. party3 .. '\n'
	savestring = savestring .. 'party4 = ' .. party4 .. '\n'
	savestring = savestring .. 'money = ' .. money .. '\n'
	savestring = savestring .. 'bank = ' .. bank .. '\n'
	savestring = savestring .. 'st = ' .. st .. '\n'
	savestring = savestring .. 'loadOffset = ' .. loadOffset .. '\n'
	savestring = savestring .. 'oldAudio = ' .. oldAudio .. '\n'
	file:write(savestring)
	file:close()
	file = io.open(Winter.getPath() .. '../Resources/volatile/save' .. slot * 2 + 1 .. '.plush', 'w')
	file:write(Winter.checksum(savestring))
	file:close()
end

Render.spawnWindow(WINTER_SCREEN_X, WINTER_SCREEN_Y, 'Project Abyss engine port | WinterMoon Engine ' .. WINTER_ENGINE_VERSION .. ' | ' .. WINTER_ENGINE_POSTFIX)
Render.setup2D(0, WINTER_SCREEN_X, 0, WINTER_SCREEN_Y)

mapdebug = true --disable story access checks
demo = false --enable demo mode
newgame = true
prerelease = true --prerelease text in menu
rompath = Winter.getPath() .. '../Resources/package'
savepath = Winter.getPath() .. '../Resources/volatile'
frames = 0
slot = 0
location = -1
stamina = 500
portid = 1

math.randomseed(543486374)

white = {255, 255, 255, 255}
black = {0, 0, 0, 255}
red = {255, 0, 0, 255}
green = {0, 255, 0, 255}
yellow = {255, 255, 0, 255}
dgrey = {49, 49, 49, 255}
orange = {254, 85, 0, 255}
sblue = {0, 254, 254, 255}
dgreen = {5, 150, 0, 255}
clear = {0, 0, 0, 0, 255}
pink = {255, 128, 255, 255}
ugreen = {0, 255, 116, 255}
framecolour = white

--[[function stats()
	Graphics.fillRect(0, 60, 0, 544, black)
	Graphics.fillRect(0, 20, 0, 544 * (health / 500), orange)
	Graphics.fillRect(20, 40, 0, 544 * (mana / 500), sblue)
	Graphics.fillRect(40, 60, 0, 544 * (stamina / 500), dgreen)
	Graphics.drawImage(0, 0, bbar)
	if (ohp ~= health) then
		if (health > 0) then
			lightc = red
		end
		if (health > 100) then
			lightc = orange
		end
		if (health > 200) then
			lightc = yellow
		end
		if (health > 300) then
			lightc = green
		end
		if (health > 400) then
			lightc = sblue
		end
		statup = statup - 1
		if (statup == 0) then
			Controls.setLightbar(0, lightc)
			statup = 120
		end
		ohp = health
	end
end]]

meiyro43 = {Font.loadFont(rompath .. '/fonts/Meiyro.ttf', 43), 0}
meiyro25 = {Font.loadFont(rompath .. '/fonts/Meiyro.ttf', 25), 0}
meiyro15 = {Font.loadFont(rompath .. '/fonts/Meiyro.ttf', 15), 0}

if (demo) then
	menutext = 'TBD'
else
	menutext = 'This is a demo, please use the full release if available.'
end
if (prerelease) then
	menutext = 'This is a pre-release, this will be unstable, and most things are untested. Use at own risk.'
end

borders = { --1 = ((world map size / 2) + 1) * -1
	x = {
		[1] = -961,
		[2] = 1,
	},
	y = {
		[1] = -545,
		[2] = 1,
	},
}

ABYSS_MENU_MAIN = 0
ABYSS_TOWN = 1
ABYSS_MAP = 2
ABYSS_DUNGEON = 3
ABYSS_SAVE = 4

ABYSS_RENDER_MAP        =  0
ABYSS_RENDER_CLOUDS     =  1
ABYSS_RENDER_BORDER     =  2
ABYSS_RENDER_SHADE      =  3
ABYSS_RENDER_NEWGAME    =  4
ABYSS_RENDER_LOADGAME   =  5
ABYSS_RENDER_TICKER     =  6
ABYSS_RENDER_DEMO       =  7
ABYSS_RENDER_TOWN       =  8
ABYSS_RENDER_SIDEBAR    =  9
ABYSS_RENDER_TRAVEL     = 10
ABYSS_RENDER_TEXT       = 11
ABYSS_RENDER_PLAYER_BAR = 12
ABYSS_RENDER_LOCATOR    = 13
ABYSS_RENDER_LENSE      = 14
ABYSS_RENDER_STATUSBAR  = 15

ABYSS_SET_DEBUG    = 0
ABYSS_SET_METEOR   = 1
ABYSS_SET_FALSET   = 2
ABYSS_SET_SEA      = 3
ABYSS_SET_MOSS     = 4
ABYSS_SET_GRETCHIN = 5

overlay = {
	[-1] = { x = 9999, y = 9999, name = 'you shouldnt be able to see this lol', direction = 1, offset = 85,
		blight = false, docks = false, inn = false, dungeon = false, shop = false, bank = false, guild = false, heal = false,
		desc = 'this is the map id for the prerelease demo version, you should not be able to see this.',
		set = ABYSS_SET_DEBUG,
		story = { 10000, 10000, 10000, 10000, 10000, 10000, 10000, 10000, 10000, 10000, 10000},
	},
	[1] = { x = 179, y = 363, name = 'Meteor Island', direction = 1, offset = 0,
		blight = false, docks = false, inn = false, dungeon = true, shop = false, bank = false, guild = false, heal = false,
		desc = 'A small island that formed after a rock fell from the sky hundreds of years ago.',
		set = ABYSS_SET_METEOR,
		story = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	},
	[2] = { x = 149, y = 352, name = 'Meteor Port', direction = 3, offset = 85,
		blight = false, docks = true, inn = true, dungeon = false, shop = true, bank = false, guild = true, heal = false,
		desc = 'The only way in or out of Meteor Island. Not many people live here so the port is rarely active.',
		set = ABYSS_SET_METEOR,
		story = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	},
	[3] = { x = 169, y = 367, name = 'Meteor Shrine', direction = 2, offset = 0,
		blight = false, docks = false, inn = false, dungeon = true, shop = true, bank = false, guild = false, heal = true,
		desc = 'A small holy place at the peak of Meteor Island. It is belived to be the the closest place to the gods.',
		set = ABYSS_SET_METEOR,
		story = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	},
	[4] = { x = 286, y = 319, name = 'Fal\'set', direction = 1, offset = 0,
		blight = false, docks = false, inn = true, dungeon = false, shop = true, bank = true, guild = true, heal = false,
		desc = 'A dry and sandy island north-west of everything. It\'s close proximity to the Meteor Island has made it the trade centre of the world.',
		set = ABYSS_SET_FALSET,
		story = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	},
	[5] = { x = 346, y = 332, name = 'Fal\'set Harbor', direction = 1, offset = 0,
		blight = false, docks = true, inn = true, dungeon = false, shop = false, bank = false, guild = false, heal = false,
		desc = 'The main port in Fal\'set, hundreds of people come and go daily.',
		set = ABYSS_SET_FALSET,
		story = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	},
	[6] = { x = 433, y = 166, name = 'Mouth of the World', direction = 1, offset = 0,
		blight = false, docks = false, inn = false, dungeon = true, shop = false, bank = false, guild = false, heal = false,
		desc = 'A massive hole in the ocean floor, nobody knows when it appeared or what lies at the bottom.\nThe sea seems devoid of life around it.',
		set = ABYSS_SET_SEA,
		story = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	},
	[7] = { x = 208, y = 259, name = 'Fal\'set Wilds', direction = 1, offset = 0,
		blight = false, docks = false, inn = false, dungeon = true, shop = false, bank = false, guild = false, heal = false,
		desc = 'Wild and untamed lands west of Fal\'set.',
		set = ABYSS_SET_FALSET,
		story = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	},
	[8] = { x = 722, y = 113, name = 'Mist Point', direction = 1, offset = 0,
		blight = false, docks = true, inn = false, dungeon = true, shop = false, bank = false, guild = false, heal = false,
		desc = 'A strange island east of the Mouth of the World, nobody has fully explored it.',
		set = ABYSS_SET_SEA,
		story = { 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	},
	[9] = { x = 79, y = 255, name = 'Oracles Pond', direction = 1, offset = 0,
		blight = false, docks = false, inn = false, dungeon = false, shop = false, bank = false, guild = false, heal = true,
		desc = 'A set of 2 connected lakes with a small cabin between. Someone capable of removing Blight supposedly lives here.',
		set = ABYSS_SET_FALSET,
		story = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	},
	[10] = { x = 239, y = 665, name = 'Moss', direction = 2, offset = 0,
		blight = false, docks = false, inn = true, dungeon = false, shop = true, bank = true, guild = true, heal = true,
		desc = 'A massive western city on the continent of Moss. Many of it\'s citizens came fleeing the Blight on the other side.',
		set = ABYSS_SET_MOSS,
		story = { 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	},
	[11] = { x = 283, y = 651, name = 'Moss Port', direction = 1, offset = 0,
		blight = false, docks = true, inn = true, dungeon = false, shop = false, bank = false, guild = false, heal = false,
		desc = 'The only port in Moss. Due to the terrain and the Blight, this is the only location safe for one.',
		set = ABYSS_SET_MOSS,
		story = { 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	},
	[12] = { x = 378, y = 844, name = 'Big Lake', direction = 1, offset = 0,
		blight = false, docks = false, inn = false, dungeon = true, shop = false, bank = false, guild = true, heal = true,
		desc = 'A massive lake in the centre of Moss. The locals call it the \'Freshwater Ocean\', but it has no real name.',
		set = ABYSS_SET_MOSS,
		story = { 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	},
	[13] = { x = 615, y = 789, name = 'Blighted Forest', direction = 1, offset = 0,
		blight = true, docks = false, inn = false, dungeon = true, shop = false, bank = false, guild = false, heal = false,
		desc = 'A once lively forest now taken over by the Blight. Simply looking at it makes you feel weak.',
		set = ABYSS_SET_MOSS,
		story = { 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	},
	[14] = { x = 529, y = 726, name = 'Blighted Coast', direction = 1, offset = 0,
		blight = true, docks = true, inn = false, dungeon = true, shop = false, bank = false, guild = false, heal = false,
		desc = 'The Blighted remains of a fishing village. Just standing in it fills you with despair.',
		set = ABYSS_SET_MOSS,
		story = { 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	},
	[15] = { x = 421, y = 960, name = 'Frostpeak', direction = 1, offset = 0,
		blight = false, docks = false, inn = false, dungeon = true, shop = false, bank = false, guild = false, heal = false,
		desc = 'The tallest mountains in the known world, few have seen the peak.',
		set = ABYSS_SET_MOSS,
		story = { 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	},
	[16] = { x = 1259, y = 225, name = 'Blighted Bay', direction = 1, offset = false,  --does not display for some reason
		blight = true, docks = true, inn = false, dungeon = true, shop = false, bank = false, guild = false, heal = false,
		desc = 'If not for the Blight, this would be an amazing fishing spot. The air here makes you feel sick.',
		set = ABYSS_SET_GRETCHIN,
		story = { 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	},
	[16] = { x = 236, y = 220, name = 'Mityl', direction = 1, offset = 0,
		blight = false, docks = true, inn = false, dungeon = true, shop = true, bank = false, guild = false, heal = true,
		desc = 'A quiet fishing village on Fal\'set, though the people barely fish...',
		set = ABYSS_SET_FALSET,
		story = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	},
	[17] = { x = -5000, y = -5000, name = 'Here be dragons!\n\n    F\n*=|=~', direction = 1, offset = 0,
		blight = false, docks = false, inn = false, dungeon = false, shop = false, bank = false, guild = false, heal = false,
		desc = 'No location selected, use the front touch screen to select a location',
		set = ABYSS_SET_DEBUG,
		story = { 10000, 10000, 10000, 10000, 10000, 10000, 10000, 10000, 10000, 10000, 10000},
	},
}

st = ABYSS_MENU_MAIN

while not Render.checkClose() do
	loadscreen()

	if (st == ABYSS_MENU_MAIN) then
		Winter.cleanup()
		Winter.clearButtons()
		renderQueue = {
			{identifier = ABYSS_RENDER_MAP,
				type = WINTER_IMAGE,
				surface = nil,
				layer = 1,
				text = rompath .. "/backgrounds/world0.png",
				x = 0,
				y = 0,
				scale = 1.0,
				rotation = 0.0
			},
			{identifier = ABYSS_RENDER_CLOUDS,
				type = WINTER_IMAGE,
				surface = nil,
				layer = 1,
				text = rompath .. "/backgrounds/cloud" .. math.random(3) .. ".png",
				x = 0,
				y = 0,
				scale = 1.0,
				rotation = 0.0
			},
			{identifier = ABYSS_RENDER_BORDER,
				type = WINTER_IMAGE,
				surface = nil,
				layer = 1,
				text = rompath .. "/backgrounds/borderfog.png",
				x = 0,
				y = 0,
				scale = 1.0,
				rotation = 0.0
			},
			{identifier = ABYSS_RENDER_SHADE,
				type = WINTER_IMAGE,
				surface = nil,
				layer = 3,
				text = rompath .. "/ui/menushade.png",
				x = 0,
				y = 0,
				scale = 1.0,
				rotation = 0.0
			},
			{identifier = ABYSS_RENDER_NEWGAME,
				layer = 4,
				surface = nil,
				text = '',
				text2 = 'New Game',
				x = 7,
				y = 0,
				colour = white,
				type = WINTER_TEXT_SLIDE_RIGHT,
				font = meiyro43,
				scale = 1.0,
				rotation = 0
			},
			{identifier = ABYSS_RENDER_LOADGAME,
				layer = 4,
				surface = nil,
				text = '',
				text2 = 'Load Game',
				x = 3,
				y = 66,
				colour = white,
				type = WINTER_TEXT_SLIDE_RIGHT,
				font = meiyro43,
				scale = 1.0,
				rotation = 0
			},
			{identifier = ABYSS_RENDER_TICKER,
				layer = 4,
				surface = nil,
				text = '',
				text2 = menutext,
				x = 0,
				y = 523,
				colour = white,
				type = WINTER_TEXT_SLIDE_RIGHT,
				font = meiyro15,
				scale = 1.0,
				rotation = 0
			},
		}
		if (demo) then
			renderQueue[#renderQueue + 1] = {identifier = ABYSS_RENDER_DEMO,
				type = WINTER_IMAGE,
				surface = nil,
				layer = 1,
				text = rompath .. "/backgrounds/demofog.png",
				x = 0,
				y = 0,
				scale = 1.0,
				rotation = 0.0
			}
		end

		tmp1 = 0.27
		tmp2 = 0.4
		mapx = 0
		mapy = 0

		Winter.pushButton(0, 243, 0, 64, 1)
		Winter.pushButton(0, 243, 65, 130, 2)
		Winter.pushButton(0, 243, 132, 197, 3)

		loop = true
		while (loop) and not Render.checkClose() do
			wtime = Winter.getClock()
			if (debugger == true) then
				debuglog = 'LOG: ' .. WINTER_PROCESSOR_NAME .. ':' .. WINTER_OS_PLATFORM .. ':' .. WINTER_OS_VERSION .. '\n'
				debugentries = 0
			end

			onput = {mouse = {x = -1, y = -1, position = {false, false, false},},}
			onput.mouse.x = WINTER_MOUSE_X
			onput.mouse.y = WINTER_MOUSE_Y
			onput.mouse.position = {WINTER_MOUSE_1, WINTER_MOUSE_2, WINTER_MOUSE_3}
			Render.updateInput()
			input.mouse.x = WINTER_MOUSE_X
			input.mouse.y = WINTER_MOUSE_Y
			input.mouse.position = {WINTER_MOUSE_1, WINTER_MOUSE_2, WINTER_MOUSE_3}

			pressed = 0
			if (input.mouse.position[WINTER_MOUSE_LEFT] == true) and not (onput.mouse.position[WINTER_MOUSE_LEFT] == true) then
				pressed = Winter.checkButton(input.mouse.x, input.mouse.y)
			end
			if (pressed == 1) then
				loop = false
				if not (demo) then
					story = 0 --story progress
					health = 100 --party health, 75% party1 dead, 50% party2 dead, 25% party3 dead, 0% game over
					mana = 500
					location = 10 --current town or dungeon
					character = 4 --current story
					party0 = 4 --row0
					party1 = 1 --row1
					party2 = 1 --row1
					party3 = 1 --row1
					party4 = 1 --row2
					money = 3500 --money, chance to lose some when taking damage
					bank = 30000 --amount in bank
					st = ABYSS_TOWN
				else
					story = 0
					health = 100
					mana = 500
					location = 5
					character = 1
					party0 = 4
					party1 = 3
					party2 = 1
					party3 = 1
					party4 = 1
					money = 6000
					bank = 100000
					if (prerelease == 1) then
						location = -1
					end
					st = ABYSS_TOWN
				end
			elseif (pressed == 2) then
				file = io.open(savepath .. '/save' .. slot * 2 .. '.plush', 'r')
				if (file) then
					file:close()
					dofile(savepath .. '/save' .. slot * 2 .. '.plush')
					loop = false
				end
			end

			renderQueue[1].x = mapx; renderQueue[1].y = mapy
			renderQueue[2].x = mapx + ((mapx * 4) / 2); renderQueue[2].y = mapy + ((mapy * 4) / 2)
			renderQueue[3].x = mapx; renderQueue[3].y = mapy
			if (demo) then
				renderQueue[#renderQueue].x = mapx; renderQueue[#renderQueue].y = mapy
			end
			if (mapx + tmp1 <= borders.x[1]) or (mapx + tmp1 >= borders.x[2]) then
				tmp1 = tmp1 * -1
			end
			if (mapy + tmp2 <= borders.y[1]) or (mapy + tmp2 >= borders.y[2]) then
				tmp2 = tmp2 * -1
			end
			mapx = mapx + tmp1
			mapy = mapy + tmp2

			Winter.renderStack()
			--Plush.dither(WINTER_FRAMEBUFFER, 12.5, false)
			Render.renderImage(WINTER_FRAMEBUFFER, 0, 0, 1.0, 0.0)
			Render.killTexture(WINTER_FRAMEBUFFER)
			Render.forceUpdate()
			Render.exchangeBuffer()
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
				debuglog = debuglog .. debugentries .. ': Frame #' .. frames .. '\n   render time: ' .. wtime .. 'ms\n   drawtime: ' .. Winter.round(WINTER_FRAMERATE - wtime + 0.5) .. 'ms\n'
				print(debuglog)
			end
		end
		Winter.cleanup()


	elseif (st == ABYSS_TOWN) then
		Winter.cleanup()
		Winter.clearButtons()
		renderQueue = {
			{identifier = ABYSS_RENDER_TOWN,
				type = WINTER_IMAGE,
				surface = nil,
				layer = 1,
				text = rompath .. "/backgrounds/" .. location .. "town.png",
				text2 = rompath .. "/backgrounds/0town.png",
				x = 0,
				y = 0,
				scale = 1.0,
				rotation = 0.0
			},
			{identifier = ABYSS_RENDER_SIDEBAR,
				type = WINTER_IMAGE,
				surface = nil,
				layer = 1,
				text = rompath .. "/ui/sidebar.png",
				x = 0,
				y = 0,
				scale = 1.0,
				rotation = 0.0
			},
			{identifier = ABYSS_RENDER_TRAVEL,
				layer = 2,
				surface = nil,
				text = '',
				text2 = 'Travel',
				x = 0,
				y = 68,
				colour = white,
				type = WINTER_TEXT_SLIDE_RIGHT,
				font = meiyro43,
				scale = 1.0,
				rotation = 0
			}
		}
		if (overlay[location].inn) then
			renderQueue[#renderQueue + 1] = {identifier = ABYSS_RENDER_TEXT, layer = 2, surface = nil, text = '', text2 = 'Inn', x = 0, y = 0, colour = white, type = WINTER_TEXT_SLIDE_RIGHT, font = meiyro43, scale = 1.0, rotation = 0}
		else
			renderQueue[#renderQueue + 1] = {identifier = ABYSS_RENDER_TEXT, layer = 2, surface = nil, text = '', text2 = 'Inn', x = 0, y = 0, colour = dgrey, type = WINTER_TEXT_SLIDE_RIGHT, font = meiyro43, scale = 1.0, rotation = 0}
		end
		if (overlay[location].docks) then
			renderQueue[#renderQueue + 1] = {identifier = ABYSS_RENDER_TEXT, layer = 2, surface = nil, text = '', text2 = 'Port', x = 0, y = 136, colour = white, type = WINTER_TEXT_SLIDE_RIGHT, font = meiyro43, scale = 1.0, rotation = 0}
		else
			renderQueue[#renderQueue + 1] = {identifier = ABYSS_RENDER_TEXT, layer = 2, surface = nil, text = '', text2 = 'Port', x = 0, y = 136, colour = dgrey, type = WINTER_TEXT_SLIDE_RIGHT, font = meiyro43, scale = 1.0, rotation = 0}
		end
		if (overlay[location].dungeon) then
			renderQueue[#renderQueue + 1] = {identifier = ABYSS_RENDER_TEXT, layer = 2, surface = nil, text = '', text2 = 'Dungeon', x = 0, y = 204, colour = white, type = WINTER_TEXT_SLIDE_RIGHT, font = meiyro43, scale = 1.0, rotation = 0}
		else
			renderQueue[#renderQueue + 1] = {identifier = ABYSS_RENDER_TEXT, layer = 2, surface = nil, text = '', text2 = 'Dungeon', x = 0, y = 204, colour = dgrey, type = WINTER_TEXT_SLIDE_RIGHT, font = meiyro43, scale = 1.0, rotation = 0}
		end
		if (overlay[location].shop) then
			renderQueue[#renderQueue + 1] = {identifier = ABYSS_RENDER_TEXT, layer = 2, surface = nil, text = '', text2 = 'Shop', x = 0, y = 272, colour = white, type = WINTER_TEXT_SLIDE_RIGHT, font = meiyro43, scale = 1.0, rotation = 0}
		else
			renderQueue[#renderQueue + 1] = {identifier = ABYSS_RENDER_TEXT, layer = 2, surface = nil, text = '', text2 = 'Shop', x = 0, y = 272, colour = dgrey, type = WINTER_TEXT_SLIDE_RIGHT, font = meiyro43, scale = 1.0, rotation = 0}
		end
		if (overlay[location].bank) then
			renderQueue[#renderQueue + 1] = {identifier = ABYSS_RENDER_TEXT, layer = 2, surface = nil, text = '', text2 = 'Bank', x = 0, y = 340, colour = white, type = WINTER_TEXT_SLIDE_RIGHT, font = meiyro43, scale = 1.0, rotation = 0}
		else
			renderQueue[#renderQueue + 1] = {identifier = ABYSS_RENDER_TEXT, layer = 2, surface = nil, text = '', text2 = 'Bank', x = 0, y = 340, colour = dgrey, type = WINTER_TEXT_SLIDE_RIGHT, font = meiyro43, scale = 1.0, rotation = 0}
		end
		if (overlay[location].guild) then
			renderQueue[#renderQueue + 1] = {identifier = ABYSS_RENDER_TEXT, layer = 2, surface = nil, text = '', text2 = 'Guild', x = 0, y = 408, colour = white, type = WINTER_TEXT_SLIDE_RIGHT, font = meiyro43, scale = 1.0, rotation = 0}
		else
			renderQueue[#renderQueue + 1] = {identifier = ABYSS_RENDER_TEXT, layer = 2, surface = nil, text = '', text2 = 'Guild', x = 0, y = 408, colour = dgrey, type = WINTER_TEXT_SLIDE_RIGHT, font = meiyro43, scale = 1.0, rotation = 0}
		end
		if (overlay[location].heal) then
			renderQueue[#renderQueue + 1] = {identifier = ABYSS_RENDER_TEXT, layer = 2, surface = nil, text = '', text2 = 'Heal', x = 0, y = 476, colour = white, type = WINTER_TEXT_SLIDE_RIGHT, font = meiyro43, scale = 1.0, rotation = 0}
		else
			renderQueue[#renderQueue + 1] = {identifier = ABYSS_RENDER_TEXT, layer = 2, surface = nil, text = '', text2 = 'Heal', x = 0, y = 476, colour = dgrey, type = WINTER_TEXT_SLIDE_RIGHT, font = meiyro43, scale = 1.0, rotation = 0}
		end
		renderQueue[#renderQueue + 1] = {identifier = ABYSS_RENDER_TEXT, layer = 2, surface = nil, text = '', text2 = 'This screen is incomplete\nPress O to enter dungeon\nPress X to exit to map', x = 400, y = 400, colour = red, type = WINTER_TEXT_SLIDE_RIGHT, font = meiyro15, scale = 1.0, rotation = 0}

		loop = true
		while (loop) and not Render.checkClose() do
			wtime = Winter.getClock()
			if (debugger == true) then
				debuglog = 'LOG: ' .. WINTER_PROCESSOR_NAME .. ':' .. WINTER_OS_PLATFORM .. ':' .. WINTER_OS_VERSION .. '\n'
				debugentries = 0
			end
			onput = {mouse = {x = -1, y = -1, position = {false, false, false},},}
			onput.mouse.x = WINTER_MOUSE_X
			onput.mouse.y = WINTER_MOUSE_Y
			onput.mouse.position = {WINTER_MOUSE_1, WINTER_MOUSE_2, WINTER_MOUSE_3}
			onput.key = {}
			onput.key.o = WINTER_KEY_O
			onput.key.x = WINTER_KEY_X
			Render.updateInput()
			input.mouse.x = WINTER_MOUSE_X
			input.mouse.y = WINTER_MOUSE_Y
			input.mouse.position = {WINTER_MOUSE_1, WINTER_MOUSE_2, WINTER_MOUSE_3}
			input.key.o = WINTER_KEY_O
			input.key.x = WINTER_KEY_X

			--[[Graphics.drawLine(0, 225, 68, 68, white)
			Graphics.drawLine(0, 238, 136, 136, white)
			Graphics.drawLine(0, 252, 204, 204, white)
			Graphics.drawLine(0, 252, 272, 272, white)
			Graphics.drawLine(0, 249, 340, 340, white)
			Graphics.drawLine(0, 244, 408, 408, white)
			Graphics.drawLine(0, 230, 476, 476, white)]]


			if (input.key.o) then
				townloop = 0
				st = ABYSS_DUNGEON
				loop = false
			end
			if (input.key.x) then
				townloop = 0
				st = ABYSS_MAP
				loop = false
			end

			Winter.renderStack()
			Plush.dither(WINTER_FRAMEBUFFER, 12.5, false)
			Render.renderImage(WINTER_FRAMEBUFFER, 0, 0, 1.0, 0.0)
			Render.killTexture(WINTER_FRAMEBUFFER)
			Render.forceUpdate()
			Render.exchangeBuffer()
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
				debuglog = debuglog .. debugentries .. ': Frame #' .. frames .. '\n   render time: ' .. wtime .. 'ms\n   drawtime: ' .. Winter.round(WINTER_FRAMERATE - wtime + 0.5) .. 'ms\n'
				print(debuglog)
			end
		end
		Winter.cleanup()


	elseif (st == ABYSS_MAP) then
		Winter.cleanup()
		Winter.clearButtons()
		renderQueue = {
			{identifier = ABYSS_RENDER_MAP,
				type = WINTER_IMAGE,
				surface = nil,
				layer = 1,
				text = rompath .. "/backgrounds/world0.png",
				x = 0,
				y = 0,
				scale = 1.0,
				rotation = 0.0
			},
			{identifier = ABYSS_RENDER_CLOUDS,
				type = WINTER_IMAGE,
				surface = nil,
				layer = 1,
				text = rompath .. "/backgrounds/cloud" .. math.random(3) .. ".png",
				x = 0,
				y = 0,
				scale = 1.0,
				rotation = 0.0
			},
			{identifier = ABYSS_RENDER_BORDER,
				type = WINTER_IMAGE,
				surface = nil,
				layer = 1,
				text = rompath .. "/backgrounds/borderfog.png",
				x = 0,
				y = 0,
				scale = 1.0,
				rotation = 0.0
			},
		}
		if (demo) then
			renderQueue[#renderQueue + 1] = {ABYSS_RENDER_DEMO,
				type = WINTER_IMAGE,
				surface = nil,
				layer = 1,
				text = rompath .. "/backgrounds/demofog.png",
				x = 0,
				y = 0,
				scale = 1.0,
				rotation = 0.0
			}
		end

		mapx = 0; mapy = 0
		seadist = 0
		disp = 17
		oldx = nil; oldy = nil; moved = false
		travel = Render.loadPNG(rompath .. "/ui/travel.png")
		mappoint = Render.loadPNG(blankpc)
		shade = Render.loadPNG(rompath .. "/ui/mapshade.png")
		
		Winter.pushButton(0, 244, 0, 65, 1)

		loop = true
		while (loop) and not Render.checkClose() do
			wtime = Winter.getClock()
			if (debugger == true) then
				debuglog = 'LOG: ' .. WINTER_PROCESSOR_NAME .. ':' .. WINTER_OS_PLATFORM .. ':' .. WINTER_OS_VERSION .. '\n'
				debugentries = 0
			end
			onput = {mouse = {x = -1, y = -1, position = {false, false, false},},}
			onput.mouse.x = WINTER_MOUSE_X
			onput.mouse.y = WINTER_MOUSE_Y
			onput.mouse.position = {WINTER_MOUSE_1, WINTER_MOUSE_2, WINTER_MOUSE_3}
			onput.key = {}
			onput.key.back = WINTER_KEY_BACK
			Render.updateInput()
			input.mouse.x = WINTER_MOUSE_X
			input.mouse.y = WINTER_MOUSE_Y
			input.mouse.position = {WINTER_MOUSE_1, WINTER_MOUSE_2, WINTER_MOUSE_3}
			input.key.back = WINTER_KEY_BACK

			pressed = 0
			if (moved == false) and (onput.mouse.position[WINTER_MOUSE_LEFT]) and not (input.mouse.position[WINTER_MOUSE_LEFT]) then
				pressed = Winter.checkButton(input.mouse.x, input.mouse.y)
				touched = 1
			else
				touched = 0
				touch = 10000
			end
			if (input.mouse.position[WINTER_MOUSE_LEFT]) then
				if (oldx == nil) then
					oldx = input.mouse.x
					oldy = input.mouse.y
				end
				if (oldx ~= input.mouse.x) then
					mapx = mapx - (oldx - input.mouse.x)
					moved = true
				end
				if (oldy ~= input.mouse.y) then
					mapy = mapy - (oldy - input.mouse.y)
					moved = true
				end
				oldx = input.mouse.x
				oldy = input.mouse.y
			else
				oldx = nil
				oldy = nil
				moved = false
			end

			if (mapx >= 1) then
				mapx = 0
			end
			if (mapx <= -961) then
				mapx = -960
			end
			if (mapy >= 1) then
				mapy = 0
			end
			if (mapy <= -545) then
				mapy = -544
			end

			renderQueue[1].x = mapx; renderQueue[1].y = mapy
			renderQueue[2].x = mapx + ((mapx * 4) / 2); renderQueue[2].y = mapy + ((mapy * 4) / 2)
			renderQueue[3].x = mapx; renderQueue[3].y = mapy
			if (demo) then
				demoslot = Winter.findID(renderQueue, ABYSS_RENDER_DEMO)
				renderQueue[demoslot].x = mapx; renderQueue[demoslot].y = mapy
			end
			Winter.renderStack()

			for i = 1, #overlay do
				if not (overlay[i].story[character] >= story + 1) or (mapdebug == 1) then
					if (overlay[i].x + mapx >= (borders.x[2] + 100) * -1) and (overlay[i].x + mapx <= (borders.x[1] - 100) * -1) and (overlay[i].y + mapy >= (borders.y[2] + 100) * -1) and (overlay[i].y + mapy <= (borders.y[1] - 100) * -1) then
						if (tmp == disp) then
							loccolour = green
						elseif (overlay[location].set == overlay[i].set) or (overlay[location].set == ABYSS_SET_SEA) and (seadist <= stamina) and (overlay[i].docks) then
							loccolour = white
						else
							loccolour = red
						end
						Render.modifyImage(mappoint, WINTER_AETHER_FILL, loccolour[1], loccolour[2], loccolour[3], loccolour[4])
						Render.blitImage(WINTER_FRAMEBUFFER, mappoint, overlay[i].x + mapx, overlay[i].y + mapy, false, 4.0, 0.0)
						dx = -10000; dy = -10000
						if (overlay[i].direction == 1) then
							dx = overlay[i].x + mapx + 4
							dy = overlay[i].y + mapy - 16
						elseif (overlay[i].direction == 2) then
							dx = overlay[i].x + mapx + 4
							dy = overlay[i].y + mapy
						elseif (overlay[i].direction == 3) then
							dx = overlay[i].x + mapx - 4 - overlay[i].offset
							dy = overlay[i].y + mapy
						elseif (overlay[i].direction == 4) then
							dx = overlay[i].x + mapx - 4 - overlay[i].offset
							dy = overlay[i].y + mapy - 16
						end
						textsurface = Font.renderText(overlay[i].name, meiyro15[1], loccolour[1], loccolour[2], loccolour[3], loccolour[4])
						Render.modifyImage(textsurface, WINTER_COLOUR_FILL, loccolour[1], loccolour[2], loccolour[3], loccolour)
						Render.blitImage(WINTER_FRAMEBUFFER, textsurface, dx, dy, true, 1.0, 0.0)
						Render.killImage(textsurface)
					end
					if (touched == 1) then
						pos = math.sqrt((input.mouse.x - (overlay[i].x + mapx))^2) + math.sqrt((input.mouse.y - (overlay[i].y + mapy))^2)
						seadist = tonumber(string.format("%.0f", math.sqrt((overlay[portid].x + overlay[i].x)^2) + math.sqrt((overlay[portid].y + overlay[i].y)^2)))
						if (pos < touch) then
							touch = pos
							disp = i
						end
					end
				end
			end

			Render.blitImage(WINTER_FRAMEBUFFER, shade, 0, 0, true, 1.0, 0.0)
			textsurface = Font.renderText(overlay[disp].desc, meiyro15[1], green[1], green[2], green[3], green[4])
			Render.modifyImage(textsurface, WINTER_COLOUR_FILL, green[1], green[2], green[3], green)
			Render.blitImage(WINTER_FRAMEBUFFER, textsurface, 0, 522, true, 1.0, 0.0)
			Render.killImage(textsurface)
			if (disp ~= 17) then
				if (overlay[location].set == overlay[disp].set) or (overlay[location].set == ABYSS_SET_SEA) and (overlay[disp].docks) then
					Render.blitImage(WINTER_FRAMEBUFFER, travel, 0, 0, false, 1.0, 0.0)
					if (touched == 1) and (pressed == 1) then
						if (overlay[location].set == ABYSS_SET_SEA) then
							stamina = stamina - seadist
						end
						location = disp
						loop = false
						st = ABYSS_TOWN
					end
				end
			end

			if (input.key.back) then
				loop = false
				set = ABYSS_TOWN
			end

			--Plush.dither(WINTER_FRAMEBUFFER, 12.5, false)
			Render.renderImage(WINTER_FRAMEBUFFER, 0, 0, 1.0, 0.0)
			Render.killTexture(WINTER_FRAMEBUFFER)
			Render.forceUpdate()
			Render.exchangeBuffer()
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
				debuglog = debuglog .. debugentries .. ': Frame #' .. frames .. '\n   render time: ' .. wtime .. 'ms\n   drawtime: ' .. Winter.round(WINTER_FRAMERATE - wtime + 0.5) .. 'ms\n'
				print(debuglog)
			end
		end
		Winter.cleanup()
		Render.killImage(mappoint)
		Render.killImage(travel)
		Render.killImage(shade)


	elseif (st == ABYSS_DUNGEON) then
		Winter.cleanup()
		Winter.clearButtons()
		--file = io.open(rompath .. '/scripts/abyssdungeons/' .. location .. 'map0.lua')
		--if (file) then
		--	file:close()
		--	dofile(rompath .. '/scripts/abyssdungeons/' .. location .. 'map0.lua')
		--else
			dofile(rompath .. '/scripts/abyssdungeons/0map0.lua')
		--end

		mdanger = Render.loadPNG(rompath .. "/ui/peaceful.png")
		mwarn = Render.loadPNG(rompath .. "/ui/safe.png")
		msafe = Render.loadPNG(rompath .. "/ui/warn.png")
		mpeaceful = Render.loadPNG(rompath .. "/ui/danger.png")
		munknown = Render.loadPNG(rompath .. "/ui/unknown.png")

		renderQueue = {
			{identifier = ABYSS_RENDER_PLAYER_BAR,
				type = WINTER_IMAGE,
				surface = nil,
				layer = 1,
				text = rompath .. "/ui/pbar.png",
				x = 900,
				y = 0,
				scale = 1.0,
				rotation = 0.0
			},
			{identifier = ABYSS_RENDER_LENSE,
				type = WINTER_IMAGE,
				surface = nil,
				layer = 1,
				text = rompath .. "/ui/circle.png",
				x = 60,
				y = 404,
				scale = 1.0,
				rotation = 0.0
			},
			{identifier = ABYSS_RENDER_LOCATOR,
				type = WINTER_IMAGE,
				surface = munknown,
				layer = 1,
				x = 178,
				y = 408,
				scale = 1.0,
				rotation = 0.0
			},
			{identifier = ABYSS_RENDER_LENSE,
				type = WINTER_IMAGE,
				surface = nil,
				layer = 1,
				text = rompath .. "/ui/lense.png",
				x = 60,
				y = 404,
				scale = 1.0,
				rotation = 0.0
			},
			{identifier = ABYSS_RENDER_STATUSBAR,
				type = WINTER_IMAGE,
				surface = nil,
				layer = 1,
				text = rompath .. "/ui/statusempty.png",
				x = 901,
				y = 104,
				scale = 1.0,
				rotation = 0.0
			},
			{identifier = ABYSS_RENDER_STATUSBAR,
				type = WINTER_IMAGE,
				surface = nil,
				layer = 1,
				text = rompath .. "/ui/statusfull.png",
				x = 951,
				y = 104,
				scale = 1.0,
				rotation = 0.0
			},
		}

		playerx = -1; playery = -1
		alatch = false
		mlatch = false
		direction = Plush.getPlayerRotation() / 0.0174533
		angle = Plush.getTilt() / 0.0174533
		accuracy = 100
		enemy = 5
		itorch = 0
		targetx, targety = Plush.getPlayerPosition()
		targeta = direction
		movingforward = true
		movingdist = 0
		movingdirection = 0

		loop = true
		while (loop) and not Render.checkClose() do
			wtime = Winter.getClock()
			if (debugger == true) then
				debuglog = 'LOG: ' .. WINTER_PROCESSOR_NAME .. ':' .. WINTER_OS_PLATFORM .. ':' .. WINTER_OS_VERSION .. '\n'
				debugentries = 0
			end
			onput = {mouse = {x = -1, y = -1, position = {false, false, false},},}
			onput.mouse.x = WINTER_MOUSE_X
			onput.mouse.y = WINTER_MOUSE_Y
			onput.mouse.position = {WINTER_MOUSE_1, WINTER_MOUSE_2, WINTER_MOUSE_3}
			onput.key = {}
			onput.key.w = WINTER_KEY_W
			onput.key.a = WINTER_KEY_A
			onput.key.s = WINTER_KEY_S
			onput.key.d = WINTER_KEY_D
			onput.key.q = WINTER_KEY_Q
			onput.key.e = WINTER_KEY_E
			onput.key.r = WINTER_KEY_R
			onput.key.f = WINTER_KEY_F
			Render.updateInput()
			input.mouse.x = WINTER_MOUSE_X
			input.mouse.y = WINTER_MOUSE_Y
			input.mouse.position = {WINTER_MOUSE_1, WINTER_MOUSE_2, WINTER_MOUSE_3}
			input.key.w = WINTER_KEY_W
			input.key.a = WINTER_KEY_A
			input.key.s = WINTER_KEY_S
			input.key.d = WINTER_KEY_D
			input.key.q = WINTER_KEY_Q
			input.key.e = WINTER_KEY_E
			input.key.r = WINTER_KEY_R
			input.key.f = WINTER_KEY_F

			oldx = playerx
			oldy = playery
			playerx, playery = Plush.getPlayerPosition()
			print('\nplayerx: ' .. playerx .. '\ntargetx: ' .. targetx .. '\nplayery: ' .. playery .. '\ntargety: ' .. targety .. '\ndirection: ' .. direction .. '\ntargeta: ' .. targeta .. '\nmovingdist: ' .. movingdist .. '\nmovingdirection: ' .. movingdirection)
			if (mlatch == true) then
				if not (targetx == playerx) or not (targety == playery) or not (targeta == direction) then
					accuracy = accuracy + 1
					alatch = false
					Plush.movePlayer(movingdist, movingforward)
					direction = direction + movingdirection
				else
					mlatch = flase
				end
			else
				accuracy = accuracy - 1
				if (input.key.w) then
					targetx, targety = Plush.dontMovePlayer(16, true)
					if not (Plush.checkWall(targetx, targety, wallsVector)) then
						mlatch = true
						movingforward = true
						movingdirection = 0
						targeta = direction
						movingdist = 1
					end
				elseif (input.key.s) then
					targetx, targety = Plush.dontMovePlayer(-16, true)
					if not (Plush.checkWall(targetx, targety, wallsVector)) then
						mlatch = true
						movingforward = true
						movingdirection = 0
						targeta = direction
						movingdist = -1
					end
				elseif (input.key.q) then
					targetx, targety = Plush.dontMovePlayer(-16, flase)
					if not (Plush.checkWall(targetx, targety, wallsVector)) then
						mlatch = true
						movingforward = false
						movingdirection = 0
						movingdist = -1
					end
				elseif (input.key.e) then
					targetx, targety = Plush.dontMovePlayer(16, flase)
					if not (Plush.checkWall(targetx, targety, wallsVector)) then
						mlatch = true
						movingforward = false
						movingdirection = 0
						movingdist = 1
					end
				elseif (input.key.a) then
					targetx, targety = playerx, playery
					movingdirection = -5
					targeta = direction - 90
					movingdist = 0
					mlatch = true
				elseif (input.key.d) then
					targetx, targety = playerx, playery
					movingdirection = 5
					targeta = direction + 90
					movingdist = 0
					mlatch = true
				end
				targetx = Winter.round((targetx + 8) / 16, 0) * 16 - 8
				targety = Winter.round((targety + 8) / 16, 0) * 16 - 8
				targeta = Plush.round90(targeta)
			end
			if (input.key.r) then
				angle = angle - 5
				accuracy = accuracy + 1; alatch = false; mlatch = true
			end
			if (input.key.f) then
				angle = angle + 5
				accuracy = accuracy + 1; alatch = false; mlatch = true
			end

			if (direction > 360) then
				direction = direction - 360
			elseif (direction < 0) then
				direction = direction + 360
			end
			if (targeta > 360) then
				targeta = targeta - 360
			elseif (targeta < 0) then
				targeta = targeta + 360
			end
			if (angle > 25) then
				angle = 25
			elseif (angle < -25) then
				angle = -25
			end
			if (debugger == true) then
				debugentries = debugentries + 1
				debuglog = debuglog .. debugentries .. ': direction: ' .. direction .. ' angle: ' .. angle .. ' accuracy: ' .. accuracy .. ' x: ' .. playerx .. ' y: ' .. playery .. '\n'
			end

			Plush.setPlayerRotation(direction * 0.0174533)
			Plush.setTilt(angle * 0.0174533)
			if (accuracy < 2) then
				accuracy = 2
			end
			if (accuracy > 4) then
				accuracy = 4
			end
			if not (Plush.getAccuracy() == Winter.round(accuracy, 0)) then
				alatch = false
			end
			Plush.setAccuracy(Winter.round(accuracy, 0))

			tileX = Winter.round((playerx + 8) / 16, 0)
			tileY = Winter.round((playery + 8) / 16, 0)
			if (eastVector[tileX][tileY] == doorclosed) then
				eastVector[tileX][tileY] = doorbuffer
				Plush.setMap(wallsVector, roofVector, floorVector, roofOffsetVector, floorOffsetVector, imageVector, eastVector, northVector)
			end
			if (northVector[tileX][tileY] == doorclosed) then
				northVector[tileX][tileY] = doorbuffer
				Plush.setMap(wallsVector, roofVector, floorVector, roofOffsetVector, floorOffsetVector, imageVector, eastVector, northVector)
			end
			for i = 1, #eastVector do
				for j = 1, #eastVector[i] do
					if (i ~= tileX) and (j ~= tileY) then
						if (eastVector[i][j] == doorbuffer) then
							eastVector[i][j] = doorclosed
							Plush.setMap(wallsVector, roofVector, floorVector, roofOffsetVector, floorOffsetVector, imageVector, eastVector, northVector)
						end
						if (northVector[i][j] == doorbuffer) then
							northVector[i][j] = doorclosed
							Plush.setMap(wallsVector, roofVector, floorVector, roofOffsetVector, floorOffsetVector, imageVector, eastVector, northVector)
						end
					end
				end
			end

			if (enemy == 0) then
				renderQueue[3].surface = mdanger
			elseif (enemy == 1) then
				renderQueue[3].surface = mwarn
			elseif (enemy == 2) then
				renderQueue[3].surface = msafe
			elseif (enemy > 2) then
				renderQueue[3].surface = mpeaceful
			end
			if (ehide == 1) then
				renderQueue[3].surface = munknown
			end
			renderQueue[6].x = 901 + itorch

			if (alatch == false) then
				Plush.raycast(WINTER_FRAMEBUFFER, threads)
				alatch = true
				--Plush.dither(WINTER_FRAMEBUFFER, 12.5, false)
				Plush.bilinearSolid(WINTER_FRAMEBUFFER)
			end
			Winter.renderStack()
			Render.renderImage(WINTER_FRAMEBUFFER, 0, 0, 1.0, 0.0)
			Render.killTexture(WINTER_FRAMEBUFFER)
			Render.forceUpdate()
			Render.exchangeBuffer()
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
				debuglog = debuglog .. debugentries .. ': Frame #' .. frames .. '\n   render time: ' .. wtime .. 'ms\n   drawtime: ' .. Winter.round(WINTER_FRAMERATE - wtime + 0.5) .. 'ms\n'
				print(debuglog)
			end
		end
		Render.killImage(mdanger)
		Render.killImage(mwarn)
		Render.killImage(msafe)
		Render.killImage(mpeaceful)
		Render.killImage(munknown)
		Winter.cleanup()

--[[Font.setPixelSizes(meiyro, 25)
moving = 0
tdist = 4
adist = 5.625
frames = 32 --animation length
mframes = 8 --movement length
tframes = 8 --movement distance
unload = 0
updateddisp = 0
itorch = 0
zoomdirect = 0.1
dw = startw * 90
dx = startx * 64 + 32
dy = starty * 64 + 32
dz = startz
dx2 = startx
dy2 = starty
wall_height = 64
tile_size = 64
RayCast3D.setResolution(840, 544)
RayCast3D.setViewsize(60)
collison()
RayCast3D.loadMap(dmap, map_width, map_height, tile_size, wall_height)
RayCast3D.spawnPlayer(startx * 64 + 32, starty * 64 + 32, startw * 90)
RayCast3D.setAccuracy(acc, vacc)
oldpad = SCE_CTRL_CROSS
RayCast3D.enableFloor(true)
RayCast3D.setFloorColor(clear)
RayCast3D.enableSky(true)
RayCast3D.setSkyColor(clear)
RayCast3D.setDepth(dfog)
dungeonloop = 1

while (dungeonloop == 1) do
	Graphics.initBlend()
	Screen.clear()
	dungeonrender()
	pad = Controls.read()
	Graphics.termBlend()
	if (moving == 0) then --not moving
		if (dtmap[(dplr.y - 32) / 64][(dplr.x - 32) / 64] == 10) then
			moving = 2
			movmesg = 2
		elseif (dtmap[(dplr.y - 32) / 64][(dplr.x - 32) / 64] < 0) then
			moving = 2
			movmesg = dtmap[(dplr.y - 32) / 64][(dplr.x - 32) / 64]
		elseif (Controls.check(pad, SCE_CTRL_LEFT)) and not (Controls.check(oldpad, SCE_CTRL_LEFT)) then
			moving = 4
			direct = LEFT
		elseif (Controls.check(pad, SCE_CTRL_RIGHT)) and not (Controls.check(oldpad, SCE_CTRL_RIGHT)) then
			moving = 4
			direct = RIGHT
		elseif (Controls.check(pad, SCE_CTRL_UP)) and not (Controls.check(oldpad, SCE_CTRL_UP)) then
			moving = 3
			direct = FORWARD
		elseif (Controls.check(pad, SCE_CTRL_DOWN)) and not (Controls.check(oldpad, SCE_CTRL_DOWN)) then
			moving = 3
			direct = BACK
		elseif (Controls.check(pad, SCE_CTRL_LTRIGGER)) and not (Controls.check(oldpad, SCE_CTRL_LTRIGGER)) then
			moving = 3
			direct = LEFT
		elseif (Controls.check(pad, SCE_CTRL_RTRIGGER)) and not (Controls.check(oldpad, SCE_CTRL_RTRIGGER)) then
			moving = 3
			direct = RIGHT
		elseif (Controls.check(pad, SCE_CTRL_TRIANGLE)) then
			if (dmult > 6) then
				zoomdirect = -0.1
			elseif (dmult < 3) then
				zoomdirect = 0.1
			end
			dmult = dmult + zoomdirect
		elseif (Controls.check(pad, SCE_CTRL_CIRCLE)) and not (Controls.check(oldpad, SCE_CTRL_CIRCLE)) then
			if (spz == 5) then
				moving = 2
				movmesg = 1
			end
			if (spz == 2) then
				Graphics.initBlend()
				Screen.clear()
				dungeonrender()
				RayCast3D.movePlayer(direct, 64)
				tplr = RayCast3D.getPlayer()
				RayCast3D.spawnPlayer(dpx - 1, dpy, round(dw))
				Graphics.termBlend()
				Screen.flip()
				if not (tplr.x == dplr.x + 64) and not (tplr.y == dplr.y + 64) and not (tplr.x == dplr.x - 64) and not (tplr.y == dplr.y - 64) then
					moving = 1
				end
			end
			if (spz == 3) then
				if (dtmap[(dplr.y - 32) / 64][(dplr.x - 32) / 64] == 1) then
					if (itorch == 0) then
						RayCast3D.setDepth(round(dfog / 2))
					end
					itorch = 50 --901 109
				end
			end
		end
	elseif (moving == 1) then --floor change
		tmpy = frames * 2
		tmpz = -544
		for i = 1, frames * 2 do
			Graphics.initBlend()
			Screen.clear()
			dungeonrender()
			Graphics.drawImage(0, tmpz, blackscreen)
			tmpz = tmpz + 17
			tmpy = tmpy - 1
			if (tmpy == frames) then
				loadscreen()
				unload = 1
				dontload = 0
				if (System.doesFileExist(rompath .. '/dungeon/' .. location .. 'map' .. dtmap[spy][spx] .. '.lua')) then
					file = System.openFile(rompath .. '/dungeon/' .. location .. 'map' .. dtmap[spy][spx] .. '.lua', FREAD)
					tmp0 = System.readFile(file, 16)
					if (tmp0 == '--this be a door') then
						unload = 0
						dontload = 1
					end
					System.closeFile(file)
				end
				dofile(rompath .. '/dungeon/' .. lastmap)
				unload = 0
				tmp = 0
				if (System.doesFileExist(rompath .. '/dungeon/' .. location .. 'map' .. dtmap[spy][spx] .. '.lua')) then
					dofile(rompath .. '/dungeon/' .. location .. 'map' .. dtmap[spy][spx] .. '.lua')
				else
					dofile(rompath .. '/dungeon/0map' .. dtmap[spy][spx] .. '.lua')
				end
				RayCast3D.loadMap(dmap, map_width, map_height, tile_size, wall_height)
			end
			Graphics.termBlend()
			Screen.flip()
		end
		if (tmpy == 0) then
			moving = 0
		end
	elseif (moving == 2) then --severe jank ahead
		Graphics.initBlend()
		Screen.clear()
		dungeonrender()
		Graphics.fillRect(240, 720, 136, 408, white)
		Graphics.fillRect(242, 718, 138, 406, black)
		if (movmesg == 1) then --global popup messages
			Font.print(meiyro, 242, 138, '\n    Would you like to return to town?\n\n\n          Press O to return to town.\n               Press X to close this.', white)
			if (Controls.check(pad, SCE_CTRL_CIRCLE)) and not (Controls.check(oldpad, SCE_CTRL_CIRCLE)) then
				dungeonloop = 0
				st = 'town'
			end
			if (Controls.check(pad, SCE_CTRL_CROSS)) and not (Controls.check(oldpad, SCE_CTRL_CROSS)) then
				moving = 0
			end
		elseif (movmesg == 2) then
			Font.print(meiyro, 242, 138, '\n   You feel it is too dangerous to keep\n                      going.\n\n            Press O to turn back.', white)
			if (Controls.check(pad, SCE_CTRL_CIRCLE)) and not (Controls.check(oldpad, SCE_CTRL_CIRCLE)) then
				moving = 3
				if (direct == LEFT) then
					direct = RIGHT
				elseif (direct == RIGHT) then
					direct = LEFT
				elseif (direct == FORWARD) then
					direct = BACK
				elseif (direct == BACK) then
					direct = FORWARD
				else
					direct = BACK
				end
			end
		end
		if (movmesg < 0) then --map defined popup messages
			Font.print(meiyro, 242, 138, dprompt[movmesg * -1][1], white)
			if (dprompt[movmesg * -1][2] == 1) and (Controls.check(pad, SCE_CTRL_CIRCLE)) and not (Controls.check(oldpad, SCE_CTRL_CIRCLE)) then
				moving = 5
				confirm = 1
			end
			if (dprompt[movmesg * -1][3] == 1) and (Controls.check(pad, SCE_CTRL_CROSS)) and not (Controls.check(oldpad, SCE_CTRL_CROSS)) then
				moving = 5
				confirm = 0
			end
		end
		Graphics.termBlend()
	elseif (moving == 3) then --moving
		if (itorch > 0) then
			itorch = itorch - 1
			if (itorch == 0) then
				RayCast3D.setDepth(dfog)
			end
		end
		Graphics.initBlend()
		Screen.clear()
		dungeonrender()
		RayCast3D.movePlayer(direct, tframes * mframes)
		tplr = RayCast3D.getPlayer()
		RayCast3D.spawnPlayer(dpx - 1, dpy, round(dw))
		Graphics.termBlend()
		Screen.flip()
		if (tplr.x == dplr.x + (tframes * mframes)) or (tplr.y == dplr.y + (tframes * mframes)) or (tplr.x == dplr.x - (tframes * mframes)) or (tplr.y == dplr.y - (tframes * mframes)) then
			for i = 1, mframes do
				Graphics.initBlend()
				Screen.clear()
				dungeonrender()
				RayCast3D.movePlayer(direct, tframes)
				Graphics.termBlend()
				Screen.flip()
			end
		end
		moving = 0
		if (enemy == 3) and (math.random(25) == 1) then
			enemy = enemy - 1
		elseif (enemy == 2) and (math.random(20) == 1) then
			enemy = enemy - 1
		elseif (enemy == 1) and (math.random(15) == 1) then
			enemy = enemy - 1
		elseif (enemy == 0) and (math.random(10) == 1) then
			tmpy = frames
			tmpz = -544
			for i = 1, frames do
				Graphics.initBlend()
				Screen.clear()
				dungeonrender()
				Graphics.drawImage(0, tmpz, blackscreen)
				tmpz = tmpz + 17
				tmpy = tmpy - 1
				if (tmpy == frames) then
					Graphics.termBlend()
					Screen.flip()
					dofile(rompath .. '/combat.lua')
					for i = 1, frames do
						Graphics.initBlend()
						Screen.clear()
						dungeonrender()
						Graphics.drawImage(0, tmpz, blackscreen)
						tmpz = tmpz + 17
						tmpy = tmpy - 1
						Graphics.termBlend()
						Screen.flip()
						if (tmpy == frames) then
							Graphics.initBlend()
						end
					end
				end
				Graphics.termBlend()
				Screen.flip()
			end
		end
	elseif (moving == 4) then --camera movement
		for i = 1, mframes do
			Graphics.initBlend()
			Screen.clear()
			dungeonrender()
			RayCast3D.rotateCamera(direct, (1260 / mframes) - 0.5)
			Graphics.termBlend()
			Screen.flip()
		end
		Graphics.initBlend()
		Screen.clear()
		dungeonrender()
		RayCast3D.rotateCamera(direct, 4)
		Graphics.termBlend()
		Screen.flip()
		moving = 0
	elseif (moving == 5) then --mark an event as read
		moving = 0
		dtmap[(dplr.y - 32) / 64][(dplr.x - 32) / 64] = 0
		--add stuff here later
	elseif (moving == 6) then --idk yet
	end
	Screen.flip()
	oldpad = pad
end
Graphics.freeImage(pbar)
Graphics.freeImage(bbar)
Graphics.freeImage(mmap)
Graphics.freeImage(circle)
Graphics.freeImage(mpeaceful)
Graphics.freeImage(msafe)
Graphics.freeImage(mwarn)
Graphics.freeImage(mdanger)
Graphics.freeImage(munknown)
unload = 1
dofile(rompath .. '/dungeon/' .. lastmap)]]


	elseif (st == ABYSS_SAVE) then
		gsave()
		game = 0
	else
		st = ABYSS_MENU_MAIN
	end
end

Render.killWindow()