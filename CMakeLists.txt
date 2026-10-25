
cmake_minimum_required(VERSION 3.21)

project(appFirn VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.10 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.10)

# Optional imported content
if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/importedcontent/CMakeLists.txt")
    add_subdirectory(importedcontent)
endif()

# Windows executable icon
set(WINDOWS_RESOURCES)
if(WIN32 AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/res/windows/resources.rc")
    set(WINDOWS_RESOURCES res/windows/resources.rc)
endif()

# Main executable
qt_add_executable(Firn
    src/main.cpp
    ${WINDOWS_RESOURCES}
)

# QML module
qt_add_qml_module(Firn
    URI Firn
    VERSION 1.0
    QML_FILES
        src/Main.qml
        src/qml/generic/BubbleButton.qml
        src/qml/generic/BubbleRect.qml
        src/qml/generic/Cross.qml
        src/qml/generic/HTextBoxGroup.qml
        src/qml/generic/VTextBoxGroup.qml
        src/qml/generic/ScriptButton.qml
        src/qml/generic/NewPresetPopup.qml
        src/qml/generic/PresetsList.qml
    RESOURCES
        res/assets/Firn_appIcon.png
)

# C++ subfolder
add_subdirectory(src/cpp)
add_subdirectory(vendor)

target_link_libraries(Firn PRIVATE
    Qt6::Quick
    FirnCpp
)

set_target_properties(Firn PROPERTIES
    MACOSX_BUNDLE TRUE
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING
        ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    WIN32_EXECUTABLE FALSE
)

include(GNUInstallDirs)

install(TARGETS Firn
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

target_compile_definitions(Firn PRIVATE
    USERDATA_DIR="${CMAKE_SOURCE_DIR}/userdata"
)

target_compile_definitions(FirnCpp PUBLIC
        LOG_DIR="${CMAKE_SOURCE_DIR}/log"
)