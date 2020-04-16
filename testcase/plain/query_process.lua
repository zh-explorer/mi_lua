#!/usr/bin/env lua

require"cgi-bin/fileProcess"
require"cgi-bin/data"
require"cgi-bin/constants"
--don't check cookie for ota reboot check upgrade result

local data = readFile(constants.file_upgrade);
io.input(data)
local result = io.read()
io.close(data)

local n = tonumber(result)
if n == nil then
	result = "0"
end

if result ~= nil or result ~= "" then 
	Result(200,"请求成功",result)
else 
	Result(500,"请求失败",nil)

end
