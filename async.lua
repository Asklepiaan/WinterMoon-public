print("Starting Ruby VM:", Ruby.startup())
Ruby.runScript("$incrementing = true")

Ruby.runAsync([[
	$count = 0
	while $incrementing do
		$count += 1
		Kernel.yield()
		Kernel.sleep(0.1)
	end
]])
print("Started asynchronous increment task")

print("Waiting 5 seconds...")
Winter.sleep(5000)

Ruby.runScript("$incrementing = false")
Ruby.clearAsync()
print("Stopped addition task")
current = Ruby.getGlobal("count")
print("Current value:", current)

Ruby.runScript("$multiplying = true")
Ruby.runScript("$multiplier = $count.to_f")
Ruby.runAsync([[
	while $multiplying do
		$multiplier *= (0.8 + (rand * 0.7))
		Kernel.yield()
		Kernel.sleep(0.1)
	end
]])
print("Started multiplication task")

print("Waiting 5 seconds for multiplication...")
for i = 1, 5 do
	Winter.sleep(1000)
	mult = Ruby.getGlobal("multiplier")
	print("Multiplier at step "..i..":", mult)
end

Ruby.runScript("$multiplying = false")
final = Ruby.getGlobal("multiplier")
print("Final multiplied value:", final)
print("Multiplier and count:", final, Ruby.getGlobal("count"))
Ruby.kill()