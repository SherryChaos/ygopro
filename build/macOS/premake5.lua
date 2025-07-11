workspace "YGO Classes"
    location "build"
    objdir "build/obj"
    language "C++"
    platforms { "macosx" }
    configurations { "Debug", "Release" }

    BUILD_LUA = true
    BUILD_SQLITE = true

    defines { "_CRT_SECURE_NO_WARNINGS"}
    include "../../lua"
    include "../../event"
    include "../../sqlite3"
    include "../../irrlicht/premake5-only-zipreader.lua"
    include "../../ocgcore"
    include "../../gframe"

    buildoptions {
        "-Wno-unused-variable",
        "-Wno-unused-parameter",
        "-Wno-deprecated-declarations",
        "-Wno-format",
        "-Wno-sign-compare",
        "-Wno-unused-but-set-variable",
        "-Wno-missing-field-initializers",
        "-Wno-int-to-pointer-cast",
        "-Wno-pointer-to-int-cast",
        "-Wno-unused-function",
        "-Wno-unused-value",
        "-Wno-unused-result",
        "-Wno-unused-private-field",
        "-Wno-unused-local-typedef"
    }

    filter "configurations:Debug"
        symbols "On"
        optimize "Off"

    filter "configurations:Release"
        symbols "Off"
        optimize "On"

    filter "platforms:macosx"
        system "macosx"
        toolset "clang"
