# mbedtls v2.25.0 (Apache-2.0 License)

CPMAddPackage(
    NAME mbedtls
    GITHUB_REPOSITORY ARMmbed/mbedtls
    VERSION 2.25.0
    DOWNLOAD_ONLY ON
)

if(mbedtls_ADDED)
    file(GLOB mbedtls_SOURCES ${mbedtls_SOURCE_DIR}/library/*.c)
    add_library(mbedtls STATIC ${mbedtls_SOURCES})
    target_include_directories(mbedtls PUBLIC ${mbedtls_SOURCE_DIR}/include)
    option(MBEDTLS_DEBUG "Enable debug prints for mbedtls" OFF)
    if(MBEDTLS_DEBUG)
        target_compile_definitions(mbedtls PRIVATE MBEDTLS_SSL_DEBUG_ALL)
    endif()
endif()