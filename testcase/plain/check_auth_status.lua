#!/usr/bin/env lua

require"cgi-bin/prepare"
require"cgi-bin/fileProcess"
require"cgi-bin/data"
require"cgi-bin/constants"
require"cgi-bin/extends"
require"cgi-bin/get"
--don't check cookie for login check

local file = readFile(constants.file_webuser);
io.input(file)
local content = io.read()
io.close()

local first_login = 'false'

if content == "" or content == nil then 
	first_login = 'true'
end

Result(200,"请求成功",'{"first_login":"'..first_login..'"}')

