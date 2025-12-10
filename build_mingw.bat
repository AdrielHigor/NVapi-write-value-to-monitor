@echo off
REM Build script for writeValueToDisplay.exe using MinGW
REM Requires: MinGW-w64 and NVAPI SDK

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

REM Check for g++
where g++ >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: g++ not found. Please install MinGW-w64 and add it to PATH
    exit /b 1
)

echo Compiling writeValueToDisplay.cpp...
g++ -O2 -Wall -I"%NVAPI_INC%" writeValueToDisplay.cpp -L"%NVAPI_LIB%" -lnvapi64 -o writeValueToDisplay.exe

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Build successful! writeValueToDisplay.exe created.
) else (
    echo.
    echo Build failed!
    exit /b 1
)

