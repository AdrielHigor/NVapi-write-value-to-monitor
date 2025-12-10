# NVapi-write-value-to-monitor
Send commands to monitor over i2c using NVapi. <br>
This can be used to issue VCP commands or other manufacturer specific commands


This program relies on the NVIDIA API (NVAPI), to compile it you will need to download the api which can be found here: <br> https://developer.nvidia.com/rtx/path-tracing/nvapi/get-started

### History (Creator)
This program was created after discovering that my display does not work with <b>ControlMyMonitor</b> to change inputs using VCP commands. Searching for an antlernative lead me to this thread https://github.com/rockowitz/ddcutil/issues/100 where other users had found a way to switch the inputs of their LG monitors using a linux program, I needed a windows solution. That lead to the NVIDIA API, this program is an adaptation of the i2c example code provided in the API

## History V2 (My Changes)
I've basically had the same issue above, I've forked the repo to keep maintaining it and updating it to my needs, with luck this will also apply to other souls in need of an easy way to switch monitors.

## Building

### Prerequisites

1. **NVAPI SDK** - Download from: https://developer.nvidia.com/rtx/path-tracing/nvapi/get-started
2. **Visual Studio Build Tools** or **Visual Studio 2019/2022** (with C++ workload)
3. **Git Bash** or any bash shell (for running `build.sh`)

### Setup NVAPI

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
   └── build.sh
   ```

### Building

#### Using build.sh (Recommended)

The `build.sh` script automatically detects and uses Visual Studio Build Tools. It works from Git Bash or any bash shell:

```bash
./build.sh
```

The script will:
- Automatically find Visual Studio Build Tools
- Set up the compilation environment
- Compile the project with optimizations
- Create `writeValueToDisplay.exe`

#### Using CMake (Alternative)

1. Create a build directory:
   ```bash
   mkdir build
   cd build
   ```
2. Run CMake:
   ```bash
   cmake ..
   cmake --build .
   ```

### Troubleshooting

- **"NVAPI headers not found"**: Make sure you've extracted NVAPI to the `nvapi` folder
- **"Visual Studio not found"**: Install Visual Studio Build Tools or Visual Studio with C++ workload
- **"Build failed"**: Check that NVAPI is properly set up in the `nvapi` folder
- **Link errors**: Verify `nvapi64.lib` is in the `nvapi/amd64` folder

## Usage

### Syntax
```
writeValueToDisplay.exe <display_index> <input_value> <command_code> [register_address]
```

| Argument | Description |
| -------- | ----------- |
| display_index | Index assigned to monitor by OS (Typically 0 for first screen, try running "mstsc.exe /l" in command prompt to see how windows has indexed your display(s)) |
| input_value   | value to write to screen |
| command_code  | VCP code or other|
| register_address | Address to write to, default 0x51 for VCP codes |



## Example Usage
Change display 0 brightness to 50% using VCP code 0x10
```
writeValueToDisplay.exe 0 0x32 0x10 
```
<br>

Change display 0 input to HDMI 1 using VCP code 0x60 on supported displays
```
writeValueToDisplay.exe 0 0x11 0x60 
```

### Change input on some displays
Some displays do not support using VCP codes to change inputs. I have tested this using values from this thread https://github.com/rockowitz/ddcutil/issues/100 with my LG Ultragear 27GP850-B. Your milage may vary with other monitors, <b>use at your own risk!</b>

#### Change input to HDMI 1 on LG Ultragear 27GP850-B
NOTE: LG Ultragear 27GP850-B is display 0 for me
```
writeValueToDisplay.exe 0 0x90 0xF4 0x50
```

#### Change input to Displayport on LG Ultragear 27GP850-B
NOTE: LG Ultragear 27GP850-B is display 0 for me
```
writeValueToDisplay.exe 0 0xD0 0xF4 0x50
```

## Known Commands

### LG Monitor Input Codes

These codes should work for LG monitors. Use with command code `0xF4` and register address `0x50`:

| Input Value | Input Source |
|------------|--------------|
| `0xD0` | DP-1 (DisplayPort 1) |
| `0xD1` | USB-C |
| `0x90` | HDMI-1 |
| `0x91` | HDMI-2 |

**Example:**
```bash
# Switch to HDMI-1
writeValueToDisplay.exe 0 0x90 0xF4 0x50

# Switch to DisplayPort
writeValueToDisplay.exe 0 0xD0 0xF4 0x50

# Switch to USB-C
writeValueToDisplay.exe 0 0xD1 0xF4 0x50
```

**Note:** These codes have been tested on LG monitors. Your mileage may vary with other monitor brands or models. Use at your own risk!
