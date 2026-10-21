file(GLOB_RECURSE CPP_SOURCES CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/*.hpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/*.h"
)


qt_add_library(VendorCpp STATIC ${CPP_SOURCES})

target_link_libraries(VendorCpp
    PUBLIC Qt6::Core
)

target_include_directories(VendorCpp PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)