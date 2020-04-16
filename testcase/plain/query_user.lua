#!/usr/bin/env lua

require"cgi-bin/prepare"
require"cgi-bin/fileProcess"
require"cgi-bin/data"
require"cgi-bin/constants"
require"cgi-bin/extends"
require"cgi-bin/cookie"

if checkCookie() == false then
	redirectHome()
	return
end

-- local file = io.open(constants.file_print_user,"r")
-- local result = "["


-- for fileLine in io.lines(constants.file_print_user) do
-- 	if string.len(fileLine) ~= 0 then  
-- 		for i,v in ipairs(split(fileLine,'')) do
-- 			if i == 1 then 
-- 				result = result..'{"username":"'..v..'",'
-- 			end
-- 			if i == 2 then
-- 				result = result..'"password":"'..v..'"},'
-- 			end
-- 			-- if i ==3 then
-- 			-- 	result = result..'"privilage":"'..v..'"},'
-- 			-- end
-- 		end
-- 	end
-- end
-- result = string.sub(result,1,string.len(result) - 1).."]"

local file = readFile(constants.file_print_user);
local result = "[";
io.input(file)

local content = io.read("*a")
if content == "" or content == nil then 
	io.close(file)
	Result(500,"无数据",nil)
	return
end
param = split(content,"\n")

for i,v in ipairs(param) do
	if split(v," ")[1] ~= nil then
		result = result..'{"name":"'..split(v," ")[1]..'",'
		result = result..'"password":"'..split(v," ")[2]..'"},'
	-- result = result..'{"username":"'..v..'",'
	end
end
result = string.sub(result,1,string.len(result) - 1).."]"

io.close(file)


if string.len(result) > 2 then 
	Result(200,"请求成功",result)
else
	Result(500,"无数据",nil)
end



