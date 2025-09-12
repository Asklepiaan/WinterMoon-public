title = WINTER_NAME + " v"
title = title + toString(WINTER_VERSION)
title = title + ":"
title = title + WINTER_RELEASE
title = title + " by "
title = title + WINTER_AUTHOR
print(title)
@@test start
print("testing testing")
print("setup var value =", testvar)

if testvar < 10
	print("testvar is under 10")
else
	print("testvar is over 10")
end

print(testvar)

counter = 0
while counter < 3
	print("while loop")
	counter = counter + 1
end

repeat
	print("repeat loop")
	counter = counter + 1
until counter > 5

result = add(5, 3)
print("5 + 3 =", result)

@@benchmark code
startTime = getTimeMs()
startTime = startTime + 5000
cycles = 0
while getTimeMs() < startTime
	a = random(10000)
	b = random(10000)
	sum = a + b
	diff = a - b
	product = a * b
	if b ~= 0
		quotient = a / b
	end
	a = random(10000)
	b = random(10000)
	oa = a
	sa = a + "." + b
	a = toNumber(sa)
	sb = b + "." + oa
	b = toNumber(sb)
	sum = a + b
	diff = a - b
	product = a * b
	if b ~= 0
		quotient = a / b
	end
	cycles = cycles + 1
end