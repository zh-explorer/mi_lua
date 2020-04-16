import lua_mi
import lua_ori


def head_strip(data):
    if data[0] == b"#"[0]:
        return data[data.find(b'\n') + 1:]
    else:
        return data


with open("/home/explorer/project/mirouter/XQMitvUtil.lua", 'rb') as fp:
    data = fp.read()
    data = head_strip(data)

header = lua_mi.GlobalHead.parse(data)
lua_mi.lua_type_define(header)
h = lua_mi.Luac.parse(data)

lua_ori.lua_type_set(4, 8, 8, 4)
print(h)
h.global_head = lua_ori.GlobalHead.parse(
    bytes([0x1B, 0x4C, 0x75, 0x61, 0x51, 0x00, 0x01, 0x04, 0x08, 0x04, 0x08, 0x00]))
d = lua_ori.Luac.build(h)
with open("/home/explorer/project/mirouter/XQMitvUtil_dec.lua", 'wb') as fp:
    fp.write(d)
