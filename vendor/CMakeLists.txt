set(CPP_SOURCES
)

set(CPP_HEADERS
    ${CMAKE_CURRENT_SOURCE_DIR}/nlohmann/json_fwd.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/nlohmann/json_literals.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/nlohmann/json_view.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/nlohmann/json.hpp
)

qt_add_library(VendorCpp STATIC
    ${CPP_SOURCES}
    ${CPP_HEADERS}
)

target_link_libraries(VendorCpp
    PUBLIC Qt6::Core
)

target_include_directories(VendorCpp PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)


