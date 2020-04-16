#!/usr/bin/env lua

require"cgi-bin/prepare"
require"/cgi-bin/file"
require"/cgi-bin/data"
require"/cgi-bin/post"
require"/cgi-bin/cert_invoke"
require"/cgi-bin/get"
require"/cgi-bin/fileProcess"
require"/cgi-bin/extends"
require"cgi-bin/cookie"

if checkCookie() == false then
	redirectHome()
	return
end

local passwd = getAttribuateFilter("passwd")

certInvoke.invokeDepartCert(passwd)

if readFile("/tmp/uhttpd.crt") == nil then
	Result(500,"请求失败",nil)
end	

if split(certInvoke.invokeCheck(),"\n")[1] == "ok" then
    certInvoke.invokeCopy()
    certInvoke.invokeRemove()
    Result(201,"证书应用成功",nil)
else
    Result(500,"请求失败",nil)
end


--print(os.getenv("CONTENT_LENGTH"))
--print(content)
