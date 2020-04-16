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

local bjnamefile = readFile(constants.file_bonjour_name);
io.input(bjnamefile)
local bjname = io.read()
io.close(bjnamefile)

local bjlocationfile = readFile(constants.file_bonjour_location)
io.input(bjlocationfile)
local bjlocation = io.read()
io.close(bjlocationfile)

local bjgeolocationfile = readFile(constants.file_bonjour_geolocation)
io.input(bjgeolocationfile)
local bjgeolocation = io.read("*a")
io.close(bjgeolocationfile)

if bjname == nil then
	bjname = "Bonjour Name"
end
if bjlocation == nil or bjgeolocation == nil then
	bjlocation = ""
	bjgeolocation = "\n\n\n "
end

local result = "{"
result = result..'"bonjourServiceName":"'..bjname..'",'
result = result..'"bonjourServiceNote":"'..bjlocation..'",'
result = result..'"locationLongitude":"'..split(bjgeolocation,"\n")[1]..'",'
result = result..'"locationLatitude":"'..split(bjgeolocation,"\n")[2]..'",'
result = result..'"locationAltitude":"'..split(bjgeolocation,"\n")[3]..'"}'



Result(200,"请求成功",result)
