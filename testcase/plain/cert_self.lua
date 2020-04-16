#!/usr/bin/env lua

require"cgi-bin/prepare"
require"cgi-bin/file"
require"cgi-bin/data"
require"cgi-bin/constants"
require"cgi-bin/get"
require"cgi-bin/cert_invoke"
require"cgi-bin/extends"
require"cgi-bin/cookie"

if checkCookie() == false then
	redirectHome()
	return
end

local countryName = getAttribuateFilter(constants.param_country_name)
local provienceName = getAttribuateFilter(constants.param_provience_name)
local localityName = getAttribuateFilter(constants.param_locality_name)
local organizationName = getAttribuateFilter(constants.param_organization_name)
local unitName = getAttribuateFilter(constants.param_organization_unit_name)
local commonName = getAttribuateFilter(constants.param_common_name)
local emailName = getAttribuateFilter(constants.param_email_name)
local valueSha = getAttribuateFilter("valueSHA")
--local commonName = 'a'
-- /C=Country 國別
-- /ST=State 州
-- /L=Location 地區
-- /O=Organization 組織
-- /OU=Organizational Unit 組織部門單位
-- /CN=Common Name 網域名稱
--openssl req -sha512 -new -out output.csr -subj "/C=TW/ST=Taipei/L=Taipei/O=example/OU=Personal/CN=www.example.com";


local subj = "/C="..countryName.."/ST="..provienceName.."/L="..localityName.."/O="..organizationName.."/OU="..unitName.."/CN="..commonName

--local generalprikeyorder = 'openssl req -newkey rsa:2048 -nodes -keyout /etc/uhttpd.key -x509 -days 3650 -out /etc/uhttpd.crt -subj "'..subj..'"'
local generalprikeyorder = "selfCertAndKey  /tmp/uhttpd.crt /tmp/uhttpd.key null 3650 '"..subj.."' 2048 '"..valueSha.."'"
--print(generalprikeyorder)

local generalprikey = io.popen(generalprikeyorder);
local content = generalprikey:read("*a")
generalprikey:close()
--print(certInvoke.invokeCheck())

if split(certInvoke.invokeCheck(),"\n")[1] == "ok" then
	certInvoke.invokeCopy()
	certInvoke.invokeRemove()
	Result(200,"生成成功",result)
else
	Result(500,"证书生成失败",nil)
end
