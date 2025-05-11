# CMakeList.txt : CMake project for image_spritesheet_editor_qt, include source and define
# project specific logic here.
#
cmake_minimum_required (VERSION 3.8)

project ("image_spritesheet_editor_qt")


# Enable Hot Reload for MSVC compilers if supported.
#if (POLICY CMP0141)
#  cmake_policy(SET CMP0141 NEW)
#  set(CMAKE_MSVC_DEBUG_INFORMATION_FORMAT "$<IF:$<AND:$<C_COMPILER_ID:MSVC>,$<CXX_COMPILER_ID:MSVC>>,$<$<CONFIG:Debug,RelWithDebInfo>:EditAndContinue>,$<$<CONFIG:Debug,RelWithDebInfo>:ProgramDatabase>>")
#endif()



# Find includes in the build directories
#set(CMAKE_INCLUDE_CURRENT_DIR ON)

# Qt
#set(CMAKE_AUTOMOC ON)
#set(CMAKE_AUTORCC ON)
#set(CMAKE_AUTOUIC ON)

set(Qt_PATH "D:\\Programme\\Qt\\6.9.0\\msvc2022_64")

list(APPEND CMAKE_PREFIX_PATH "${Qt_PATH}")
#list(APPEND CMAKE_PREFIX_PATH "${Qt_PATH}/lib/cmake")

find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets Network)


# Make this a GUI application on Windows
if(WIN32)
	message("WIN32")
	set(CMAKE_WIN32_EXECUTABLE ON)
endif()



# Add source to this project's executable.
add_executable (image_spritesheet_editor_qt "src/MainApp.cpp" "src/MainApp.hpp")

if (CMAKE_VERSION VERSION_GREATER 3.12)
  set_property(TARGET image_spritesheet_editor_qt PROPERTY CXX_STANDARD 20)
endif()



# Include sub-projects.
add_subdirectory("src")


# Add tests and install targets if needed.

# Add Qt for linking
target_link_libraries(image_spritesheet_editor_qt Qt6::Core Qt6::Widgets Qt6::Gui)

message(CMAKE_BINARY_DIR="${CMAKE_BINARY_DIR}")


# Special build
add_custom_command(
	TARGET image_spritesheet_editor_qt
	POST_BUILD
	COMMAND
	 ${Qt_PATH}/bin/windeployqt.exe "${CMAKE_BINARY_DIR}/image_spritesheet_editor_qt.exe" --no-compiler-runtime
)