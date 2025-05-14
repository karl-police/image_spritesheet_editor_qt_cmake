# CMakeList.txt : CMake project for image_spritesheet_editor_qt, include source and define
# project specific logic here.
#
cmake_minimum_required (VERSION 3.8)

#include(qt.cmake)


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
# Tells CMake to run the uic tool to create a ui_*.h files that can be used by the source files.
#set(CMAKE_AUTOUIC ON)



# Qt_PATH
if(DEFINED $ENV{Qt_PATH})
	set(Qt_PATH $ENV{Qt_PATH})
else()
	# cacheVariables is in CMakePresets.json
	set(Qt_PATH $CACHE{Qt_PATH})
endif()

message( "Qt_PATH: " ${Qt_PATH} )


list(APPEND CMAKE_PREFIX_PATH "${Qt_PATH}")
#list(APPEND CMAKE_PREFIX_PATH "${Qt_PATH}/lib/cmake")

find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets Network)


# Make this a GUI application on Windows
if(WIN32)
	message("WIN32")
	set(CMAKE_WIN32_EXECUTABLE ON)
endif()


qt_standard_project_setup()


# Include sub-projects.
add_subdirectory("src")


# Add tests and install targets if needed.


message(CMAKE_BINARY_DIR="${CMAKE_BINARY_DIR}")