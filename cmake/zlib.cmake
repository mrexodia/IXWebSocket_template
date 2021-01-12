# zlib v2.25.0 (zlib License)

CPMAddPackage(
    NAME zlib
    GITHUB_REPOSITORY madler/zlib
    VERSION 1.2.11
    DOWNLOAD_ONLY ON
)

if(zlib_ADDED)
    add_library(zlib STATIC
        ${zlib_SOURCE_DIR}/adler32.c
        ${zlib_SOURCE_DIR}/compress.c
        ${zlib_SOURCE_DIR}/crc32.c
        ${zlib_SOURCE_DIR}/deflate.c
        ${zlib_SOURCE_DIR}/gzclose.c
        ${zlib_SOURCE_DIR}/gzlib.c
        ${zlib_SOURCE_DIR}/gzread.c
        ${zlib_SOURCE_DIR}/gzwrite.c
        ${zlib_SOURCE_DIR}/inflate.c
        ${zlib_SOURCE_DIR}/infback.c
        ${zlib_SOURCE_DIR}/inftrees.c
        ${zlib_SOURCE_DIR}/inffast.c
        ${zlib_SOURCE_DIR}/trees.c
        ${zlib_SOURCE_DIR}/uncompr.c
        ${zlib_SOURCE_DIR}/zutil.c
    )
    
    include(CheckIncludeFile)
    check_include_file(unistd.h Z_HAVE_UNISTD_H)
    if(Z_HAVE_UNISTD_H)
        target_compile_definitions(zlib PRIVATE Z_HAVE_UNISTD_H)
    endif()

    if(MSVC)
        target_compile_definitions(zlib PRIVATE _CRT_SECURE_NO_DEPRECATE _CRT_NONSTDC_NO_DEPRECATE)
    endif()
    target_include_directories(zlib PUBLIC ${zlib_SOURCE_DIR})
endif()