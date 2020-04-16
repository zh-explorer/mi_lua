#!/usr/bin/env lua

require"cgi-bin/prepare"
require"cgi-bin/fileProcess"
require"cgi-bin/data"
require"cgi-bin/constants"
require"cgi-bin/extends"
require"cgi-bin/invoke"
--don't check cookie for ota reboot check upgrade result

local serverVersion = invoke.invokeQueryServerVersion();

sVersion = split(serverVersion,"\n")[1]

if sVersion == "" or sVersion == nil then
        sVersion = "unknownVersion"
end


sVersion = string.match(sVersion,"%d+.%d+.%d+")


if sVersion == "" or sVersion == nil then
	sVersion = "unknownVersion"
end

local result = '{"new_version":"'..sVersion..'"}'

Result(200,"请求成功",result)
