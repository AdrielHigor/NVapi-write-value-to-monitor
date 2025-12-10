cmake_minimum_required(VERSION 3.10)
project(writeValueToDisplay)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Set NVAPI paths - adjust these to match your NVAPI installation
set(NVAPI_INC "${CMAKE_SOURCE_DIR}/nvapi/include")
set(NVAPI_LIB "${CMAKE_SOURCE_DIR}/nvapi/amd64")

# Check if NVAPI exists
if(NOT EXISTS "${NVAPI_INC}/nvapi.h")
    message(FATAL_ERROR 
        "NVAPI headers not found at ${NVAPI_INC}\n"
        "Please download NVAPI from: https://developer.nvidia.com/rtx/path-tracing/nvapi/get-started\n"
        "And extract it to a 'nvapi' folder in this directory, or update NVAPI_INC and NVAPI_LIB in CMakeLists.txt"
    )
endif()

include_directories(${NVAPI_INC})
link_directories(${NVAPI_LIB})

add_executable(writeValueToDisplay writeValueToDisplay.cpp)
target_link_libraries(writeValueToDisplay nvapi64)

# Set output directory
set_target_properties(writeValueToDisplay PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}
)

