#!/usr/bin/env lua

require"cgi-bin/prepare"
require"cgi-bin/data"
require"cgi-bin/constants"
require"cgi-bin/cert_invoke"
require"cgi-bin/extends"
require"cgi-bin/cookie"

if checkCookie() == false then
	redirectHome()
	return
end

local certFile = io.open("/etc/uhttpd.crt","r")

if certFile == nil then 
	Result(500,"请求成功",nil)
end

local version = certInvoke.invokeVersion()
local serial = certInvoke.invokeSerial()
local issuser = certInvoke.invokeIssuedorg()
local dates = certInvoke.invokeIssueddate()
local expireDate = certInvoke.invokeExpiredate()
local subject = certInvoke.invokeSubject()
local pubKey = certInvoke.invokePublickey()
local signal = certInvoke.invokeSignal()
local date=os.date("%Y-%m-%d %H:%M:%S");

-- local version = "        Version: 3 (0x2)"
-- local serial = "serial=D659E71916106F9D"
-- local issuer = "issuer= /C=aa/ST=ss/L=sss/O=sssss/OU=ssss/CN=ssss/emailAddress=ssss"
-- local dates = "notBefore=Aug 19 12:15:59 2018 GMT\n"..
-- "notAfter=Aug 19 12:15:59 2019 GMT"
-- local expireData = certInvoke.invokeExpiredate()
-- local subject = "subject= /C=aa/ST=ss/L=sss/O=sssss/OU=ssss/CN=ssss/emailAddress=ssss"
-- local pubKey = "-----BEGIN PUBLIC KEY-----
-- MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmsam/Zt+mQlVmFu/lsME
-- 6zJ5rL9eyllBQoTWRFC4Quo1BBCkFvCCoGguqqVv4C5jVUcyH8TabYuPvk+5p+Xu
-- /ivlcZbV8sW+/3bxW07B66/oGwLhoqmhC1x1V2mmcHZbmAOUtk0YYFsSHGyIz9LT
-- e2JiSYRmdFayz1AK8jlM/Hwi5+H7LSBG/hJZXHZjcFn6tRxnfCztugWx2HLHtRcG
-- VYI2gd6BIYLss1lroKNsJU1/Iir1wN02keQ9hkE0IIfVmSuP3jXwesSMX2h2kHgT
-- waWSmep4m7hMKcC18buReZ0ErzoBeqsJ7/rUoFvzgkCOcC1aGMfTkvCpcVfGGFJm
-- gQIDAQAB
-- -----END PUBLIC KEY-----
-- "
-- local signal = "    Signature Algorithm: sha256WithRSAEncryption\n"..
-- "    Signature Algorithm: sha256WithRSAEncryption"

version = split(string.sub(version,18,string.len(version)),"\n")[1]
serial = split(string.sub(serial,string.find(serial,"=") + 1,string.len(serial)),"\n")[1]
issuser = split(string.sub(issuser,string.find(issuser,"=") + 3,string.len(issuser)),"\n")[1]
issuser = string.gsub(issuser,"\/",",")
issuser = string.gsub(issuser,"\\x","%%")
issuser = urlDecode(issuser)
dates = split(string.sub(split(dates,"\n")[1],string.find(split(dates,"\n")[1],"=") + 1,string.len(split(dates,"\n")[1])),"\n")[1]
expireDate = split(string.sub(split(expireDate,"\n")[2],string.find(split(expireDate,"\n")[2],"=") + 1,string.len(split(expireDate,"\n")[2])),"\n")[1]
subject = split(string.sub(subject,string.find(subject,"=") + 3,string.len(subject)),"\n")[1]
subject = string.gsub(subject,"\/",",")
subject = string.gsub(subject,"\\x","%%")
subject = urlDecode(subject)
pubKey = string.gsub(pubKey, "\n", "") 
pubKey = string.sub(pubKey,27,string.len(pubKey) - 24 )
signal = split(string.sub(signal,string.find(signal,":") + 1,string.find(signal,"\n")),"\n")[1]

local result = "{"
result = result..'"version:":"'..version..'",' 
result = result..'"serial:":"'..serial..'",' 
result = result..'"issuser:":"'..issuser..'",' 
result = result..'"dates:":"'..dates..'",' 
result = result..'"expireDate:":"'..expireDate..'",' 
result = result..'"subject:":"'..subject..'",' 
result = result..'"pubKey:":"'..pubKey..'",' 
result = result..'"signal:":"'..signal..'",'
result = result..'"date":"'..date..'"}' 

Result(200,"请求成功",result)
