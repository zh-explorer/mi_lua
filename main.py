import lua_mi
import lua_ori
import argparse
import os
import logging


class LuaDecodeException(Exception): pass


MI_LUA = 1
ORI_LUA = 0


def head_strip(data):
    if data[0] == b"#"[0]:
        return data[data.find(b'\n') + 1:]
    else:
        return data


def check_lua_type(data):
    if data.startswith(b"\x1bFate/Z\x1b"):  # xiaomi lua
        logging.warning("decode a xiaomi lua")
        return MI_LUA
    elif data.startswith(b"\x1bLua"):
        logging.warning("decode a origin lua")
        return ORI_LUA
    else:
        raise LuaDecodeException("unknown lua type")


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="translate luac with xiaomi and origin")
    parser.add_argument("infile", type=str)
    parser.add_argument("-o", dest="outfile", help="out put file", type=str, nargs="?")
    parser.add_argument("-d", dest="decode", help="only decode luac and print content", action="store_true")

    args = parser.parse_args()
    if not os.path.isfile(args.infile):
        raise LuaDecodeException("The infile is not a regular file")
    infile_path = args.infile
    outfile_path = args.outfile
    if outfile_path is None:
        outfile_path = infile_path + ".dec"

    with open(infile_path, 'rb') as fp:
        data = fp.read()
    data = head_strip(data)
    lua_type = check_lua_type(data)

    if lua_type == MI_LUA:
        header = lua_mi.GlobalHead.parse(data)
        lua_mi.lua_type_define(header)
        h = lua_mi.Luac.parse(data)
    else:
        header = lua_ori.GlobalHead.parse(data)
        lua_ori.lua_type_define(header)
        h = lua_ori.Luac.parse(data)

    if args.decode:
        print(h)
    else:
        if lua_type == MI_LUA:
            lua_ori.lua_type_set(4, 8, 8, 4)
            h.global_head = lua_ori.GlobalHead.parse(
                bytes([0x1B, 0x4C, 0x75, 0x61, 0x51, 0x00, 0x01, 0x04, 0x08, 0x04, 0x08, 0x00]))
            d = lua_ori.Luac.build(h)
            with open(outfile_path, 'wb') as fp:
                fp.write(d)
        else:
            lua_mi.lua_type_set(4, 4, 8, 4)
            h.global_head = lua_mi.GlobalHead.parse(
                bytes([0x1B, 0x46, 0x61, 0x74, 0x65, 0x2F, 0x5A, 0x1B, 0x51, 0x00, 0x01, 0x04, 0x04, 0x04, 0x08, 0x04]))
            d = lua_mi.Luac.build(h)
            with open(outfile_path, 'wb') as fp:
                fp.write(d)
