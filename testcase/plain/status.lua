#!/usr/bin/env lua

require"cgi-bin/prepare"
require"cgi-bin/file"
require"cgi-bin/data"
require"cgi-bin/constants"
require"cgi-bin/invoke"
require"cgi-bin/extends"
require"cgi-bin/cookie"

if checkCookie() == false then
	redirectHome()
	return
end

local result = invoke.invokeQuerySysStatus()
--result = "runn0ing \n"
result = split(result,"\n")[1]
if result == nil then
	Result(200,"请求成功1",'"关闭"')
	return 
end

if string.find(result,"running") ~= nil then
	Result(200,"请求成功",'"打开"')
else
	Result(200,"请求成功",'"关闭"')
end
