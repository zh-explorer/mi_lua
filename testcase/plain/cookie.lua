#!/usr/bin/env lua
require"cgi-bin/extends"
require"cgi-bin/http"

local cookiefile = '/tmp/tmp/cookie'

local function readFile(filePath,size)
	local f = assert(io.open(filePath, "rb"))
	local content = f:read(size)
	f:close()
	return content
end

local function bytesToHexStr(filePath,size)
	local content = readFile(filePath,size)
	local result = ""
	local len = string.len(content)
	for i = 1, len do
		local charcode = tonumber(string.byte(content, i, i))
		local hexstr = string.format("%02x", charcode)
		result = result .. hexstr
	end
	return result
end

function randomLetter(len)
    local rt = bytesToHexStr('/dev/urandom',len)
    return rt
end


function clearCookie()
    os.execute('rm '..cookiefile)
end

function setCookie()
    clearCookie()
    local key=randomLetter(32)
    os.execute('echo -n '..key..' > '..cookiefile)
	io.write("Set-Cookie: key="..key..";path=/\n")
end

function file_exists(path)
    local file = io.open(path, "r")
    if file then file:close() end
    return file ~= nil
end

function getCookieContent(path)
	local f = io.open(path,'r')
	local content = f:read('*all')
	f:close()
	return content
end

function getCookie(name)
	local source = os.getenv("HTTP_COOKIE")
	if source == nil then
		return nil
	end

	source = urlDecode(source)
	source = urlDecode(source)
	
	if source == nil then
		return nil
	end

	local tableSource = split(source,';')
	for i=1,#tableSource do
		-- print(tableSource[i])
		local param = split(tableSource[i],'=')
		if param[1] == name then
			return param[2]
		end
    end
    return nil
end

function checkCookie()
    local ck=getCookie('key')
    if ck == nil then
        return false
	end

	if string.len(ck) ~= 32*2 then
        return false
	end

	local isSet=file_exists(cookiefile)
	if isSet == false then
		return false
	end

	local content = getCookieContent(cookiefile)

	if ck == content then
		return true
	end

    return false
end

function redirectHome()
    print("content-type: text/html;charset=UTF-8\n")

    print([==[
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="refresh" content="0;url=/">
</head>
<body>
</body>
</html>]==])
end