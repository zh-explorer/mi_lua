#!/usr/bin/env lua

require"cgi-bin/prepare"
require"/cgi-bin/file"
require"/cgi-bin/data"
require"/cgi-bin/post"
require"/cgi-bin/cert_invoke"
require"/cgi-bin/extends"
require"cgi-bin/cookie"

if checkCookie() == false then
	redirectHome()
	return
end

JsonContent()
local content = get_post_data()

--local file = io.open('ca.key', "r+")
--local content = file:read("*all")

for i=0,2,1 do
	local start = string.gmatch(content,"([^\n]+)")()
	local content_len = string.len(content)
	local start_len = string.len(start)
	content = string.sub(content, start_len + 3, content_len)
end

local t = string.gmatch(content, "([^\n]+)[\n]*$")()
local t_len = string.len(t)
content = string.sub(content, 2, string.len(content)-t_len-3)


file = io.open('/tmp/uhttpd.crt', 'w')
file:write(content) 
file:close()

if split(certInvoke.invokeCheckLocal(),"\n")[1] == "ok" then
       certInvoke.invokeCopy()
        certInvoke.invokeRemove()
	print("证书上传成功")
	return 
--        Result(201,"证书上传成功",nil)
else
	print("请求失败")
	return
--        Result(500,"请求失败",nil)
end


--print(os.getenv("CONTENT_LENGTH"))
--print(content)
