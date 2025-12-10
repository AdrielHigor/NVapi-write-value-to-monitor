#!/bin/bash
# Toggle between HDMI-1 and DP inputs
# Can be used with Logitech macros or any automation tool

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STATE_FILE="$HOME/.monitor_input_state"
EXE_PATH="$SCRIPT_DIR/writeValueToDisplay.exe"

# Check if executable exists
if [ ! -f "$EXE_PATH" ]; then
    # Try to find it in PATH
    if command -v writeValueToDisplay.exe >/dev/null 2>&1; then
        EXE_PATH="writeValueToDisplay.exe"
    else
        echo "Error: writeValueToDisplay.exe not found at $EXE_PATH"
        echo "Please ensure the executable is in the same directory as this script"
        exit 1
    fi
fi

# Read current state (default to DP if file doesn't exist)
if [ -f "$STATE_FILE" ]; then
    CURRENT_STATE=$(cat "$STATE_FILE")
else
    CURRENT_STATE="DP"
fi

# Toggle based on current state
if [ "$CURRENT_STATE" = "DP" ]; then
    # Currently on DP, switch to HDMI-1
    echo "Switching from DP to HDMI-1..."
    "$EXE_PATH" 0 0x90 0xF4 0x50
    if [ $? -eq 0 ]; then
        echo "HDMI-1" > "$STATE_FILE"
        echo "Switched to HDMI-1"
    else
        echo "Error: Failed to switch to HDMI-1"
        exit 1
    fi
else
    # Currently on HDMI-1 (or unknown), switch to DP
    echo "Switching from HDMI-1 to DP..."
    "$EXE_PATH" 0 0xD0 0xF4 0x50
    if [ $? -eq 0 ]; then
        echo "DP" > "$STATE_FILE"
        echo "Switched to DP"
    else
        echo "Error: Failed to switch to DP"
        exit 1
    fi
fi

exit 0

