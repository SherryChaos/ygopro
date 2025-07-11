project "cspmemvfs"
    kind "StaticLib"
    cdialect "C11"
    files { "*.c", "*.h" }

    includedirs { "../../sqlite3" }

    filter "not action:vs*"
    defines { "_POSIX_C_SOURCE=200809L" }
