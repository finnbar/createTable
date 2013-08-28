tiles = {}
ref = 0
awesome = false
luastring = ""

--require("levels")

function love.load()
	love.filesystem.write("levels.lua","",all)
	for x=1,8,1 do
		table.insert(tiles,{})
		for y=1,8,1 do
			table.insert(tiles[x],false)
		end
	end
end

function love.draw()
	love.graphics.print("left click to place",1,400)
	love.graphics.print("right click to remove",1,415)
	love.graphics.print("s to save (to AppData (Windows 7+) /Application Support (Mac)",1,430)
	love.graphics.print("/.local (Linux) / Application Data (Win XP)",1,445)
	love.graphics.print("c to clear",1,460)
	love.graphics.print("each time you save, the current pattern is added to frames[][]",1,475)
	love.graphics.print("the program will output a C/Java (Arduino and other C variants",1,490)
	love.graphics.print("as well) array, and a Lua/Ruby array.",1,505)
	for x=1,8,1 do
		for y=1,8,1 do
			if tiles[x][y] == true then
				love.graphics.rectangle("fill",(x-1)*50,(y-1)*50,50,50)
			end
		end
	end
	local xPos = math.ceil(love.mouse.getX()/50)
	local yPos = math.ceil(love.mouse.getY()/50)
	if xPos < 9 and xPos > 0 and yPos < 9 and yPos > 0 then
		love.graphics.setColor(255,255,255)
		if tiles[xPos][yPos] == true then
			love.graphics.setColor(0,0,0)
		end
		love.graphics.rectangle("line",(xPos-1)*50,(yPos-1)*50,50,50)
		love.graphics.setColor(255,255,255)
	end
end

function love.mousepressed(x, y, button)
	local xPos = math.ceil(x/50)
	local yPos = math.ceil(y/50)
	if xPos < 9 and xPos > 0 and yPos < 9 and yPos > 0 then
		if button == "l" then
			tiles[xPos][yPos] = true
		elseif button == "r" then
			tiles[xPos][yPos] = false
		end
	end
end

function love.keypressed(key, unicode)
	if key == "s" then
		awesome = true
		string = love.filesystem.read("levels.lua",all)
		for y=1,8,1 do
			string = string .. "\tframes[" .. ref .. "][" .. (y-1) .. "] = B" --minus 1 as it's designed for C programs
			luastring = luastring .. "\tframes[" .. (ref+1) .. "][" .. y .. "] = {"
			for x=1,8,1 do
				if tiles[x][y] then
					string = string .. 1
					luastring = luastring .. 1
				else
					string = string .. 0
					luastring = luastring .. 0
				end
				if x < 8 then
					luastring = luastring .. ","
				end
			end
			string = string .. ";\n\r"
			luastring = luastring .. "}\n\r"
		end
		string = string.format(string)
		love.filesystem.write("levels.lua",string,all)
		ref=ref+1
	elseif key == "c" then
		for x=1,8,1 do
			for y=1,8,1 do
				tiles[x][y] = false
			end
		end
	end
end

function love.quit()
	if awesome then
		if string ~= nil then
			string = "frames[" .. ref .. "][8]; //declare at top of code\nvoid setupFun() { //run this at the start\n" .. string .. "}" .. "\n--here is the lua version:\nframes = {}\nfunction setupTable()\n\tfor x=1," .. ref .. ",1 do\n\t\ttable.insert(frames,{})\n\t\tfor y=1,8,1 do\n\t\t\ttable.insert(frames[x],0)\n\t\tend\n\tend\n" .. luastring .. "end"
			--close array, give length
			love.filesystem.write("levels.lua",string,all)
		end
	end
end