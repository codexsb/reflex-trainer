#!/bin/bash

# Set your MSYS2 MinGW64 bin path here
MINGW_DLL_PATH="/c/msys64/mingw64/bin"

# Destination folder (adjust if your build path changes)
DIST_DIR="./dist"

# Create dist directory if it doesn't exist
mkdir -p "$DIST_DIR"

# List of DLLs to copy
DLLS=(
    "SDL2.dll"
    "SDL2_mixer.dll"
    "SDL2_ttf.dll"
    "libwinpthread-1.dll"
    "libstdc++-6.dll"
    "libgcc_s_seh-1.dll"
    "libogg-0.dll"
    "libopus-0.dll"
    "libopusfile-0.dll"
    "libmpg123-0.dll"
    "libmodplug-1.dll"
    "libFLAC-8.dll"
    "libvorbis-0.dll"
    "libvorbisfile-3.dll"
    "libfreetype-6.dll"
    "libharfbuzz-0.dll"
    "libgraphite2.dll"
    "libglib-2.0-0.dll"
    "libintl-8.dll"
    "libiconv-2.dll"
    "libbz2-1.dll"
    "libbrotlicommon.dll"
    "libbrotlidec.dll"
    "libpcre2-8-0.dll"
    "libpng16-16.dll"
    "zlib1.dll"
)

# Copy each DLL
echo "Copying DLLs to $DIST_DIR..."
for dll in "${DLLS[@]}"; do
    if [ -f "$MINGW_DLL_PATH/$dll" ]; then
        cp -u "$MINGW_DLL_PATH/$dll" "$DIST_DIR/"
        echo "✔ Copied: $dll"
    else
        echo "⚠ Missing: $dll (not found in $MINGW_DLL_PATH)"
    fi
done

echo "✅ Done!"
