-- 在文件顶部添加
premake.api.addAllowed("architecture", "arm64")
premake.api.addAllowed("architecture", "x86_64")

workspace "YGO Classes"
    location "build"
    objdir "build/obj"
    language "C++"
    
    -- 定义多个平台
    platforms { "macosx-arm64", "macosx-x86_64" }
    configurations { "Debug", "Release" }

    -- 通用设置
    filter "system:macosx"
        system "macosx"
        toolset "clang"
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

    -- ARM64 设置
    filter { "platforms:macosx-arm64" }
        architecture "arm64"
        buildoptions { "-arch arm64" }
        linkoptions { "-arch arm64" }
        targetdir "build/bin/arm64/%{cfg.buildcfg}"

    -- x86_64 设置
    filter { "platforms:macosx-x86_64" }
        architecture "x86_64"
        buildoptions { "-arch x86_64" }
        linkoptions { "-arch x86_64" }
        targetdir "build/bin/x86_64/%{cfg.buildcfg}"

    -- 确保所有子项目都应用这些设置
    filter {}

    BUILD_LUA = true
    BUILD_SQLITE = true

    defines { "_CRT_SECURE_NO_WARNINGS"}
    
    -- 包含子项目时应用当前平台设置
    include "../../lua"
    include "../../event"
    include "../../sqlite3"
    include "../../irrlicht/premake5-only-zipreader.lua"
    include "../../ocgcore"
    include "../../gframe"

    -- 确保每个子项目都继承架构设置
    project "*"
        filter { "platforms:macosx-arm64" }
            architecture "arm64"
            buildoptions { "-arch arm64" }
            linkoptions { "-arch arm64" }
        
        filter { "platforms:macosx-x86_64" }
            architecture "x86_64"
            buildoptions { "-arch x86_64" }
            linkoptions { "-arch x86_64" }

    filter "configurations:Debug"
        symbols "On"
        optimize "Off"

    filter "configurations:Release"
        symbols "Off"
        optimize "On"
        