workspace "YGO Classes"
    location "build"
    objdir "build/obj"
    language "C++"
    platforms { "x86_64" }
    configurations { "Debug", "Release" }

    defines { "LINUX", "__linux__", "BUILD_LUA" }
    include "../../lua"
    include "../../event"
    include "../../sqlite3"
    include "../../irrlicht/premake5-only-zipreader.lua"
    include "../../ocgcore"
    include "../../gframe"

    buildoptions {
        "-fPIC",
        "-finput-charset=UTF-8"
    }

    disablewarnings {
        "unused-parameter",        -- 对应 4100
        "sign-compare",            -- 对应 4018
        "type-limits",             -- 部分 4244/4267
        "deprecated-declarations", -- 对应 4996
        "strict-aliasing"          -- 部分 4334
    }
    
    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"
        optimize "Off"

    filter "configurations:Release"
        defines { "NDEBUG" }
        symbols "Off"
        optimize "Speed"
    
