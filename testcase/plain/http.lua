function urlEncode(s)
    local ss = string.gsub(s, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)
    return string.gsub(ss, " ", "+")
end

function urlDecode(s)
    local ss = string.gsub(s, '%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)
    return ss
end

function filterInput(s)
    local ss=string.gsub(s,"['\\\"/&#;`|~<>^{},:;!%c%z%(%)%%%+%*%?%^%$]","")
    ss=string.gsub(ss, "^%s*(.-)%s*$", "%1")
    return ss
end
