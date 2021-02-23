CPMAddPackage(
    NAME nlohmann_json
    VERSION 3.9.1
    # not using the repo as it takes forever to clone
    URL https://github.com/nlohmann/json/releases/download/v3.9.1/include.zip
    URL_HASH SHA256=6bea5877b1541d353bd77bdfbdb2696333ae5ed8f9e8cc22df657192218cad91
)

if(nlohmann_json_ADDED)
    add_library(nlohmann_json INTERFACE)
    target_include_directories(nlohmann_json SYSTEM INTERFACE ${nlohmann_json_SOURCE_DIR}/include)
endif()