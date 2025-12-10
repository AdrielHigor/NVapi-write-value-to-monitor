#!/bin/bash
# Build script for writeValueToDisplay.exe
# Works from Git Bash or any bash shell

NVAPI_INC="./nvapi/include"
NVAPI_LIB="./nvapi/amd64"

# Check if NVAPI include directory exists
if [ ! -f "$NVAPI_INC/nvapi.h" ]; then
    echo "ERROR: NVAPI headers not found at $NVAPI_INC"
    echo "Please ensure NVAPI is set up correctly"
    exit 1
fi

# Try to find Visual Studio compiler
VS2019_BUILDTOOLS="/c/Program Files (x86)/Microsoft Visual Studio/2019/BuildTools/VC/Auxiliary/Build/vcvars64.bat"
VS2022_COMMUNITY="/c/Program Files/Microsoft Visual Studio/2022/Community/VC/Auxiliary/Build/vcvars64.bat"
VS2019_COMMUNITY="/c/Program Files/Microsoft Visual Studio/2019/Community/VC/Auxiliary/Build/vcvars64.bat"

VCVARS=""
if [ -f "$VS2019_BUILDTOOLS" ]; then
    VCVARS="$VS2019_BUILDTOOLS"
elif [ -f "$VS2022_COMMUNITY" ]; then
    VCVARS="$VS2022_COMMUNITY"
elif [ -f "$VS2019_COMMUNITY" ]; then
    VCVARS="$VS2019_COMMUNITY"
fi

if [ -z "$VCVARS" ]; then
    echo "ERROR: Visual Studio not found."
    echo "Please install Visual Studio with C++ support or run from Visual Studio Developer Command Prompt"
    exit 1
fi

echo "Setting up Visual Studio environment..."
echo "Compiling writeValueToDisplay.cpp..."

# Get current directory in Windows format
CURRENT_DIR=$(pwd | sed 's|^/c/|C:\\|' | sed 's|^/d/|D:\\|' | sed 's|/|\\|g')
NVAPI_INC_WIN="$CURRENT_DIR\\nvapi\\include"
NVAPI_LIB_WIN="$CURRENT_DIR\\nvapi\\amd64"
VCVARS_WIN=$(echo "$VCVARS" | sed 's|^/c/|C:|' | sed 's|/|\\|g')

# Create temporary batch file in current directory
cat > build_temp.bat << EOF
@echo off
call "$VCVARS_WIN"
cd /d "$CURRENT_DIR"
if not exist "$NVAPI_INC_WIN\\nvapi.h" (
    echo ERROR: NVAPI header not found at $NVAPI_INC_WIN\\nvapi.h
    exit /b 1
)
cl.exe /EHsc /O2 /W3 /I"$NVAPI_INC_WIN" writeValueToDisplay.cpp /link /LIBPATH:"$NVAPI_LIB_WIN" nvapi64.lib /OUT:writeValueToDisplay.exe
EOF

cmd.exe //c build_temp.bat
BUILD_RESULT=$?

rm -f build_temp.bat

if [ $? -eq 0 ]; then
    echo ""
    echo "Build successful! writeValueToDisplay.exe created."
else
    echo ""
    echo "Build failed!"
    exit 1
fi

