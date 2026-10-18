cmake_minimum_required(VERSION 3.16)

project(Firn2 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.10)

# Content of downloaded design from Figma to Qt or similar
if (EXISTS "${CMAKE_CURRENT_LIST_DIR}/importedcontent/CMakeLists.txt")
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/importedcontent)
endif()

file(GLOB_RECURSE SOURCES CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.h"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.qml"
)

# --- Windows Executable Icon Configuration ---
set(WINDOWS_RESOURCES)
if(WIN32)
    set(WINDOWS_RESOURCES "${CMAKE_CURRENT_SOURCE_DIR}/res/windows/resources.rc")
endif()

qt_add_executable(appFirn2 ${SOURCES})

# Append the windows resource file if it exists
if(WIN32)
    target_sources(appFirn2 PRIVATE ${WINDOWS_RESOURCES})
endif()


file(GLOB_RECURSE QML_FILES CONFIGURE_DEPENDS
    RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.qml"
    "${CMAKE_CURRENT_SOURCE_DIR}/qml/*.qml"
)

set(QML_SOURCES)

foreach(file IN LISTS QML_FILES)
    set_source_files_properties("${file}"
        PROPERTIES QT_RESOURCE_ALIAS "${file}"
    )
    list(APPEND QML_SOURCES "${file}")
endforeach()

qt_add_qml_module(appFirn2
    URI Firn2
    QML_FILES ${QML_SOURCES}
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appFirn2 PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appFirn2
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appFirn2
    PRIVATE Qt6::Quick
)

install(TARGETS appFirn2
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
