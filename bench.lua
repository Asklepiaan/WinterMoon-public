startTime = os.clock() + 5
cycles = 0
while os.clock() < startTime do
	a, b = math.random(10000), math.random(10000)
	sum = a + b
	diff = a - b
	product = a * b
	if b ~= 0 then
		quotient = a / b
	end
	a, b = math.random(10000), math.random(10000)
	oa = a
	sa = a .. '.' .. b
	a = tonumber(sa)
	sb = b .. '.' .. oa
	b = tonumber(sb)
	sum = a + b
	diff = a - b
	product = a * b
	if b ~= 0 then
		quotient = a / b
	end
	cycles = cycles + 1
end
print('benchmark finished\nscore: ' .. cycles)