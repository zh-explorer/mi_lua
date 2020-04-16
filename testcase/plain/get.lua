#!/usr/bin/env lua
require"cgi-bin/extends"
require"cgi-bin/http"


function getAttribuate(name)
	local source = os.getenv("QUERY_STRING")
	source = urlDecode(source)
	source = urlDecode(source)

	if source == nil then
		return nil
	end

	local tableSource = split(source,'&')
	for i=1,#tableSource do
		-- print(tableSource[i])
		local param = split(tableSource[i],'=')
		if param[1] == name then
			return param[2]
		end
	end
end

function getAttribuateFilter(name)
	local source = os.getenv("QUERY_STRING")
	source = urlDecode(source)
	source = urlDecode(source)

	if source == nil then
		return nil
	end

	local tableSource = split(source,'&')
	for i=1,#tableSource do
		-- print(tableSource[i])
		local param = split(tableSource[i],'=')
		if param[1] == name then
			return filterInput(param[2])
		end
	end
end
