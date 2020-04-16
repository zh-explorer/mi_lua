#!/usr/bin/env lua

local f=io.popen("cpu_wakeup")
f:read("*a")
f:close()

