function Result(code,message,data)
	if data == nil then
            data = '""'
    end
	local str = '{"code":'..code..',"message":"'..message..'","data":'..data..'}'
	JsonContent()
	print(str)
end

function JsonContent()
	print("content-type:application/json;charset=UTF-8\n")
end