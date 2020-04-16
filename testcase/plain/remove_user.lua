#!/usr/bin/env lua

require"cgi-bin/prepare"
require"cgi-bin/file"
require"cgi-bin/data"
require"cgi-bin/constants"
require"cgi-bin/get"
require"cgi-bin/cookie"

if checkCookie() == false then
	redirectHome()
	return
end

local name = getAttribuateFilter(constants.param_name)
-- local name = "suyuanbo,lisi,zhangsan"
local names = split(name,",")


if #names > 0 then
	for i,v in ipairs(names) do
		local lineNo = findLineNo(constants.file_print_user,v) 
		removeLine(constants.file_print_user,tonumber(lineNo))
	end
end

Result(200,"请求成功",nil)

