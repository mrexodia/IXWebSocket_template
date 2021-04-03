# This file was generated automatically by cmkr.

# Create a configure-time dependency on cmake.toml to improve IDE support
configure_file(cmake.toml cmake.toml COPYONLY)

# Regenerate CMakeLists.txt file when necessary
include("cmake/cmkr.cmake" OPTIONAL RESULT_VARIABLE CMKR_INCLUDE_RESULT)

if(CMKR_INCLUDE_RESULT)
	cmkr()
endif()

cmake_minimum_required(VERSION 3.15)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

project(IXWebSocket_template
	DESCRIPTION
		"Simple template for IXWebSocket (websocket and http client/server library for C++) based on CPM and cmkr."
)

set(CMAKE_FOLDER "Dependencies")
include(cmake/CPM.cmake)
include(cmake/zlib.cmake)
include(cmake/mbedtls.cmake)
include(cmake/ixwebsocket.cmake)
include(cmake/fmt.cmake)
include(cmake/nlohmann_json.cmake)
unset(CMAKE_FOLDER)


# Target rest_client
set(rest_client_SOURCES
	"src/rest_client.cpp"
	cmake.toml
)

add_executable(rest_client ${rest_client_SOURCES})

get_directory_property(CMKR_VS_STARTUP_PROJECT DIRECTORY ${PROJECT_SOURCE_DIR} DEFINITION VS_STARTUP_PROJECT)
if(NOT CMKR_VS_STARTUP_PROJECT)
	set_property(DIRECTORY ${PROJECT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT rest_client)
endif()

source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${rest_client_SOURCES})

target_compile_features(rest_client PRIVATE
	cxx_std_11
)

target_link_libraries(rest_client PRIVATE
	ixwebsocket
	nlohmann_json
	fmt
)

