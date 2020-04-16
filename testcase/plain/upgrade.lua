#!/usr/bin/env lua

require"cgi-bin/prepare"
require"cgi-bin/data"
require"cgi-bin/constants"
-- require"cgi-bin/get"
require"cgi-bin/invoke"
require"cgi-bin/cookie"

if checkCookie() == false then
	redirectHome()
	return
end

local serverVersion = invoke.invokeQueryServerVersion()
url = split(serverVersion,"\n")[2]
if url == nil or url == ""  then 
	Result(400,"请求升级失败",nil)
	return
end
local result=invoke.invokeDoSysUpgrade(url)
if string.find(result,'"result":"OK"') ~= nil then
	Result(200,"请求升级成功",nil)
else
	Result(200,"请求升级失败",nil)
end

-- local upgradeUrl = getAttribuateFilter(constants.param_upgradeUrl)

-- if upgradeUrl == nil or upgradeUrl == ""  then 
-- 	Result(400,"参数不存在",nil)
-- else
-- 	local result=invoke.invokeDoSysUpgrade(upgradeUrl)
-- 	if string.find(result,'"result":"OK"') ~= nil then
-- 		Result(200,"请求升级成功",nil)
-- 	else
-- 		Result(200,"请求升级失败",nil)
-- 	end
-- end
