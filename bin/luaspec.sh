#!/bin/bash

# This loader script shouldn't be necessary once luaspec.lua is installed somewhere in the normal LUA_PATH and bin/luaspec is somewhere in the PATH

lib_path=$(dirname $0)/../lib
export LUA_PATH="$lib_path/?.lua;;"

$(dirname $0)/luaspec "$@"
