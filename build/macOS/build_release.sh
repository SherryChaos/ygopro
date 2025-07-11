#!/bin/bash

# 遇到错误时退出脚本
set -e

# 打印执行的命令
set -x

# 1. 清理构建目录
rm -rf build || true

# 2. 生成 Makefile
premake5 gmake

# 获取 CPU 核心数
CORES=$(sysctl -n hw.ncpu 2>/dev/null || echo 4)

# 设置默认构建配置为 Release
BUILD_CONFIG="release"
echo "Building with configuration: $BUILD_CONFIG"

# 3. 编译 ARM64 版本
echo "Building ARM64 ($BUILD_CONFIG)..."
cd build  # 进入 build 目录
make config=${BUILD_CONFIG}_macosx-arm64 -j$CORES

# 4. 编译 x86_64 版本
echo "Building x86_64 ($BUILD_CONFIG)..."
make config=${BUILD_CONFIG}_macosx-x86_64 -j$CORES
cd ..  # 返回上级目录

# 5. 创建通用二进制目录
UNIVERSAL_DIR="build/bin/universal/$BUILD_CONFIG"
mkdir -p $UNIVERSAL_DIR

# 6. 合并为通用二进制
echo "Creating universal binaries ($BUILD_CONFIG)..."

# 定义要合并的库列表
LIBS=("libsqlite3.dylib" "libocgcore.dylib" "libygoserver.dylib")

for lib in "${LIBS[@]}"; do
    ARM_PATH="build/bin/arm64/$BUILD_CONFIG/$lib"
    X64_PATH="build/bin/x86_64/$BUILD_CONFIG/$lib"
    UNIVERSAL_PATH="$UNIVERSAL_DIR/$lib"
    
    # 检查文件是否存在
    if [[ -f "$ARM_PATH" && -f "$X64_PATH" ]]; then
        lipo -create "$ARM_PATH" "$X64_PATH" -output "$UNIVERSAL_PATH"
        echo "Created universal binary: $UNIVERSAL_PATH"
    else
        echo "Warning: Missing one of the binaries for $lib"
        echo "  ARM64: $ARM_PATH"
        echo "  x86_64: $X64_PATH"
    fi
done

# 7. 验证结果
echo "Universal binaries created in $UNIVERSAL_DIR:"
for lib in "${LIBS[@]}"; do
    FILE="$UNIVERSAL_DIR/$lib"
    if [ -f "$FILE" ]; then
        echo -n "$lib architectures: "
        lipo -archs "$FILE"
    else
        echo "$lib not found in universal directory"
    fi
done

echo "Release build completed successfully!"
