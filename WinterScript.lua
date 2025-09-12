file = io.open(Winter.getPath() .. '../Resources/script/bench.ws', 'r')
print("bench.ws")
Winter.runScript(file:read('*a'))
Winter.runScript('print(cycles)')

Winter.runScript('randomNumber = random(100000) / random(30)')
print(Winter.getVar('randomNumber'))
Winter.setVar('randomNumber', 69, WINTER_INT)
print(Winter.getVar('randomNumber'))
Winter.setVar('randomNumber', 69.8, WINTER_FLOAT)
print(Winter.getVar('randomNumber'))

file:close()