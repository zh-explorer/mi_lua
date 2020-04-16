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

local file = readFile(constants.file_cartridge)
io.input(file)
local code = io.read()
if code == nil then 
	code = "3000"
end
io.close()

local color = "ok"
local black = "ok"

if tonumber(code) == 2000 then
	 
elseif tonumber(code) == 2006 then
	black = "defective"
	color = "defective"
elseif tonumber(code) == 2007 then
	black = "absent"
elseif tonumber(code) == 2008 then
	color = "absent"
elseif tonumber(code) == 2009 then
	black = "absent"
	color = "absent"
elseif tonumber(code) == 2010 then
	black = "hign_temp"
elseif tonumber(code) == 2011 then
	color = "hign_temp"
elseif tonumber(code) == 2012 then
	black = "hign_temp"
	color = "hign_temp"
elseif tonumber(code) == 2013 then
	black = "incorrect"
elseif tonumber(code) == 2014 then
	color = "incorrect"
elseif tonumber(code) == 2015 then
	black = "incorrect"
	color = "incorrect"
elseif tonumber(code) == 2019 then
	black = "contact_failure"
	color = "contact_failure"
else 
	black = "unknown"
	color = "unknown"
end	



local  result = "{"
result = result..'"colorCartridge":"'..color..'",' 
result = result..'"BlackCartridge":"'..black..'"}'


Result(200,"请求成功",result)

