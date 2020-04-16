--@Desc: read all file content and return 
function readFile(filename)
    local file = io.open(filename,'r')
    if file == nil then
		file = io.open(filename,'a')
	end

    local result = "{";
    io.input(file)

    for fileLine in io.lines(filename) do
    	if string.len(fileLine) ~= 0 then  
    		result = result..fileLine..","
    	end
    end
    result = string.sub(result,1,string.len(result) - 1).."}"
 --   print(result)
    io.close(file)
    if string.len(result) < 3 then
    	return nil
    end

    return file;
end


--@Desc: read prop and return 
--@Exception: file is nil or 
function readProperties(filename,prop)
	local file = io.open(filename,'r')
	if file == nil then
		file = io.open(filename,'a')
	end
	local propStr = '';

	for fileLine in file:lines() do
		if string.find(fileLine,prop) ~= nil then
			--numbers 5 and 1 is order to sub prop str
			return string.sub(fileLine,string.len(prop) + 5,string.len(fileLine) - 1)
		end
	end
end

--@Desc: add a line data to file
function addLine(filename,data)
	local file = io.open(filename,'a')
	io.output(file)
	io.write(data)
	io.close()
end

--@Desc: removeLine 
function removeLine(filename,lineNo)
	local file = io.open(filename,'r')
	local content = ""
	local count = 1

	for fileLine in file:lines() do
		if count ~= lineNo then
			count = tonumber(count) + 1
			content = content..fileLine.."\n"
		else
			count = tonumber(count) + 1
		end
	end
	file = io.open(filename,'w')
	io.output(file)
	io.write(content)
	io.close()
end


--@Desc：find param from file，and return line no
function findLineNo(filename,key)
	local file = io.open(filename,'r')
	local count = 0
	if file == nil then
		return 0
	end

	for fileLine in file:lines() do
		if string.find(fileLine,key) ~= nil then
			count = tonumber(count) + 1
			return count
		end
		count = tonumber(count) + 1
	end
	return 0
end

function cleanUpFile(filename)
	local file = io.open(filename,'r')
	local result = ""

    io.input(file)
    for fileLine in io.lines(filename) do
    	if string.len(fileLine) ~= 0 then  
    		result = result..fileLine.."\n"
    	end
    end

    file = io.open(filename,'w')
	io.output(file)
	io.write(result)
	io.close()
end





