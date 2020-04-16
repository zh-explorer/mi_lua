#!/usr/bin/env lua

require"cgi-bin/prepare"
require"cgi-bin/fileProcess"
require"cgi-bin/data"
require"cgi-bin/constants"
require"cgi-bin/get"
require"cgi-bin/cookie"

if checkCookie() == false then
	redirectHome()
	return
end

local password = getAttribuate(constants.param_password)
local repeat_password = getAttribuate(constants.param_repassword)
local oldpassword = getAttribuate(constants.param_oldpassword)
local file = readFile(constants.file_webuser)
io.input(file)
local content = io.read()
local param = split(content," ")
io.close(file)

if oldpassword ~= param[2] then 
	Result(403,"请求失败",nil)
elseif password ~= repeat_password then
	Result(406,"两次输入密码不一致",nil)
else
	local f = io.open(constants.file_webuser,'w')
	local c = 'admin '..password
	io.output(f)
	io.write(c)
	io.close(f)
	Result(200,"success",'"success"')

end
