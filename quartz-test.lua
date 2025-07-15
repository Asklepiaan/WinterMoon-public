function Winter.round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

Metal.spawnWindow(WINTER_SCREEN_X, WINTER_SCREEN_Y, '<game name> | WinterMoon Engine ' .. WINTER_ENGINE_VERSION .. ' | ' .. WINTER_ENGINE_POSTFIX)
framecolour = {255, 0, 255}
drawFrame = true
debugger = true
frames = 0

image, y, x = Metal.loadPNG('/Users/plushie/Desktop/Screenshot 2025-07-07 at 3.23.08 PM.png')

while not Metal.checkClose() do
	wtime = Winter.getClock()
	if (debugger == true) then
		debuglog = 'LOG: ' .. WINTER_PROCESSOR_NAME .. ':' .. WINTER_OS_PLATFORM .. ':' .. WINTER_OS_VERSION .. '\n'
		debugentries = 0
	end
	Metal.updateInput()

	Metal.renderImage(image)
	if (debugger == true) then
		Metal.setTitle(frames .. ' frames passed, x: ' .. WINTER_MOUSE_X .. ', y: ' .. WINTER_MOUSE_Y)
		debugentries = debugentries + 1
		debuglog = debuglog .. debugentries .. ': window name: ' .. Metal.getTitle() .. '\n'
	end

	if (WINTER_KEY_RETURN == true) then
		window = Metal.getWindow()
		Metal.saveImage('/Users/plushie/Desktop/test.png', window)
	end

	if (drawFrame) then
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