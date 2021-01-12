# IXWebSocket 11.0.8 (BSD-3-Clause License)

CPMAddPackage(
    NAME ixwebsocket
    GITHUB_REPOSITORY machinezone/IXWebSocket
    VERSION 11.0.8
    DOWNLOAD_ONLY ON
)

if(ixwebsocket_ADDED)
    file(GLOB ixwebsocket_SOURCES ${ixwebsocket_SOURCE_DIR}/ixwebsocket/*.cpp)
    add_library(ixwebsocket STATIC ${ixwebsocket_SOURCES})
    target_include_directories(ixwebsocket PUBLIC ${ixwebsocket_SOURCE_DIR})
    target_compile_features(ixwebsocket PUBLIC cxx_std_11)

    if (WIN32)
        target_link_libraries(ixwebsocket PRIVATE wsock32 ws2_32 shlwapi)
        target_compile_definitions(ixwebsocket PRIVATE _CRT_SECURE_NO_WARNINGS)
    endif()

    if (UNIX)
        find_package(Threads REQUIRED)
        target_link_libraries(ixwebsocket PUBLIC ${CMAKE_THREAD_LIBS_INIT})
    endif()

    if(TARGET zlib)
        message(STATUS "ixwebsocket: zlib support enabled")
        target_compile_definitions(ixwebsocket PRIVATE IXWEBSOCKET_USE_ZLIB)
        target_link_libraries(ixwebsocket PRIVATE zlib)
    else()
        message(STATUS "ixwebsocket: zlib support disabled (include zlib first)")
    endif()
    
    if(TARGET mbedtls)
        message(STATUS "ixwebsocket: mbedtls support enabled")
        target_compile_definitions(ixwebsocket PUBLIC IXWEBSOCKET_USE_TLS)
        target_compile_definitions(ixwebsocket PUBLIC IXWEBSOCKET_USE_MBED_TLS)
        target_link_libraries(ixwebsocket PRIVATE mbedtls)
        if(WIN32)
            target_link_libraries(ixwebsocket PRIVATE Crypt32)
        endif()
    else()
        message(STATUS "ixwebsocket: mbedtls support disabled (include mbedtls first)")
    endif()
endif()


