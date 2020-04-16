#!/usr/bin/env lua

require"cgi-bin/prepare"
require"/cgi-bin/file"
require"/cgi-bin/data"
require"/cgi-bin/post"
require"/cgi-bin/cert_invoke"
require"/cgi-bin/get"
require"/cgi-bin/fileProcess"
require"cgi-bin/cookie"

if checkCookie() == false then
	redirectHome()
	return
end

JsonContent()
local content = get_post_data()
local passwd = getAttribuate("passwd")

for i=0,2,1 do
	local start = string.gmatch(content,"([^\n]+)")()
	local content_len = string.len(content)
	local start_len = string.len(start)
	content = string.sub(content, start_len + 3, content_len)
end

local t = string.gmatch(content, "([^\n]+)[\n]*$")()
local t_len = string.len(t)
content = string.sub(content, 2, string.len(content)-t_len-3)


file = io.open('/tmp/uhttpd.p12', 'w')
file:write(content) 
file:close()
print("证书上传成功")
return
-- certInvoke.invokeDepartCert(passwd)

-- if readFile("/tmp/uhttpd.crt") == nil then
-- 	Result(500,"证书解析失败",nil)
-- end	

-- if certInvoke.invokeCheck() == "ok" then
--     certInvoke.invokeCopy()
--     certInvoke.invokeRemove()
--     Result(200,"证书上传成功",nil)
-- else
--     Result(500,"证书上传失败",nil)
-- end


--print(os.getenv("CONTENT_LENGTH"))
--print(content)
