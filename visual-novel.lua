WINTER_FRAMERATE = 1000 / 30
Render.spawnWindow(WINTER_SCREEN_X, WINTER_SCREEN_Y, '<game name> | WinterMoon Engine ' .. WINTER_ENGINE_VERSION .. ' | ' .. WINTER_ENGINE_POSTFIX)
Render.setup2D(0, WINTER_SCREEN_X, 0, WINTER_SCREEN_Y)

WINTER_RENDER_S1  = {text = 'nil',}
WINTER_RENDER_S2  = {text = 'nil',}
WINTER_RENDER_S3  = {text = 'nil',}
WINTER_RENDER_S4  = {text = 'nil',}
WINTER_RENDER_S5  = {text = 'nil',}
WINTER_RENDER_S6  = {text = 'nil',}
WINTER_RENDER_S7  = {text = 'nil',}
WINTER_RENDER_S8  = {text = 'nil',}
WINTER_RENDER_S9  = {text = 'nil',}
WINTER_RENDER_S10 = {text = 'nil',}
WINTER_RENDER_S11 = {text = 'nil',}
WINTER_RENDER_S12 = {text = 'nil',}
WINTER_RENDER_S13 = {text = 'nil',}

yOffset   = 0
chatboxX  = 10
frames    = 0
layers    = 5

mode           = WINTER_MENU_MAIN
oldAudio       = 1
loadOffset     = 0
append         = Winter.getPath() .. '../Resources/package'

file = io.open(Winter.getPath() .. '../Resources/package/graphics.lua', 'r')
load(file:read('*a'))()
file:close()

playlist = {
	Audio.open(Winter.getPath() .. '../Resources/package/audio/Dracortia/Cherry_Kiss_rev3.mp3'),
}

vnui        = Winter.getPath() .. '../Resources/package/ui/testui.png'
testbg      = Winter.getPath() .. '../Resources/package/backgrounds/testbg.png'
testmenu    = Winter.getPath() .. '../Resources/package/ui/testmenu.png'
testbox     = Winter.getPath() .. '../Resources/package/ui/testbox.png'
hyenajpeg   = Winter.getPath() .. '../Resources/package/characters/hyenajpeg.png'
plastic     = Winter.getPath() .. '../Resources/package/backgrounds/plastic.png'

testf = {Font.loadFont(Winter.getPath() .. '../Resources/package/fonts/arial.ttf', 60), 0,}
azmyrian = {Font.loadFont(Winter.getPath() .. '../Resources/package/fonts/runetest.ttf', 60), 0,} --anglosaxon + latin
cenan = {nil, 0,} --chinese
iapakan = {nil, 0,} --japanese
nomyrian = {nil, 0,} --korean
vastan = {nil, 0,} --cyrillic
midrick = {nil, 0,} --make them speak dutch or something idk

mediumtestf = {Font.loadFont(Winter.getPath() .. '../Resources/package/fonts/arial.ttf', 38), 0,}
mediumazmyrian = {Font.loadFont(Winter.getPath() .. '../Resources/package/fonts/runetest.ttf', 38), 0,} --anglosaxon + latin
mediumcenan = {nil, 0,} --chinese
mediumiapakan = {nil, 0,} --japanese
mediumnomyrian = {nil, 0,} --korean
mediumvastan = {nil, 0,} --cyrillic
mediummidrick = {nil, 0,} --make them speak dutch or something idk

smalltestf = {Font.loadFont(Winter.getPath() .. '../Resources/package/fonts/arial.ttf', 24), 0,}
smallazmyrian = {Font.loadFont(Winter.getPath() .. '../Resources/package/fonts/runetest.ttf', 24), 0,} --anglosaxon + latin
smallcenan = {nil, 0,} --chinese
smalliapakan = {nil, 0,} --japanese
smallnomyrian = {nil, 0,} --korean
smallvastan = {nil, 0,} --cyrillic
smallmidrick = {nil, 0,} --make them speak dutch or something idk

weatherEffect = WINTER_WEATHER_CLEAR
weatherString = ''
weatherSeed = 0
weatherStart = 0
weatherEnd = 0
weatherScale = 0
weatherFramebuffer = ''
weatherBackground = ''
weatherCharacter = ''
weatherForeground = ''
weatherFall = 0
weatherDrift = 0
weatherRotate = 0
weatherStartRotate = 0
weatherDriftUpper = 0
weatherDriftLower = 0

Yorktown = {
	foreground     = Winter.getPath() .. '../Resources/package/backgrounds/Yorktown-foreground.png',
	characterlayer = Winter.getPath() .. '../Resources/package/backgrounds/Yorktown-character-layer.png',
	background     = Winter.getPath() .. '../Resources/package/backgrounds/Yorktown-background.png',
	skybox         = Winter.getPath() .. '../Resources/package/backgrounds/Yorktown-skybox.png',
}
NorthCarolina = {
	foreground     = Winter.getPath() .. '../Resources/package/backgrounds/NorthCarolina-foreground.png',
	characterlayer = Winter.getPath() .. '../Resources/package/backgrounds/NorthCarolina-character-layer.png',
	background     = Winter.getPath() .. '../Resources/package/backgrounds/NorthCarolina-background.png',
	skybox         = Winter.getPath() .. '../Resources/package/backgrounds/NorthCarolina-skybox.png',
}

YorktownParallax = {88, 0.5, 0.6, 0.85, 1.2, -126,}
NorthCarolinaParallax = {-60, 0.65, 0.7, 0.85, 1.2, -240,}

pages = {}

file = io.open(Winter.getPath() .. '../Resources/package/pages.rb', 'r')
rwby = file:read('*a')
file:close()

script = Ruby.runScript([[
	pages = []

	]] .. rwby .. [[

	fillHash!(pages)
	for i in 0...pages.length do
		lua_key_pairs(pages[i])
	end
]])
load(script)()
if (debugger == true) then
	print(script)
end

for i = 1, #pages do
	pages[i].text = Winter.processGender(pages[i].text)
	pages[i].time = Winter.processGender(pages[i].time)
	pages[i].date = Winter.processGender(pages[i].date)
	pages[i].location = Winter.processGender(pages[i].location)
	pages[i].region = Winter.processGender(pages[i].region)
	pages[i].name = Winter.processGender(pages[i].name)
	pages[i].title = Winter.processGender(pages[i].title)
	baseTag = "anglish"
	startTag = "<" .. baseTag .. ">"
	endTag = "</" .. baseTag .. ">"
	pages[i].text = Winter.processAnglish(pages[i].text)
	pages[i].time = Winter.processAnglish(pages[i].time)
	pages[i].date = Winter.processAnglish(pages[i].date)
	pages[i].location = Winter.processAnglish(pages[i].location)
	pages[i].region = Winter.processAnglish(pages[i].region)
	pages[i].name = Winter.processAnglish(pages[i].name)
	pages[i].title = Winter.processAnglish(pages[i].title)

	baseTag = "runes"
	startTag = "<" .. baseTag .. ">"
	endTag = "</" .. baseTag .. ">"
	pages[i].text = Winter.processRunes(pages[i].text)
	pages[i].time = Winter.processRunes(pages[i].time)
	pages[i].date = Winter.processRunes(pages[i].date)
	pages[i].location = Winter.processRunes(pages[i].location)
	pages[i].region = Winter.processRunes(pages[i].region)
	pages[i].name = Winter.processRunes(pages[i].name)
	pages[i].title = Winter.processRunes(pages[i].title)
end

WINTER_AUDIO_OFFSET = 184467440
latched = false
drawFrame = false
pageChange = false
pagenum = 0
running = true
Winter.clearButtons()
math.randomseed(543486374)
print('init finished')
while not Render.checkClose() do
	wtime = Winter.getClock()
	if (debugger == true) then
		debuglog = 'LOG: ' .. WINTER_PROCESSOR_NAME .. ':' .. WINTER_OS_PLATFORM .. ':' .. WINTER_OS_VERSION .. '\n'
		debugentries = 0
	end

	Render.updateInput()
	input.mouse.x = WINTER_MOUSE_X
	input.mouse.y = WINTER_MOUSE_Y
	input.mouse.position = {WINTER_MOUSE_1, WINTER_MOUSE_2, WINTER_MOUSE_3}
	input.key.up = WINTER_KEY_UP
	input.key.down = WINTER_KEY_DOWN
	input.key.left = WINTER_KEY_LEFT
	input.key.right = WINTER_KEY_RIGHT
	input.key.q = WINTER_KEY_Q
	input.key.e = WINTER_KEY_E
	input.key.a = WINTER_KEY_A
	input.key.d = WINTER_KEY_D
	input.key.w = WINTER_KEY_W
	input.key.s = WINTER_KEY_S

	pressed = 0
	if (input.mouse.position[WINTER_MOUSE_LEFT] == true) and not (onput.mouse.position[WINTER_MOUSE_LEFT] == true) then
		pressed = Winter.checkButton(input.mouse.x, input.mouse.y)
	end

	onput = {mouse = {x = -1, y = -1, position = {false, false, false},},}
	onput.mouse.x = WINTER_MOUSE_X
	onput.mouse.y = WINTER_MOUSE_Y
	onput.mouse.position = {WINTER_MOUSE_1, WINTER_MOUSE_2, WINTER_MOUSE_3}

	drawFrame = true
	Winter.renderStack()

	if (math.random(100) <= weatherSeed) and not (weatherEffect == WINTER_WEATHER_CLEAR) then
		WINTER_WEATHER_LAYER = math.random(layers - 1)
		if (WINTER_WEATHER_LAYER == 1) then
			WINTER_RENDER_TMP = weatherFramebuffer
			if not (WINTER_WEATHER_LAYER_PATH1 == WINTER_RENDER_TMP) then
				WINTER_WEATHER_LAYER_PATH1 = weatherFramebuffer
				Plush.killImage(WINTER_WEATHER_LAYER_IMAGE1)
				file = io.open(Winter.getPath() .. '../Resources/package/weather/' .. weatherString .. WINTER_RENDER_TMP)
				if not (file) then
					WINTER_RENDER_TMP2 = nobmp
				else
					file:close()
					WINTER_RENDER_TMP2 = Winter.getPath() .. '../Resources/package/weather/' .. weatherString .. WINTER_RENDER_TMP
				end
				WINTER_WEATHER_LAYER_IMAGE1 = Plush.loadPNG(WINTER_RENDER_TMP2)
			end
		elseif (WINTER_WEATHER_LAYER == 2) then
			WINTER_RENDER_TMP = weatherBackground
			if not (WINTER_WEATHER_LAYER_PATH2 == WINTER_RENDER_TMP) then
				WINTER_WEATHER_LAYER_PATH2 = weatherBackground
				Plush.killImage(WINTER_WEATHER_LAYER_IMAGE2)
				file = io.open(Winter.getPath() .. '../Resources/package/weather/' .. weatherString .. WINTER_RENDER_TMP)
				if not (file) then
					WINTER_RENDER_TMP2 = nobmp
				else
					file:close()
					WINTER_RENDER_TMP2 = Winter.getPath() .. '../Resources/package/weather/' .. weatherString .. WINTER_RENDER_TMP
				end
				WINTER_WEATHER_LAYER_IMAGE2 = Plush.loadPNG(WINTER_RENDER_TMP2)
			end
		elseif (WINTER_WEATHER_LAYER == 3) then
			WINTER_RENDER_TMP = weatherCharacter
			if not (WINTER_WEATHER_LAYER_PATH3 == WINTER_RENDER_TMP) then
				WINTER_WEATHER_LAYER_PATH3 = weatherCharacter
				Plush.killImage(WINTER_WEATHER_LAYER_IMAGE3)
				file = io.open(Winter.getPath() .. '../Resources/package/weather/' .. weatherString .. WINTER_RENDER_TMP)
				if not (file) then
					WINTER_RENDER_TMP2 = nobmp
				else
					file:close()
					WINTER_RENDER_TMP2 = Winter.getPath() .. '../Resources/package/weather/' .. weatherString .. WINTER_RENDER_TMP
				end
				WINTER_WEATHER_LAYER_IMAGE3 = Plush.loadPNG(WINTER_RENDER_TMP2)
			end
		elseif (WINTER_WEATHER_LAYER == 4) then
			WINTER_RENDER_TMP = weatherForeground
			if not (WINTER_WEATHER_LAYER_PATH4 == WINTER_RENDER_TMP) then
				WINTER_WEATHER_LAYER_PATH4 = weatherForeground
				Plush.killImage(WINTER_WEATHER_LAYER_IMAGE4)
				file = io.open(Winter.getPath() .. '../Resources/package/weather/' .. weatherString .. WINTER_RENDER_TMP)
				if not (file) then
					WINTER_RENDER_TMP2 = nobmp
				else
					file:close()
					WINTER_RENDER_TMP2 = Winter.getPath() .. '../Resources/package/weather/' .. weatherString .. WINTER_RENDER_TMP
				end
				WINTER_WEATHER_LAYER_IMAGE4 = Plush.loadPNG(WINTER_RENDER_TMP2)
			end
		end
		renderQueue[#renderQueue + 1] = {
			identifier = WINTER_WEATHER .. weatherString,
			layer = WINTER_WEATHER_LAYER,
			surface = nil,
			text = Winter.getPath() .. '../Resources/package/weather/' .. weatherString .. WINTER_RENDER_TMP,
			text2 = nobmp,
			x = math.random(960),
			y = weatherStart,
			fw = weatherFall,
			w = weatherDrift,
			h = weatherRotate,
			colour = 0,
			type = WINTER_WEATHER,
			font = Winter.clamp(math.random(weatherDriftUpper) + weatherDriftLower, weatherDriftLower, weatherDriftUpper),
			scale = weatherScale, 
			rotation = weatherStartRotate
		}
		if (WINTER_WEATHER_LAYER == 1) then
			renderQueue[#renderQueue].surface = WINTER_WEATHER_LAYER_IMAGE1
		elseif (WINTER_WEATHER_LAYER == 2) then
			renderQueue[#renderQueue].surface = WINTER_WEATHER_LAYER_IMAGE2
		elseif (WINTER_WEATHER_LAYER == 3) then
			renderQueue[#renderQueue].surface = WINTER_WEATHER_LAYER_IMAGE3
		elseif (WINTER_WEATHER_LAYER == 4) then
			renderQueue[#renderQueue].surface = WINTER_WEATHER_LAYER_IMAGE4
		end
	end

	if (mode == WINTER_MENU_MAIN) then
		if (latched == false) then
			latched = true
			Winter.cleanup()

			weatherEffect = WINTER_WEATHER_CLEAR
			weatherString = ''
			weatherSeed = 0
			weatherStart = 0
			weatherEnd = 0
			weatherScale = 0
			weatherFramebuffer = ''
			weatherBackground = ''
			weatherCharacter = ''
			weatherForeground = ''
			weatherFall = 0
			weatherDrift = 0
			weatherRotate = 0
			weatherStartRotate = 0
			weatherDriftUpper = 0
			weatherDriftLower = 0

			renderQueue[#renderQueue + 1] = {identifier = WINTER_BACKGROUND, layer = WINTER_LAYER_FRAMEBUFFER, surface = nil, text = testbg, text2 = testbg, x = 0, y = 0, fw = nil, w = nil, h = nil, colour = nil, type = WINTER_IMAGE, font = nil, scale = 1.0, rotation = 0}
			renderQueue[#renderQueue + 1] = {identifier = WINTER_INTERFACE, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = testmenu, text2 = testbmenu, x = 0, y = 0, fw = nil, w = nil, h = nil, colour = nil, type = WINTER_IMAGE, font = nil, scale = 1.0, rotation = 0}
			renderQueue[#renderQueue + 1] = {identifier = WINTER_TITLE, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = '<runes>WinterMoon v0.3 prototype</runes>', text2 = '', x = 960, y = 494, fw = nil, w = nil, h = nil, colour = cwhite, type = WINTER_TEXT_SLIDE_LEFT, font = azmyrian, scale = 1.0, rotation = 0}
			if (skipwarning == false) then
				renderQueue[#renderQueue + 1] = {identifier = WINTER_TITLE, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = 'This software is not intended for use within the United States or United Kingdom.\nUse of this software for profit in these regions may result in DMCA takedowns.', text2 = '', x = 960, y = 440, fw = nil, w = nil, h = nil, colour = {255, 255, 255, 50}, type = WINTER_TEXT_SLIDE_LEFT, font = smalltestf, scale = 1.0, rotation = 0}
			end
			renderQueue[#renderQueue + 1] = {identifier = WINTER_GAME_NEW, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = '<runes>Start Anew</runes>', text2 = '', x = 3, y = 8, fw = nil, w = nil, h = nil, colour = cwhite, type = WINTER_TEXT_SLIDE_RIGHT, font = azmyrian, scale = 1.0, rotation = 0}
			file = io.open(Winter.getPath() .. '../Resources/volatile/save' .. saveslot * 2 .. '.plush')
			Winter.pushButton(3, 483, 3, 63, 1)
			if (file) then
				file:close()
				renderQueue[#renderQueue + 1] = {identifier = WINTER_GAME_LOAD, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = '<runes>Start Abridged</runes>', text2 = '', x = 3, y = 72, fw = nil, w = nil, h = nil, colour = cwhite, type = WINTER_TEXT_SLIDE_RIGHT, font = azmyrian, scale = 1.0, rotation = 0}
				Winter.pushButton(3, 483, 64, 128, 2)
			else
				renderQueue[#renderQueue + 1] = {identifier = WINTER_GAME_LOAD, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = '<runes>No Restores</runes>', text2 = '', x = 3, y = 72, fw = nil, w = nil, h = nil, colour = cbrownink, type = WINTER_TEXT_SLIDE_RIGHT, font = azmyrian, scale = 1.0, rotation = 0}
			end
			Audio.play(playlist[1], true, 0)
		end

		if (pressed > 0) then
			latched = false
			prevBuffer = Render.getWindow()
			Plush.modifyImage(prevBuffer, WINTER_AETHER_CLEANUP, 0, 0, 0, 0)

			if (pressed == 1) then
				pagenum = 1
				previousMode = mode
				mode = WINTER_GAME_TARGET
			elseif (pressed == 2) then
				pagenum = 1
				previousMode = mode
				mode = WINTER_GAME_TARGET
				file = io.open(Winter.getPath() .. '../Resources/volatile/save' .. saveslot * 2 + 1 .. '.plush', 'r')
				if (file) then
					file:close()
					file = io.open(Winter.getPath() .. '../Resources/volatile/save' .. saveslot * 2 + 1 .. '.plush')
					checksum = tonumber(file:read('*a'))
					if (debugger == true) then
						debugentries = debugentries + 1
						debuglog = debuglog .. debugentries .. ": Checksum: " .. checksum .. "\n"
					end
					file:close()
					file = io.open(Winter.getPath() .. '../Resources/volatile/save' .. saveslot * 2 .. '.plush', 'r')
					if (file) then
						file:close()
						file = io.open(Winter.getPath() .. '../Resources/volatile/save' .. saveslot * 2 .. '.plush')
						savestring = file:read('*a')
						file:close()
						if (Winter.checksum(savestring) == checksum) or (checksumBypass == true) then
							if (debugger == true) then
								debugentries = debugentries + 1
								debuglog = debuglog .. debugentries .. ": Checksum passed\n   Expected: " .. Winter.checksum(savestring) .. " (debug mode)\n"
							end
							print(savestring)
							load(savestring)()
						else
							if (debugger == true) then
								debugentries = debugentries + 1
								debuglog = debuglog .. debugentries .. ": Checksum failed\n   Expected: " .. Winter.checksum(savestring) .. "\n"
							end
						end
					end
				end
			end
		end


	elseif (mode == WINTER_GAME_VISUAL_NOVEL) then
		if (latched == false) then
			Winter.cleanup()
			pressed = 0
			latched = true
			input.mouse.position[WINTER_MOUSE_LEFT] = false
			pageChange = true
			yOffset = Winter.round(pages[pagenum].height)
			WINTER_RENDER_S1  = {identifier = '543486374', text = 'nil', surface = nil, surface1 = nil, surface2 = nil, surface3 = nil, surface4 = nil, action = 543486374}
			WINTER_RENDER_S2  = {identifier = '543486374', text = 'nil', surface = nil, action = 543486374}
			WINTER_RENDER_S3  = {identifier = '543486374', text = 'nil', surface = nil, action = 543486374}
			WINTER_RENDER_S4  = {identifier = '543486374', text = 'nil', surface = nil, action = 543486374}
			WINTER_RENDER_S5  = {identifier = '543486374', text = 'nil', surface = nil, action = 543486374}
			WINTER_RENDER_S6  = {identifier = '543486374', text = 'nil', surface = nil, action = 543486374}
			WINTER_RENDER_S7  = {identifier = '543486374', text = 'nil', surface = nil, action = 543486374}
			WINTER_RENDER_S8  = {identifier = '543486374', text = 'nil', surface = nil, action = 543486374}
			WINTER_RENDER_S9  = {identifier = '543486374', text = 'nil', surface = nil, action = 543486374}
			WINTER_RENDER_S10 = {identifier = '543486374', text = 'nil', surface = nil, action = 543486374}
			WINTER_RENDER_S11 = {identifier = '543486374', text = 'nil', surface = nil, action = 543486374}
			WINTER_RENDER_S12 = {identifier = '543486374', text = 'nil', surface = nil, action = 543486374}
			WINTER_RENDER_S13 = {identifier = '543486374', text = 'nil', surface = nil, action = 543486374}
			renderQueue = {
				[1]  = {identifier = '543486374', text = 'null', surface = nil, surface1 = nil, surface2 = nil, surface3 = nil, surface4 = nil, action = 543486374},
				[2]  = {identifier = '543486374', text = 'null', surface = nil, action = 543486374},
				[3]  = {identifier = '543486374', text = 'null', surface = nil, action = 543486374},
				[4]  = {identifier = '543486374', text = 'null', surface = nil, action = 543486374},
				[5]  = {identifier = '543486374', text = 'null', surface = nil, action = 543486374},
				[6]  = {identifier = '543486374', text = 'null', surface = nil, action = 543486374},
				[7]  = {identifier = '543486374', text = 'null', surface = nil, action = 543486374},
				[8]  = {identifier = '543486374', text = 'null', surface = nil, action = 543486374},
				[9]  = {identifier = '543486374', text = 'null', surface = nil, action = 543486374},
				[10] = {identifier = '543486374', text = 'null', surface = nil, action = 543486374},
				[11] = {identifier = '543486374', text = 'null', surface = nil, action = 543486374},
				[12] = {identifier = '543486374', text = 'null', surface = nil, action = 543486374},
				[13] = {identifier = '543486374', text = 'null', surface = nil, action = 543486374},
			}
		end

		if (yOffset ~= Winter.round(pages[pagenum].height)) and (pageChange == false) then
			if (yOffset > Winter.round(pages[pagenum].height)) then
				yOffset = yOffset - Winter.round((yOffset - Winter.round(pages[pagenum].height)) / pages[pagenum].speed)
			elseif (yOffset < Winter.round(pages[pagenum].height)) then
				yOffset = yOffset + Winter.round((Winter.round(pages[pagenum].height) - yOffset) / pages[pagenum].speed)
			end
		end

		if (pageChange == true) then
			weatherEffect = pages[pagenum].weather
			weatherString = pages[pagenum].weathereffect
			weatherSeed = pages[pagenum].weatherseed
			weatherStart = pages[pagenum].weatherstart
			weatherEnd = pages[pagenum].weatherend
			weatherScale = pages[pagenum].weatherscale
			weatherFramebuffer = pages[pagenum].weatherfb
			weatherBackground = pages[pagenum].weatherbg
			weatherCharacter = pages[pagenum].weathercl
			weatherForeground = pages[pagenum].weatherfg
			weatherFall = pages[pagenum].weatherfall
			weatherDrift = pages[pagenum].weatherdrift
			weatherRotate = pages[pagenum].weatherrotate
			weatherStartRotate = pages[pagenum].weatherstartrotate
			weatherDriftUpper = pages[pagenum].weatherdriftupper
			weatherDriftLower = pages[pagenum].weatherdriftlower

			chatboxX = pages[pagenum].padding
			framecolour = pages[pagenum].colour
			WINTER_FRAMERATE = pages[pagenum].framerate
			for i = 1, #renderQueue do
				if (renderQueue[i].identifier == WINTER_OPTION_1) or (renderQueue[i].identifier == WINTER_OPTION_2) or (renderQueue[i].identifier == WINTER_OPTION_3) then
					Plush.killImage(renderQueue[i].surface)
					renderQueue[i] = {type = WINTER_RENDER_SKIP}
					purgeList[#purgeList + 1] = i
				end
			end
			Winter.clearButtons()
			if (pages[pagenum].option == true) then
				if (#pages[pagenum].options == 1) then
					Winter.pushButton(360 + pages[pagenum].padding, 600 - pages[pagenum].padding, 213, 169, 3)
					renderQueue[#renderQueue + 1] = {identifier = WINTER_OPTION_1, layer = WINTER_LAYER_FRAMEBUFFER, surface = nil, text = pages[pagenum].selection, text2 = pages[pagenum].selectionFallback, x = 360, y = 169, fw = nil, w = nil, h = nil, colour = nil, type = WINTER_IMAGE, font = nil, scale = 1.0, rotation = 0}
					renderQueue[#renderQueue + 1] = {identifier = WINTER_OPTION_1, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = pages[pagenum].options[1][1], text2 = '', x = 360 + pages[pagenum].padding, y = 128, fw = 240, w = nil, h = nil, colour = cbrownink, type = WINTER_TEXT, font = pages[pagenum].ftext, scale = 1.0, rotation = 0}
				end
				if (#pages[pagenum].options == 2) then
					Winter.pushButton(360 + pages[pagenum].padding, 600 - pages[pagenum].padding, 112, 68, 3)
					Winter.pushButton(360 + pages[pagenum].padding, 600 - pages[pagenum].padding, 180, 136, 4)
					renderQueue[#renderQueue + 1] = {identifier = WINTER_OPTION_1, layer = WINTER_LAYER_FRAMEBUFFER, surface = nil, text = pages[pagenum].selection, text2 = pages[pagenum].selectionFallback, x = 360, y = 65, fw = nil, w = nil, h = nil, colour = nil, type = WINTER_IMAGE, font = nil, scale = 1.0, rotation = 0}
					renderQueue[#renderQueue + 1] = {identifier = WINTER_OPTION_2, layer = WINTER_LAYER_FRAMEBUFFER, surface = nil, text = pages[pagenum].selection, text2 = pages[pagenum].selectionFallback, x = 360, y = 133, fw = nil, w = nil, h = nil, colour = nil, type = WINTER_IMAGE, font = nil, scale = 1.0, rotation = 0}
					renderQueue[#renderQueue + 1] = {identifier = WINTER_OPTION_1, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = pages[pagenum].options[1][1], text2 = '', x = 360 + pages[pagenum].padding, y = 68, fw = 240, w = nil, h = nil, colour = cbrownink, type = WINTER_TEXT, font = pages[pagenum].ftext, scale = 1.0, rotation = 0}
					renderQueue[#renderQueue + 1] = {identifier = WINTER_OPTION_2, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = pages[pagenum].options[2][1], text2 = '', x = 360 + pages[pagenum].padding, y = 136, fw = 240, w = nil, h = nil, colour = cbrownink, type = WINTER_TEXT, font = pages[pagenum].ftext, scale = 1.0, rotation = 0}
				end
				if (#pages[pagenum].options >= 3) then
					Winter.pushButton(360 + pages[pagenum].padding, 600 - pages[pagenum].padding, 112, 68, 3)
					Winter.pushButton(360 + pages[pagenum].padding, 600 - pages[pagenum].padding, 180, 136, 4)
					Winter.pushButton(360 + pages[pagenum].padding, 600 - pages[pagenum].padding, 248, 204, 5)
					renderQueue[#renderQueue + 1] = {identifier = WINTER_OPTION_1, layer = WINTER_LAYER_FRAMEBUFFER, surface = nil, text = pages[pagenum].selection, text2 = pages[pagenum].selectionFallback, x = 360, y = 65, fw = nil, w = nil, h = nil, colour = nil, type = WINTER_IMAGE, font = nil, scale = 1.0, rotation = 0}
					renderQueue[#renderQueue + 1] = {identifier = WINTER_OPTION_2, layer = WINTER_LAYER_FRAMEBUFFER, surface = nil, text = pages[pagenum].selection, text2 = pages[pagenum].selectionFallback, x = 360, y = 133, fw = nil, w = nil, h = nil, colour = nil, type = WINTER_IMAGE, font = nil, scale = 1.0, rotation = 0}
					renderQueue[#renderQueue + 1] = {identifier = WINTER_OPTION_3, layer = WINTER_LAYER_FRAMEBUFFER, surface = nil, text = pages[pagenum].selection, text2 = pages[pagenum].selectionFallback, x = 360, y = 201, fw = nil, w = nil, h = nil, colour = nil, type = WINTER_IMAGE, font = nil, scale = 1.0, rotation = 0}
					renderQueue[#renderQueue + 1] = {identifier = WINTER_OPTION_1, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = pages[pagenum].options[1][1], text2 = '', x = 360 + pages[pagenum].padding, y = 68, fw = 240, w = nil, h = nil, colour = cbrownink, type = WINTER_TEXT, font = pages[pagenum].ftext, scale = 1.0, rotation = 0}
					renderQueue[#renderQueue + 1] = {identifier = WINTER_OPTION_2, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = pages[pagenum].options[2][1], text2 = '', x = 360 + pages[pagenum].padding, y = 136, fw = 240, w = nil, h = nil, colour = cbrownink, type = WINTER_TEXT, font = pages[pagenum].ftext, scale = 1.0, rotation = 0}
					renderQueue[#renderQueue + 1] = {identifier = WINTER_OPTION_3, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = pages[pagenum].options[3][1], text2 = '', x = 360 + pages[pagenum].padding, y = 204, fw = 240, w = nil, h = nil, colour = cbrownink, type = WINTER_TEXT, font = pages[pagenum].ftext, scale = 1.0, rotation = 0}
				end
			else
				Winter.pushButton(0 + pages[pagenum].padding, 960 - pages[pagenum].padding, 382, 534, 1)
			end
			Winter.pushButton(922, 953, 68, 98, 2)

			if (pages[pagenum].action) then
				if (pages[pagenum].action == WINTER_PARALLAX) and not (renderQueue[WINTER_RENDER_1].action == WINTER_PARALLAX) then
					Plush.killImage(renderQueue[WINTER_RENDER_1].surface)
					renderQueue[WINTER_RENDER_1] = {identifier = pages[pagenum].background.skybox, layer = nil, surface = nil, surface1 = nil, surface2 = nil, surface3 = nil, surface4 = nil, text = pages[pagenum].background, text2 = pages[pagenum].backgroundFallback, x = 0, y = 0, fw = nil, w = nil, h = nil, colour = nil, type = WINTER_PARALLAX, font = nil, action = WINTER_PARALLAX, scale = 1.0, rotation = 0}
					load('parallaxPoints = ' .. pages[pagenum].actionPath)()
					WINTER_RENDER_SKIP_PARALLAX = true
				end
				if (WINTER_RENDER_SKIP_PARALLAX == false) and (pages[pagenum].action == WINTER_PARALLAX) then
					if not (WINTER_RENDER_S1.identifier == pages[pagenum].background.skybox) then
						Plush.killImage(renderQueue[WINTER_RENDER_1].surface)
						Plush.killImage(renderQueue[WINTER_RENDER_1].surface1)
						Plush.killImage(renderQueue[WINTER_RENDER_1].surface2)
						Plush.killImage(renderQueue[WINTER_RENDER_1].surface3)
						Plush.killImage(renderQueue[WINTER_RENDER_1].surface4)
						renderQueue[WINTER_RENDER_1] = {identifier = pages[pagenum].background.skybox, layer = nil, surface = nil, surface1 = nil, surface2 = nil, surface3 = nil, surface4 = nil, text = pages[pagenum].background, text2 = pages[pagenum].backgroundFallback, x = 0, y = 0, fw = nil, w = nil, h = nil, colour = nil, type = WINTER_PARALLAX, font = nil, action = WINTER_PARALLAX, scale = 1.0, rotation = 0}
						load('parallaxPoints = ' .. pages[pagenum].actionPath)()
					end
				end
				WINTER_RENDER_SKIP_PARALLAX = flase
			else
				if (renderQueue[WINTER_RENDER_1].action == WINTER_PARALLAX) then
					Plush.killImage(renderQueue[WINTER_RENDER_1].surface)
					Plush.killImage(renderQueue[WINTER_RENDER_1].surface1)
					Plush.killImage(renderQueue[WINTER_RENDER_1].surface2)
					Plush.killImage(renderQueue[WINTER_RENDER_1].surface3)
					Plush.killImage(renderQueue[WINTER_RENDER_1].surface4)
				end
				if not (WINTER_RENDER_S1.text == pages[pagenum].background) then
					Plush.killImage(renderQueue[WINTER_RENDER_1].surface)
					renderQueue[WINTER_RENDER_1] = {identifier = WINTER_BACKGROUND, layer = WINTER_LAYER_FRAMEBUFFER, surface = nil, text = pages[pagenum].background, text2 = pages[pagenum].backgroundFallback, x = 0, y = 0, fw = nil, w = nil, h = nil, colour = nil, type = WINTER_IMAGE, font = nil, scale = 1.0, rotation = 0}
				end
				WINTER_RENDER_S1 = renderQueue[WINTER_RENDER_1]
			end
			if not (WINTER_RENDER_S3.text == pages[pagenum].char1) or (pages[pagenum].active1 ~= pages[Winter.clamp(pagenum - 1, 1, #pages)].active1) then
				Plush.killImage(renderQueue[WINTER_RENDER_3].surface)
				WINTER_INACTIVE_1 = false
				renderQueue[WINTER_RENDER_3] = {identifier = WINTER_CHARACTER1, layer = WINTER_LAYER_CHARACTER, surface = nil, text = pages[pagenum].char1, text2 = pages[pagenum].char1Fallback, x = nil, y = nil, fw = nil, w = nil, h = nil, colour = nil, type = WINTER_CHARACTER1, font = nil, scale = 1.0, rotation = 0}
			end
			if not (WINTER_RENDER_S2.text == pages[pagenum].char2) or (pages[pagenum].active2 ~= pages[Winter.clamp(pagenum - 1, 1, #pages)].active2) then
				Plush.killImage(renderQueue[WINTER_RENDER_2].surface)
				WINTER_INACTIVE_2 = false
				renderQueue[WINTER_RENDER_2] = {identifier = WINTER_CHARACTER2, layer = WINTER_LAYER_CHARACTER, surface = nil, text = pages[pagenum].char2, text2 = pages[pagenum].char2Fallback, x = nil, y = nil, fw = nil, w = nil, h = nil, colour = nil, type = WINTER_CHARACTER2, font = nil, scale = 1.0, rotation = 0}
			end
			if not (WINTER_RENDER_S5.text == pages[pagenum].char3) or (pages[pagenum].active3 ~= pages[Winter.clamp(pagenum - 1, 1, #pages)].active3) then
				Plush.killImage(renderQueue[WINTER_RENDER_5].surface)
				WINTER_INACTIVE_3 = false
				renderQueue[WINTER_RENDER_5] = {identifier = WINTER_CHARACTER3, layer = WINTER_LAYER_CHARACTER, surface = nil, text = pages[pagenum].char3, text2 = pages[pagenum].char3Fallback, x = nil, y = nil, fw = nil, w = nil, h = nil, colour = nil, type = WINTER_CHARACTER3, font = nil, scale = 1.0, rotation = 0}
			end
			if not (WINTER_RENDER_S4.text == pages[pagenum].char4) or (pages[pagenum].active4 ~= pages[Winter.clamp(pagenum - 1, 1, #pages)].active4) then
				Plush.killImage(renderQueue[WINTER_RENDER_4].surface)
				WINTER_INACTIVE_4 = false
				renderQueue[WINTER_RENDER_4] = {identifier = WINTER_CHARACTER4, layer = WINTER_LAYER_CHARACTER, surface = nil, text = pages[pagenum].char4, text2 = pages[pagenum].char4Fallback, x = nil, y = nil, fw = nil, w = nil, h = nil, colour = nil, type = WINTER_CHARACTER4, font = nil, scale = 1.0, rotation = 0}
			end
			if not (WINTER_RENDER_S6.text == pages[pagenum].ui) then
				Plush.killImage(renderQueue[WINTER_RENDER_6].surface)
				renderQueue[WINTER_RENDER_6] = {identifier = WINTER_INTERFACE, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = pages[pagenum].ui, text2 = pages[pagenum].uiFallback, x = 0, y = 0, fw = nil, w = nil, h = nil, colour = nil, type = WINTER_IMAGE, font = nil, scale = 1.0, rotation = 0}
			end
			if not (WINTER_RENDER_S7.text == pages[pagenum].text) then
				Plush.killImage(renderQueue[WINTER_RENDER_7].surface)
				renderQueue[WINTER_RENDER_7] = {identifier = WINTER_MESSAGE, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = pages[pagenum].text, text2 = '', x = chatboxX, y = 382, fw = nil, w = nil, h = nil, colour = cbrownink, type = WINTER_TEXT_SLIDE_RIGHT, font = pages[pagenum].ftext, scale = 1.0, rotation = 0}
			end
			if not (WINTER_RENDER_S8.text == pages[pagenum].date) then
				Plush.killImage(renderQueue[WINTER_RENDER_8].surface)
				renderQueue[WINTER_RENDER_8] = {identifier = WINTER_DATE, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = pages[pagenum].date, text2 = '', x = 10, y = 42, fw = nil, w = nil, h = nil, colour = cwhite, type = WINTER_TEXT, font = pages[pagenum].fdate, scale = 1.0, rotation = 0}
			end
			if not (WINTER_RENDER_S9.text == pages[pagenum].time) then
				Plush.killImage(renderQueue[WINTER_RENDER_9].surface)
				renderQueue[WINTER_RENDER_9] = {identifier = WINTER_TIME, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = pages[pagenum].time, text2 = '', x = 10, y = 12, fw = nil, w = nil, h = nil, colour = cwhite, type = WINTER_TEXT, font = pages[pagenum].ftime, scale = 1.0, rotation = 0}
			end
			if not (WINTER_RENDER_S10.text == pages[pagenum].name) then
				Plush.killImage(renderQueue[WINTER_RENDER_10].surface)
				renderQueue[WINTER_RENDER_10] = {identifier = WINTER_NAME, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = pages[pagenum].name, text2 = '', x = chatboxX, y = 352, fw = nil, w = nil, h = nil, colour = cwhite, type = WINTER_TEXT, font = pages[pagenum].fname, scale = 1.0, rotation = 0}
			end
			if not (WINTER_RENDER_S11.text == pages[pagenum].title) then
				Plush.killImage(renderQueue[WINTER_RENDER_11].surface)
				renderQueue[WINTER_RENDER_11] = {identifier = WINTER_TITLE, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = pages[pagenum].title, text2 = '', x = chatboxX, y = 322, fw = nil, w = nil, h = nil, colour = cbrownink, type = WINTER_TEXT, font = pages[pagenum].ftitle, scale = 1.0, rotation = 0}
			end
			if not (WINTER_RENDER_S12.text == pages[pagenum].location) then
				Plush.killImage(renderQueue[WINTER_RENDER_12].surface)
				renderQueue[WINTER_RENDER_12] = {identifier = WINTER_LOCATION, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = pages[pagenum].location, text2 = '', x = 750, y = 12, fw = nil, w = nil, h = nil, colour = cwhite, type = WINTER_TEXT, font = pages[pagenum].flocation, scale = 1.0, rotation = 0}
			end
			if not (WINTER_RENDER_S13.text == pages[pagenum].region) then
				Plush.killImage(renderQueue[WINTER_RENDER_13].surface)
				renderQueue[WINTER_RENDER_13] = {identifier = WINTER_REGION, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = pages[pagenum].region, text2 = '', x = 850, y = 42, fw = nil, w = nil, h = nil, colour = cbrownink, type = WINTER_TEXT, font = pages[pagenum].fregion, scale = 1.0, rotation = 0}
			end
			WINTER_RENDER_S1 = renderQueue[WINTER_RENDER_1]
			WINTER_RENDER_S3 = renderQueue[WINTER_RENDER_3]
			WINTER_RENDER_S2 = renderQueue[WINTER_RENDER_2]
			WINTER_RENDER_S5 = renderQueue[WINTER_RENDER_5]
			WINTER_RENDER_S4 = renderQueue[WINTER_RENDER_4]
			WINTER_RENDER_S6 = renderQueue[WINTER_RENDER_6]
			WINTER_RENDER_S7 = renderQueue[WINTER_RENDER_7]
			WINTER_RENDER_S8 = renderQueue[WINTER_RENDER_8]
			WINTER_RENDER_S9 = renderQueue[WINTER_RENDER_9]
			WINTER_RENDER_S10 = renderQueue[WINTER_RENDER_10]
			WINTER_RENDER_S11 = renderQueue[WINTER_RENDER_11]
			WINTER_RENDER_S12 = renderQueue[WINTER_RENDER_12]
			WINTER_RENDER_S13 = renderQueue[WINTER_RENDER_13]

			if not (oldAudio == pages[pagenum].music) and (pagenum > 1) then
				if (loadOffset > 0) then
					offset = loadOffset
					loadOffset = 0
				else
					offset = pages[pagenum].musicFallback
				end
				Audio.pause(playlist[pages[pagenum - 1].music])
				Audio.play(playlist[pages[pagenum].music], true, offset)
				oldAudio = pages[pagenum].music
			end

			pageChange = false
		end

		if (pressed > 0) then
			if Winter.between(pressed, 3, 5) then
				load(pages[pagenum].options[pressed - 2][2])()
				pressed = 1
				pagenum = pagenum - 1
			end
			if (pressed == 1) then
				pageChange = true
				drawFrame = false
				pagenum = pagenum + 1
				if (pagenum <= #pages) and (pages[pagenum].targetpage) then
					pagenum = pages[pagenum].targetpage
				end
				if (pagenum > #pages) then
					Winter.cleanup()
					latched = false
					mode = WINTER_MENU_MAIN
				end
			end
			if (pressed == 2) then
				latched = false
				previousMode = mode
				mode = WINTER_MENU_SAVE
				prevBuffer = Render.getWindow()
				Plush.modifyImage(prevBuffer, WINTER_AETHER_CLEANUP, 0, 0, 0, 0)
			end
		end


	elseif (mode == WINTER_MENU_SAVE) then
		if (latched == false) then
			Winter.cleanup(true)
			latched = true
			renderQueue[#renderQueue + 1] = {identifier = WINTER_BACKGROUND, layer = WINTER_LAYER_FRAMEBUFFER, surface = prevBuffer, text = nil, text2 = nil, x = 0, y = 0, fw = nil, w = nil, h = nil, colour = nil, type = WINTER_IMAGE, font = nil, scale = framebufferScale, rotation = 0}

			Winter.pushButton(360 + chatboxX, 600 - chatboxX, 112, 68, 1)
			Winter.pushButton(360 + chatboxX, 600 - chatboxX, 180, 136, 2)
			Winter.pushButton(360 + chatboxX, 600 - chatboxX, 248, 204, 3)
			renderQueue[#renderQueue + 1] = {identifier = WINTER_OPTION_1, layer = WINTER_LAYER_FRAMEBUFFER, surface = nil, text = testbox, text2 = testbox, x = 360, y = 65, fw = nil, w = nil, h = nil, colour = nil, type = WINTER_IMAGE, font = nil, scale = 1.0, rotation = 0}
			renderQueue[#renderQueue + 1] = {identifier = WINTER_OPTION_2, layer = WINTER_LAYER_FRAMEBUFFER, surface = nil, text = testbox, text2 = testbox, x = 360, y = 133, fw = nil, w = nil, h = nil, colour = nil, type = WINTER_IMAGE, font = nil, scale = 1.0, rotation = 0}
			renderQueue[#renderQueue + 1] = {identifier = WINTER_OPTION_3, layer = WINTER_LAYER_FRAMEBUFFER, surface = nil, text = testbox, text2 = testbox, x = 360, y = 201, fw = nil, w = nil, h = nil, colour = nil, type = WINTER_IMAGE, font = nil, scale = 1.0, rotation = 0}
			renderQueue[#renderQueue + 1] = {identifier = WINTER_OPTION_1, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = '<runes>Save Game</runes>', text2 = '', x = 360 + pages[pagenum].padding, y = 68, fw = 240, w = nil, h = nil, colour = cbrownink, type = WINTER_TEXT, font = pages[pagenum].ftext, scale = 1.0, rotation = 0}
			renderQueue[#renderQueue + 1] = {identifier = WINTER_OPTION_2, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = '<runes>Renounce Save</runes>', text2 = '', x = 360 + pages[pagenum].padding, y = 136, fw = 240, w = nil, h = nil, colour = cbrownink, type = WINTER_TEXT, font = pages[pagenum].ftext, scale = 1.0, rotation = 0}
			renderQueue[#renderQueue + 1] = {identifier = WINTER_OPTION_3, layer = WINTER_LAYER_FOREGROUND, surface = nil, text = '<runes>Return to Game</runes>', text2 = '', x = 360 + pages[pagenum].padding, y = 204, fw = 240, w = nil, h = nil, colour = cbrownink, type = WINTER_TEXT, font = pages[pagenum].ftext, scale = 1.0, rotation = 0}
		end
		if (pressed > 0) then
			if (pressed == 1) then
				Winter.saveGame(saveslot)
			end
			if (pressed == 2) then
				os.remove(Winter.getPath() .. '../Resources/volatile/save' .. saveslot * 2 .. '.plush')
				os.remove(Winter.getPath() .. '../Resources/volatile/save' .. saveslot * 2 + 1 .. '.plush')
			end
			if (pressed == 3) then
				latched = false
				mode = previousMode
			end
		end


	elseif (mode == WINTER_RENDER_EXIT) then
		Winter.cleanup()
		Render.killWindow()


	end

	--[[homographymatrix = {
		{0, 300}, --top left
		{244, 544}, --top right
		{544, 0}, --bottom right
		{0, 0}, --bottom left
	}
	transformed = Plush.transformImage(hyenajpegpng, homographymatrix[1][1], homographymatrix[2][1], homographymatrix[3][1], homographymatrix[4][1], homographymatrix[1][2], homographymatrix[2][2], homographymatrix[3][2], homographymatrix[4][2])
	Plush.mirrorImage(transformed, false)
	Render.renderImage(transformed, 0, 0, 1.0)
	Plush.killImage(transformed)]]

	if (drawFrame) then
		Render.renderImage(WINTER_FRAMEBUFFER, 0, 0, 1.0, 0.0)
		Render.killTexture(WINTER_FRAMEBUFFER)
		Render.forceUpdate()
		Render.exchangeBuffer()
		Render.clearBuffer(framecolour[1], framecolour[2], framecolour[3], framecolour[4])
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
		debuglog = debuglog .. debugentries .. ': Frame #' .. frames .. '\n   render time: ' .. wtime .. 'ms\n   drawtime: ' .. Winter.round(WINTER_FRAMERATE - wtime + 0.5) .. 'ms\n'
		print(debuglog)
	end
end

Audio.clear()
Ruby.kill()
Winter.cleanup()
Render.killWindow()