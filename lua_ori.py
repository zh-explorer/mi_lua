from construct import Struct, Const, Enum, Byte, Bytes, Flag, Int8ul, this, Int32ul, Int64ul, \
    Int32sl, Int64sl, Double, Single, LazyBound, Array, Switch, Pass, BitStruct, BitsInteger, Adapter


class LuaDecodeException(Exception): pass


LuaInt = None
LuaSize_t = None
LuaNumber = None
LuaInstruction = None

Version = Enum(Byte, lua51=0x51, lua52=0x52, lua53=0x53)
Format = Enum(Byte, official=0)
Endian = Enum(Byte, big_endian=0, little_endian=1)
OpCode = Enum(BitsInteger(6), OP_MOVE=0,
              OP_LOADK=1,
              OP_LOADBOOL=2,
              OP_LOADNIL=3,
              OP_GETUPVAL=4,
              OP_GETGLOBAL=5,
              OP_GETTABLE=6,
              OP_SETGLOBAL=7,
              OP_SETUPVAL=8,
              OP_SETTABLE=9,
              OP_NEWTABLE=10,
              OP_SELF=11,
              OP_ADD=12,
              OP_SUB=13,
              OP_MUL=14,
              OP_DIV=15,
              OP_MOD=16,
              OP_POW=17,
              OP_UNM=18,
              OP_NOT=19,
              OP_LEN=20,
              OP_CONCAT=21,
              OP_JMP=22,
              OP_EQ=23,
              OP_LT=24,
              OP_LE=25,
              OP_TEST=26,
              OP_TESTSET=27,
              OP_CALL=28,
              OP_TAILCALL=29,
              OP_RETURN=30,
              OP_FORLOOP=31,
              OP_FORPREP=32,
              OP_TFORLOOP=33,
              OP_SETLIST=34,
              OP_CLOSE=35,
              OP_CLOSURE=36,
              OP_VARARG=37,
              )

# String = PascalString(LazyBound(lambda: LuaSize_t), "ascii")
String = Struct(
    "size" / LazyBound(lambda: LuaSize_t),
    "str" / Bytes(this.size)
)

GlobalHead = Struct(
    "signature" / Const(b"\x1bLua"),
    "version" / Version,
    "format" / Format,
    "endian" / Endian,
    "size_int" / Int8ul,
    "size_size_t" / Int8ul,
    "size_instruction" / Int8ul,
    "size_lua_number" / Int8ul,
    "lua_num_valid" / Byte,
)

ProtoHead = Struct(
    "source" / String,
    "linedefined" / Int32ul,
    "lastlinedefined" / Int32ul,
    "nups" / Int8ul,
    "numparams" / Int8ul,
    "is_vararg" / Int8ul,
    "maxstacksize" / Int8ul
)

Instruction = BitStruct(
    "B" / BitsInteger(9),
    "C" / BitsInteger(9),
    "A" / BitsInteger(8),
    "opcode" / OpCode,
)


class InstrctionAdapter(Adapter):
    def _decode(self, obj, context, path):
        return Instruction.parse(obj[::-1])

    def _encode(self, obj, context, path):
        return Instruction.build(obj)[::-1]


Code = Struct(
    "sizecode" / Int32ul,
    "insts" / Array(this.sizecode, InstrctionAdapter(Bytes(4)))
)

LuaDatatype = Enum(Byte,
                   LUA_TNIL=0,
                   LUA_TBOOLEAN=1,
                   LUA_TLIGHTUSERDATA=2,
                   LUA_TNUMBER=3,
                   LUA_TSTRING=4,
                   LUA_TTABLE=5,
                   LUA_TFUNCTION=6,
                   LUA_TUSERDATA=7,
                   LUA_TTHREAD=8, )

Constant = Struct(
    "data_type" / LuaDatatype,
    "data" / Switch(this.data_type,
                    {"LUA_INIL": Pass, "LUA_TBOOLEAN": Flag,
                     "LUA_TNUMBER": LazyBound(lambda: LuaNumber), "LUA_TSTRING": String})
)

Constants = Struct(
    "sizek" / Int32ul,
    "constant" / Array(this.sizek, Constant),
)

LineInfo = Struct(
    "sizelineinfo" / Int32ul,
    "lineinfo" / Array(this.sizelineinfo, Int32ul)
)

LocVar = Struct(
    "varname" / String,
    "startpc" / Int32ul,
    "endpc" / Int32ul
)

LocVars = Struct(
    "sizelocvars" / Int32ul,
    "loc_var" / Array(this.sizelocvars, LocVar)
)

UpValues = Struct(
    'sizeupvalues' / Int32ul,
    "upvalues" / Array(this.sizeupvalues, String)
)

Protos = Struct(
    "sizep" / Int32ul,
    "proto" / Array(this.sizep, LazyBound(lambda: Proto))
)

Proto = Struct(
    "header" / ProtoHead,
    "code" / Code,
    "constants" / Constants,
    "protos" / Protos,
    "lineinfo" / LineInfo,
    "loc_vars" / LocVars,
    "values" / UpValues,
)

Luac = Struct(
    "global_head" / GlobalHead,
    "top_proto" / Proto
)


def lua_type_set(size_int, size_size_t, size_lua_number, size_instruction):
    class h(object):
        def __init__(self, size_int, size_size_t, size_lua_number, size_instruction):
            self.size_int = size_int
            self.size_size_t = size_size_t
            self.size_lua_number = size_lua_number
            self.size_instruction = size_instruction

    head = h(size_int, size_size_t, size_lua_number, size_instruction)
    lua_type_define(head)


def lua_type_define(head):
    global LuaInstruction, LuaInt, LuaNumber, LuaSize_t
    if head.size_int == 4:
        LuaInt = Int32sl
    elif head.size_int == 8:
        LuaInt = Int64sl
    else:
        LuaDecodeException("Unsupported size int")

    if head.size_size_t == 4:
        LuaSize_t = Int32ul
    elif head.size_size_t == 8:
        LuaSize_t = Int64ul
    else:
        LuaDecodeException("Unsupported size int")

    if head.size_lua_number == 8:
        LuaNumber = Double
    elif head.size_lua_number == 4:
        LuaNumber = Single
    else:
        LuaDecodeException("Unsupported size int")

    if head.size_instruction == 4:
        LuaInstruction = Int32ul
    else:
        LuaDecodeException("Unsupported size int")


if __name__ == '__main__':
    with open("./luac.ori", 'rb') as fp:
        data = fp.read()
    header = GlobalHead.parse(data)
    lua_type_define(header)
    h = Luac.parse(data)
    print(h)
