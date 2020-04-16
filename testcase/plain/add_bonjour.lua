#!/usr/bin/env lua

require"cgi-bin/prepare"
require"cgi-bin/fileProcess"
require"cgi-bin/data"
require"cgi-bin/constants"
require"cgi-bin/extends"
require"cgi-bin/get"
require"cgi-bin/invoke"
require"cgi-bin/cookie"

if checkCookie() == false then
	redirectHome()
	return
end

local bonjourName = getAttribuateFilter(constants.param_bonjour_service_name)
local bonjourNote = getAttribuateFilter(constants.param_bonjour_service_note)
local locationLongitude = getAttribuateFilter(constants.param_bonjour_geo_location_longitude)
local locationLatitude = getAttribuateFilter(constants.param_bonjour_geo_location_latitude)
local locationAltitude = getAttribuateFilter(constants.param_bonjour_geo_location_altitude)


if bonjourName == nil or bonjourName == '' then
	Result(400,"参数有误",nil)
	return
end

--print(bonjourName.."---"..bonjourNote..locationLongitude..locationLatitude..locationAltitude)
writeFile(constants.file_bonjour_name,bonjourName)
writeFile(constants.file_bonjour_location,bonjourNote)
writeFile(constants.file_bonjour_geolocation,locationLongitude.."\n"..locationLatitude.."\n"..locationAltitude)

invoke.invokeDoRestartEquip()

Result(200,"请求成功",nil)
