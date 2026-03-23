include "lzma/."

project "ygoserver"
        kind "SharedLib"
        cppdialect "C++14"
        files { "gframe.cpp", "gframe.h",
                "config.h", "serverapi.cpp", "serverapi.h",
                "game.cpp", "game.h", "myfilesystem.h",
                "deck_manager.cpp", "deck_manager.h",
                "data_manager.cpp", "data_manager.h",
                "replay.cpp", "replay.h",
                "netserver.cpp", "netserver.h",
                "single_duel.cpp", "single_duel.h",
                "tag_duel.cpp", "tag_duel.h" }
        includedirs { "../ocgcore", "../event/include", "../sqlite3", "../irrlicht/source/Irrlicht", "../irrlicht/include" }
        links { "ocgcore", "clzma", "sqlite3", "lua" , "event", "irrlicht"}
        defines { "YGOPRO_SERVER_MODE", "SERVER_ZIP_SUPPORT", "SERVER_PRO2_SUPPORT", "SERVER_PRO3_SUPPORT", "SERVER_TAG_SURRENDER_CONFIRM" }

        filter "system:windows"
                includedirs { "../event/windows" }
                links { "ws2_32" }
        filter "system:macosx"
                includedirs { "../event/macos" }
                --links { "pthread" }
        filter "system:linux"
                includedirs { "../event/linux" }
                
