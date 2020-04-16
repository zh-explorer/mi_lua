certInvoke = {}

function certInvoke.invokeDepartCert(password)
    local order = "unpackp12 /tmp/uhttpd.p12 /tmp/uhttpd.crt /tmp/uhttpd.key ".."null '"..password.."'"
    return invokeShell(order)
end

function certInvoke.invokeCheck()
    local order = "checkCertAndKey  /tmp/uhttpd.crt /tmp/uhttpd.key"
    return invokeShell(order)
end

function certInvoke.invokeCheckLocal()
    local order = "checkCertAndKey  /tmp/uhttpd.crt /etc/uhttpd.key"
    return invokeShell(order)
end

function certInvoke.invokeCheckCSR()
    local order = "checkCSRAndKey  /tmp/uhttpd.csr /etc/uhttpd.key"
    return invokeShell(order)
end

function certInvoke.invokeRemove()
    local order = "rm -rf  /tmp/uhttpd.*"
    return invokeShell(order)
end

function certInvoke.invokeCopy()
    local order = "cp -f /tmp/uhttpd.* /etc/; sync"
    invokeShell(order)
end

function certInvoke.invokeCopyCSR()
    local order = "cp -f /tmp/uhttpd.csr /www/ca.csr; sync"
    invokeShell(order)
end

function certInvoke.invokeVersion()
    local version = "openssl x509 -noout -text -in /etc/uhttpd.crt |grep Version| grep -v grep"
    return invokeShell(version)
end

function certInvoke.invokeSerial()
    local serial = "openssl x509 -in /etc/uhttpd.crt -noout -serial"
    return invokeShell(serial)
end

function certInvoke.invokeIssuedorg()
    local issuedorg = "openssl x509 -in /etc/uhttpd.crt -noout -issuer"
    return invokeShell(issuedorg)
end

function certInvoke.invokeIssueddate()
    local issueddate = "openssl x509 -in /etc/uhttpd.crt -noout -dates"
    return invokeShell(issueddate)
end

function certInvoke.invokeExpiredate()
    local expiredate = "openssl x509 -in /etc/uhttpd.crt -noout -dates"
    return invokeShell(expiredate)
end

function certInvoke.invokeSubject()
    local subject ="openssl x509 -in /etc/uhttpd.crt -noout -subject"
    return invokeShell(subject)
end

function certInvoke.invokePublickey()
   local publickey = "openssl x509 -in /etc/uhttpd.crt -noout -pubkey"
    return invokeShell(publickey)
end

function certInvoke.invokeSignal()
    local signal = "openssl x509 -noout -text -in /etc/uhttpd.crt |grep Signature| grep -v grep"
    return invokeShell(signal)
end

function trim(s)
    return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function invokeShell(order)
	local t = io.popen(order)
	local a = t:read("*all")
	return a
--	return trim(a)
end

function invokeShellWithoutReturn(order)
	local t = io.popen(order)
end

return certInvoke
