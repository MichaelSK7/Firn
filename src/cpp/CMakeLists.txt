file(GLOB_RECURSE CPP_SOURCES CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/*.hpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/*.h"
)

qt_add_library(FirnCpp STATIC ${CPP_SOURCES})

target_link_libraries(FirnCpp
    PUBLIC Qt6::Core
)