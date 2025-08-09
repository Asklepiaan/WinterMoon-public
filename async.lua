print("Starting Ruby VM:", Ruby.startup())
Ruby.runScript("$incrementing = true")

Ruby.runAsync([[
	$count = 0
	while $incrementing do
		$count += 1
		sleep(0.1)
	end
]])
print("Started asynchronous increment task")

print("Waiting 5 seconds...")
Winter.sleep(5000)

Ruby.runScript("$incrementing = false")
Ruby.clearAsync()
print("Stopped addition task")
current = Ruby.runScript("puts $count.to_s")
print("Current value:", current)

Ruby.runScript("$multiplying = true")
Ruby.runScript("$multiplier = $count.to_f")
Ruby.runAsync([[
	while $multiplying do
		$multiplier *= (0.8 + (rand * 0.7))
		sleep(0.1)
	end
]])
print("Started multiplication task")

print("Waiting 5 seconds for multiplication...")
for i = 1, 5 do
	print(Ruby.runScript('puts calcHeight($multiplier)'))
	Winter.sleep(1000)
end

Ruby.runScript("$multiplying = false")
final = Ruby.runScript("puts $multiplier.to_s")
print("Final multiplied value:", final)
print(Ruby.runScript("puts $multiplier.to_s"), Ruby.runScript("puts $count.to_s"))
Ruby.kill()