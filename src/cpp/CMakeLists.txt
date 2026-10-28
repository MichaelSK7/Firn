set(CPP_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/userData.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/save.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/util/mklog.cpp


)

set(CPP_HEADERS
    ${CMAKE_CURRENT_SOURCE_DIR}/userData.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/folderPathHelper.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/save.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/util/mklog.hpp

)

qt_add_library(FirnCpp STATIC
    ${CPP_SOURCES}
    ${CPP_HEADERS}
)

target_include_directories(FirnCpp
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/../../vendor
)

target_link_libraries(FirnCpp
    PUBLIC
        Qt6::Core
        VendorCpp
)

target_compile_definitions(FirnCpp PRIVATE
    USERDATA_DIR="${CMAKE_SOURCE_DIR}/userdata"
)

target_compile_definitions(FirnCpp PRIVATE
    PRESETS_DIR="${CMAKE_SOURCE_DIR}/userdata/presets/"
)

target_compile_definitions(FirnCpp PRIVATE
    PROJECT_DIR="${CMAKE_SOURCE_DIR}"
)

target_compile_definitions(FirnCpp PUBLIC
        LOG_DIR="${CMAKE_SOURCE_DIR}/log"
)