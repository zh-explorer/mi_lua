#!/usr/bin/env lua

require"cgi-bin/prepare"
require"cgi-bin/fileProcess"
require"cgi-bin/data"
require"cgi-bin/constants"
require"cgi-bin/cookie"

if checkCookie() == false then
	redirectHome()
	return
end

local file = readFile(constants.file_ink)
io.input(file)
local code = io.read()
if code == nil then 
	code = "3000"
end
io.close()

local black = "full"
local cyan = "full"
local megenta = "full"
local yellow = "full"

if tonumber(code) == 2100 then
	
elseif tonumber(code) == 2101 then
	black = "low"
elseif tonumber(code) == 2102 then
	cyan = "low"
elseif tonumber(code) == 2103 then
	black = "low"
	cyan = "low"
elseif tonumber(code) == 2104 then
	megenta = "low"
elseif tonumber(code) == 2105 then
	black = "low"
	megenta = "low"
elseif tonumber(code) == 2106 then
	cyan = "low"
	megenta = "low"
elseif tonumber(code) == 2107 then
	black = "low"
	cyan = "low"
	megenta = "low"
elseif tonumber(code) == 2108 then
	yellow = "low"
elseif tonumber(code) == 2109 then
	black = "low"
	yellow = "low"
elseif tonumber(code) == 2110 then
	cyan = "low"
	yellow = "low"
elseif tonumber(code) == 2111 then
	black = "low"
	cyan = "low"
	yellow = "low"
elseif tonumber(code) == 2112 then
	megenta = "low"
	yellow = "low"
elseif tonumber(code) == 2113 then
	black = "low"
	megenta = "low"
	yellow = "low"
elseif tonumber(code) == 2114 then
	cyan = "low"
	megenta = "low"
	yellow = "low"
elseif tonumber(code) == 2115 then
	black = "low"
	cyan = "low"
	megenta = "low"
	yellow = "low"
else 
	black = "unknown"
	cyan = "unknown"
	megenta = "unknown"
	yellow = "unknown"
end	



local  result = "{"
result = result..'"cyan":"'..cyan..'",'
result = result..'"pinkish":"'..megenta..'",'
result = result..'"yellow":"'..yellow..'",'
result = result..'"black":"'..black..'"}'

Result(200,"请求成功",result)










