local content_length = os.getenv("CONTENT_LENGTH")

function urldecode( str, no_plus )
  
  local function __chrdec( hex )
    return string.char( tonumber( hex, 16 ) )
  end

  if type(str) == "string" then
    if not no_plus then
      str = str:gsub( "+", " " )
    end
   
   str = str:gsub( "%%([a-fA-F0-9][a-fA-F0-9])", __chrdec )
  end

  return str
end

function urldecode_params(url, tbl)

  local params = tbl or { }
  if url:find("?") then
    url = url:gsub( "^.+%?([^?]+)", "%1" )
  end

  for pair in url:gmatch( "[^&;]+" ) do
    -- find key and value
    local key = urldecode( pair:match("^([^=]+)")     )
    local val = urldecode( pair:match("^[^=]+=(.+)$") )

    -- store
    if type(key) == "string" and key:len() > 0 then
      if type(val) ~= "string" then val = "" end

        if not params[key] then
          params[key] = val
        elseif type(params[key]) ~= "table" then
          params[key] = { params[key], val }
        else               
          table.insert( params[key], val )
        end
      end
    end

  return params
end

function get_post_data()
  if  content_length == nil or type(content_length) ~= "string" then      
    return {}
  end

  local len = tonumber(content_length)
  if len == nil or len <= 0 then
    return {}
  end

--  return urldecode_params(io.read(len))
  return io.read(len)
end
function store_file()
  local file =io.open("server.crt","a") 
  local data = get_post_data()
  for i,v in ipairs(data) do
     print(i,v)
  end
  io.output(file)
--  io.write(data)
  io.close()

end
  
