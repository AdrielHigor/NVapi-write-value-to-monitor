@echo off
REM Build script for writeValueToDisplay.exe
REM Requires: Visual Studio C++ compiler (cl.exe) and NVAPI SDK

REM Set NVAPI paths - adjust these to match your NVAPI installation
SET NVAPI_INC=.\nvapi\include
SET NVAPI_LIB=.\nvapi\amd64

REM Check if NVAPI include directory exists
if not exist "%NVAPI_INC%\nvapi.h" (
    echo ERROR: NVAPI headers not found at %NVAPI_INC%
    echo Please download NVAPI from: https://developer.nvidia.com/rtx/path-tracing/nvapi/get-started
    echo And extract it to a 'nvapi' folder in this directory, or update NVAPI_INC and NVAPI_LIB in this script
    exit /b 1
)

REM Try to find Visual Studio compiler
if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat" (
    call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
) else if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat" (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"
) else if exist "C:\Program Files\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat" (
    call "C:\Program Files\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"
) else (
    echo ERROR: Visual Studio not found. Please run this script from a Visual Studio Developer Command Prompt
    echo Or install Visual Studio with C++ support
    exit /b 1
)

echo Compiling writeValueToDisplay.cpp...
cl.exe /EHsc /O2 /W3 /I"%NVAPI_INC%" writeValueToDisplay.cpp /link /LIBPATH:"%NVAPI_LIB%" nvapi64.lib /OUT:writeValueToDisplay.exe

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Build successful! writeValueToDisplay.exe created.
) else (
    echo.
    echo Build failed!
    exit /b 1
)

