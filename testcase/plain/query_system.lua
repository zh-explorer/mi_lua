#!/usr/bin/env lua

require"cgi-bin/prepare"
require"cgi-bin/fileProcess"
require"cgi-bin/data"
require"cgi-bin/constants"
require"cgi-bin/extends"
require"cgi-bin/invoke"
--don't check cookie for ota reboot check upgrade result

local localVersion = invoke.invokeQueryCurrentVersion();
local serverVersion = invoke.invokeQueryServerVersion();
local time = invoke.invokeUpgradeTime()
--local time = "Change: 2018-08-23 19:50:34.000000000 \n"
time = split(time,"\n")[1]
lVersion = split(localVersion,"\n")[1]
sVersion = split(serverVersion,"\n")[1]

if lVersion == "" or lVersion == nil then
        lVersion = "unknownVersion1"
end

if sVersion == "" or sVersion == nil then
        sVersion = "unknownVersion"
end

lVersion = string.match(lVersion,"%d+.%d+.%d+")
sVersion = string.match(sVersion,"%d+.%d+.%d+")
url = split(serverVersion,"\n")[2]
if url == nil then 
	url = ""
end

if lVersion == "" or lVersion == nil then 
	lVersion = "unknownVersion1"	
end

if sVersion == "" or sVersion == nil then
	sVersion = "unknownVersion"
end

local result = '{"version":"'..lVersion..'"'
result = result..',"new_version":"'..sVersion..'"'
result = result..',"upgradeUrl":"'..url..'"'
result = result..',"build_date":"'..string.sub(time,9,string.len(time) - 10)..'"}'

Result(200,"请求成功",result)
