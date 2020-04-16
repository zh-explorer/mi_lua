function readFile(filename)
    local file = io.open(filename,'r')
    if file == nil then
		file = io.open(filename,'a')
	end
    return file;
end

function writeFile(filename,content)
	local file = io.open(filename,'w')
	io.output(file)
	io.write(content)
	io.close()
end