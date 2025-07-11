project "clzma"
    kind "StaticLib"
    cdialect "C11"
    files { "*.c", "*.h" }

    filter "system:macosx"
        buildoptions { "-fPIC" }

    filter "system:linux"
        buildoptions { "-fPIC" }