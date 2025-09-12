plushiesolid = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/plushiesolid.png')
walls = Plush.loadPNG(Winter.getPath() .. '../Resources/package/tiles/bricks1.png')
Plush.insertReflection(plushiesolid, walls)
success = Plush.savePlushImage(plushiesolid, Winter.getPath() .. '../Resources/package/test.pmg')
if (success) then
	print('wrote image data to: ' .. Winter.getPath() .. '../Resources/package/test.pmg')
end
Plush.killImage(plushiesolid)
plushiesolid = Plush.loadPlushImage(Winter.getPath() .. '../Resources/package/test.pmg')
success = Plush.saveImage(plushiesolid, Winter.getPath() .. '../Resources/package/test.png')
if (success) then
	print('wrote image data to: ' .. Winter.getPath() .. '../Resources/package/test.png')
end