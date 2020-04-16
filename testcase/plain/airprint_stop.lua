#!/usr/bin/env lua

require"cgi-bin/prepare"
require"cgi-bin/file"
require"cgi-bin/data"
require"cgi-bin/constants"
require"cgi-bin/invoke"
require"cgi-bin/cookie"

if checkCookie() == false then
	redirectHome()
	return
end

invoke.invokeDoStopEquip()
Result(200,"请求成功",nil)
