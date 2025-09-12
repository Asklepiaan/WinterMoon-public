print("Starting Ruby VM:", Ruby.startup())
Ruby.setRounding(true, 2)
coolnumber = 69
multinumber = 1.0
print(Ruby.runScript([[
	lua_value = lua_var("coolnumber")
	puts(lua_value)
	set_lua_var("coolnumber", 420)

	$multiplying = true
	$multiplier = ]] .. multinumber), coolnumber)
Ruby.runAsync([[
	while $multiplying do
		$multiplier = 20 * (0.8 + (rand * 0.7))
		set_lua_var("multinumber", $multiplier)
	end
]])
for i = 1, 10 do
	print("Check:", multinumber)
	Winter.sleep(1000)
end
Ruby.kill()