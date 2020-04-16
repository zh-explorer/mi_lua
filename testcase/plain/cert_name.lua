#!/usr/bin/env lua

require"cgi-bin/prepare"
require"cgi-bin/data"
require"cgi-bin/extends"
require"cgi-bin/cookie"

if checkCookie() == false then
	redirectHome()
	return
end

local order = "hostname"
local t = io.popen(order)
local a = t:read("*all")

Result(200,"请求成功",'"'..split(a,"\n")[1]..'"')
