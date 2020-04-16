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
local password = getAttribuate(constants.param_password)
local privilege = getAttribuateFilter(constants.param_privilege)

local data = name..' '..password..' '..privilege..'\n'
local lineNo = findLineNo(constants.file_print_user,name)

if lineNo > 0 then
	removeLine(constants.file_print_user,lineNo)
	addLine(constants.file_print_user,data)
	cleanUpFile(constants.file_print_user)
	Result(200,"更新成功",nil)
else
	addLine(constants.file_print_user,data);
	Result(200,"请求成功",nil)
end
