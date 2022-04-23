cmake_minimum_required(VERSION 3.14)

project(Ataxx_Frontend LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(Qt5_DIR "D:/Softwares/Tools/Qt/5.15.2/msvc2019_64/lib/cmake/Qt5")

find_package(Qt5 COMPONENTS Core Quick REQUIRED)

set(CMAKE_EXPORT_COMPILE_COMMANDS True)

set(PROJECT_SOURCES
    src/TileData.cpp
    src/GameData.cpp
    src/main.cpp
    src/qml.qrc
)

add_executable(${PROJECT_NAME} WIN32 ${PROJECT_SOURCES})

target_link_libraries(${PROJECT_NAME} Qt5::Core Qt5::Quick)
