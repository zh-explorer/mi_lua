#!/usr/bin/env lua

require"cgi-bin/prepare"
require"cgi-bin/fileProcess"
require"cgi-bin/data"
require"cgi-bin/constants"
require"cgi-bin/extends"
require"cgi-bin/get"
require"cgi-bin/cookie"


local name = getAttribuateFilter(constants.param_name);
--no need filter password
local password = getAttribuate(constants.param_password)

local file = readFile(constants.file_webuser);
io.input(file)
local content = io.read()
--[[
if content == "" or content == nil then 
	if name == "admin" and password == "123456" then
		local output = io.open(constants.file_webuser,"w")
		io.output(output)
		io.write("admin 123456")
		io.close(output)
--		Result(200,"认证成功",'{"user":{"username":"'..name..'","password":"'..password..'"}}')	
		Result(200,"认证成功",'{"user":{"username":"'..name..'"}}')
		return
	else
		Result(500,"认证失败",nil)
		return 
	end
end
--]]
param = split(content," ")
local sys_name = param[1]
local sys_password = param[2]
io.close()

if name == sys_name and password == sys_password then
--	Result(200,"认证成功",'{"user":{"username":"'..sys_name..'","password":"'..sys_password..'"}}')
	setCookie()
	Result(200,"认证成功",'{"user":{"username":"'..sys_name..'"}}')
else
	Result(500,"认证失败",nil)
end	
