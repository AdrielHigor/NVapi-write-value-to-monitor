# Build Instructions

## Prerequisites

1. **NVAPI SDK** - Download from: https://developer.nvidia.com/rtx/path-tracing/nvapi/get-started
2. **C++ Compiler** - Choose one:
   - Visual Studio 2019/2022 (with C++ workload)
   - MinGW-w64

## Setup NVAPI

1. Download the NVAPI SDK from NVIDIA
2. Extract it to a folder named `nvapi` in this project directory
3. The structure should be:
   ```
   NVapi-write-value-to-monitor/
   ├── nvapi/
   │   ├── include/
   │   │   └── nvapi.h
   │   └── amd64/
   │       └── nvapi64.lib
   ├── writeValueToDisplay.cpp
   └── build.bat
   ```

## Building

### Option 1: Using Visual Studio (Recommended)

1. Open **Developer Command Prompt for VS** (or run `build.bat` which will set it up automatically)
2. Navigate to this directory
3. Run:
   ```batch
   build.bat
   ```

### Option 2: Using MinGW

1. Install MinGW-w64 and add it to PATH
2. Run:
   ```batch
   build_mingw.bat
   ```

### Option 3: Using CMake

1. Create a build directory:
   ```batch
   mkdir build
   cd build
   ```
2. Run CMake:
   ```batch
   cmake ..
   cmake --build .
   ```

## Manual Compilation

If you need to compile manually, use one of these commands:

### Visual Studio (cl.exe):
```batch
cl.exe /EHsc /O2 /W3 /I"nvapi\include" writeValueToDisplay.cpp /link /LIBPATH:"nvapi\amd64" nvapi64.lib /OUT:writeValueToDisplay.exe
```

### MinGW (g++):
```batch
g++ -O2 -Wall -I"nvapi/include" writeValueToDisplay.cpp -L"nvapi/amd64" -lnvapi64 -o writeValueToDisplay.exe
```

## Troubleshooting

- **"NVAPI headers not found"**: Make sure you've extracted NVAPI to the `nvapi` folder
- **"cl.exe not found"**: Run from Visual Studio Developer Command Prompt or install Visual Studio
- **"g++ not found"**: Install MinGW-w64 and add it to PATH
- **Link errors**: Verify `nvapi64.lib` is in the `nvapi/amd64` folder

