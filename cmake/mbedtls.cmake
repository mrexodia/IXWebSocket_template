# mbedtls v2.25.0 (Apache-2.0 License)

if(TARGET zlib)
    message(STATUS "mbedtls: zlib support enabled")
    set(mbedtls_ENABLE_ZLIB_SUPPORT ON)
else()
    message(STATUS "mbedtls: zlib support disabled (include zlib first)")
    set(mbedtls_ENABLE_ZLIB_SUPPORT OFF)
endif()

CPMAddPackage(
    NAME mbedtls
    GIT_REPOSITORY https://github.com/ARMmbed/mbedtls
    VERSION 2.25.0
    OPTIONS
        "ENABLE_PROGRAMS OFF"
        "ENABLE_TESTING OFF"
        "ENABLE_ZLIB_SUPPORT ${mbedtls_ENABLE_ZLIB_SUPPORT}"
        "INSTALL_MBEDTLS_HEADERS OFF"
        "LINK_WITH_PTHREAD OFF"
        "LINK_WITH_TRUSTED_STORAGE OFF"
        "MBEDTLS_FATAL_WARNINGS ON"
        "UNSAFE_BUILD OFF"
        "USE_PKCS11_HELPER_LIBRARY OFF"
        "USE_SHARED_MBEDTLS_LIBRARY OFF"
        "USE_STATIC_MBEDTLS_LIBRARY ON"
        "MBEDTLS_TARGET_PREFIX mbedtls_"
)
if(mbedtls_ADDED)
    # create an interface wrapper target for all the mbedtls components
    add_library(mbedtls INTERFACE)
    target_link_libraries(mbedtls INTERFACE
        mbedtls_mbedtls
        mbedtls_mbedx509
        mbedtls_mbedcrypto
    )
endif()
