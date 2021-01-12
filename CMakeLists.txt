# Modern CMake
cmake_minimum_required(VERSION 3.18)

project(IXWebSocket_template)

# Add module path for dependencies
list(PREPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

# Enable solution folder support
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

set(CMAKE_FOLDER "Dependencies")
include(CPM)
include(zlib)
include(mbedtls)
include(ixwebsocket)

set(CMAKE_FOLDER "")

add_executable(${PROJECT_NAME}
    ws_client.cpp
)

target_link_libraries(${PROJECT_NAME} PRIVATE
    ixwebsocket
)

# Set Visual Studio startup project
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${PROJECT_NAME})