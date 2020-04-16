#!/usr/bin/env lua

require"cgi-bin/prepare"
require"cgi-bin/fileProcess"
require"cgi-bin/data"
require"cgi-bin/constants"
require"cgi-bin/get"
--don't check cookie for init setup user

local password = getAttribuate(constants.param_password)

local file = readFile(constants.file_webuser)
io.input(file)
local content = io.read()
io.close(file)

if (content == "" or content == nil) and (password ~= nil and password ~= '') then
	local f = io.open(constants.file_webuser,'w')
	local c = 'admin '..password
	io.output(f)
	io.write(c)
	io.close(f)
	Result(200,"success",'"success"')
else
	Result(403,"请求失败",nil)
end
