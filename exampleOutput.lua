frames[2][8]; //declare at top of code
void setupFun() { //run this at the start
	frames[0][0] = B00000000;
	frames[0][1] = B00000000;
	frames[0][2] = B00010000;
	frames[0][3] = B00011000;
	frames[0][4] = B00000000;
	frames[0][5] = B00010000;
	frames[0][6] = B00000000;
	frames[0][7] = B00000000;
	frames[1][0] = B00000000;
	frames[1][1] = B00000100;
	frames[1][2] = B00010000;
	frames[1][3] = B00111000;
	frames[1][4] = B00000100;
	frames[1][5] = B00010000;
	frames[1][6] = B00000000;
	frames[1][7] = B00000000;
}
--here is the lua version:
frames = {}
function setupTable()
	for x=1,2,1 do
		table.insert(frames,{})
		for y=1,8,1 do
			table.insert(frames[x],0)
		end
	end
	frames[1][1] = {0,0,0,0,0,0,0,0}
	frames[1][2] = {0,0,0,0,0,0,0,0}
	frames[1][3] = {0,0,0,1,0,0,0,0}
	frames[1][4] = {0,0,0,1,1,0,0,0}
	frames[1][5] = {0,0,0,0,0,0,0,0}
	frames[1][6] = {0,0,0,1,0,0,0,0}
	frames[1][7] = {0,0,0,0,0,0,0,0}
	frames[1][8] = {0,0,0,0,0,0,0,0}
	frames[2][1] = {0,0,0,0,0,0,0,0}
	frames[2][2] = {0,0,0,0,0,1,0,0}
	frames[2][3] = {0,0,0,1,0,0,0,0}
	frames[2][4] = {0,0,1,1,1,0,0,0}
	frames[2][5] = {0,0,0,0,0,1,0,0}
	frames[2][6] = {0,0,0,1,0,0,0,0}
	frames[2][7] = {0,0,0,0,0,0,0,0}
	frames[2][8] = {0,0,0,0,0,0,0,0}
end