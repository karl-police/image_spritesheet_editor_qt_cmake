# CMakeList.txt : CMake project, include source and define
# project specific logic here.
#

# Add /include as header file paths
#target_include_directories(image_spritesheet_editor_qt PRIVATE "include")

# Add source to this project's executable.
add_executable(image_spritesheet_editor_qt "MainApp.cpp" "MainApp.h" )

if (CMAKE_VERSION VERSION_GREATER 3.12)
  set_property(TARGET image_spritesheet_editor_qt PROPERTY CXX_STANDARD 20)
endif()



#target_include_directories(image_spritesheet_editor_qt PRIVATE "../include")



#set(UI_FILES
#	"resources/MainWindow.ui"
#)
qt_add_ui(image_spritesheet_editor_qt INCLUDE_PREFIX "resources" SOURCES "../resources/MainWindow.ui")



# Add Qt for linking
target_link_libraries(image_spritesheet_editor_qt Qt6::Core Qt6::Widgets Qt6::Gui)



# Special build
add_custom_command(
	TARGET image_spritesheet_editor_qt
	POST_BUILD
	COMMAND
	 ${Qt_PATH}/bin/windeployqt.exe "${CMAKE_BINARY_DIR}/image_spritesheet_editor_qt.exe" --no-compiler-runtime
)