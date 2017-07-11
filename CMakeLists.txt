################################################################################
## C-Boil
## ø
################################################################################
cmake_minimum_required(VERSION 2.6.0)
project(cboil)
################################################################################
# Platform checks
################################################################################
if (UNIX AND NOT APPLE)
	set (LINUX TRUE)
endif ()
if (LINUX)
	message(STATUS ">>> Linux / UNIX Detected")
	set (cb_INSTALL_PATH "bin")
	set (cb_CONFIG_PATH "/etc")
	set (cb_LOG_PATH "/var/log/cboil")
elseif (APPLE)
	message(STATUS ">>> Apple Detected")
	set (cb_INSTALL_PATH "bin")
	set (cb_CONFIG_PATH "/usr/local/etc")
	set (cb_LOG_PATH "/usr/local/var/log/cboil")
elseif (WIN32)
	message(STATUS ">>> Windows Detected")
	set (cb_INSTALL_PATH "cboil")
	set (cb_CONFIG_PATH "/AppData/cboil")
	set (cb_LOG_PATH "/AppData/cboil")
else ()
	message(STATUS ">>> Unknown OS Detected")
endif ()
# Set the runtime data directory
# NOTE The path needs the trailing '/'
set (cb_RUNTIME_DATA_PATH "${cb_DATA_PATH}/data/")
################################################################################
# Versioning
################################################################################
set (cb_VERSION_MAJOR 0)
set (cb_VERSION_MINOR 1)
set (cb_VERSION_HOTFX 0)
# Pass version into source files
configure_file (
	"${PROJECT_SOURCE_DIR}/src/meta/meta.h.in"
	"${PROJECT_SOURCE_DIR}/src/meta/meta.h"
)
################################################################################
# Custom cached variables
#
# Debug mode - Use for more stdout verbosity
# Specify like so:
# cmake -DCB_DEBUG_MODE:BOOL=1 ..
################################################################################
set (CB_DEBUG_MODE 0 CACHE BOOL 1)
if (CB_DEBUG_MODE)
	message(STATUS ">>> cboil debug mode selected")
else ()
	message(STATUS ">>> cboil normal mode selected")
endif ()
################################################################################
# Dynamic configure header
#
# CMake modules
# INCLUDE (CheckIncludeFiles) 		<- For a specific system header file
# INCLUDE (CheckFunctionExists) 	<- For a function in any system header file
# INCLUDE (CheckSymbolExists)		<- For a function or macro in a file
# INCLUDE (CheckPrototypeDefinition)<- For a function in a specific header file
################################################################################
INCLUDE (CheckSymbolExists)
# Example usage of CheckSymbolExists
# Check for bzero <- HAVE_BZERO
CHECK_SYMBOL_EXISTS(bzero
	"string.h"
	HAVE_BZERO)
if (LINUX AND HAVE_BZERO)
	set(HAVE_LINUX_BZERO 1)
	message(STATUS ">>> Linux / UNIX BZERO Found")
elseif (HAVE_BZERO)
	message(STATUS ">>> BZERO Found")
else ()
	message(STATUS ">>> No BZERO Found")
endif ()
# Set the dynamic configure file
CONFIGURE_FILE(
	${CMAKE_CURRENT_SOURCE_DIR}/src/config.h.in
	${CMAKE_CURRENT_BINARY_DIR}/config.h
)
################################################################################
# Compilation Flags
################################################################################
if (LINUX)
	# Adding the feature test macro POSIX_C_SOURCE
	add_definitions(-std=c11 -D_POSIX_C_SOURCE=200809L)
else ()
	add_definitions(-std=c11)
endif ()
################################################################################
# Source Files
# Update this section with new source files as they are added to the project
################################################################################
add_executable(cboil
	src/cb.c
	src/util/util.c
	src/skeleton/skeleton.c
)
################################################################################
# Linked Libraries
################################################################################
if (LINUX)
	#target_link_libraries(cboil "-pthread")
endif ()
################################################################################
# Installation
#
# The CMAKE_INSTALL_PREFIX is prepended to each installation directory and
# defaults to the following:
# UNIX		/usr/local
# Windows	c:/Program Files
# The cboil binary is specified by the RUNTIME target and in installed in /bin
################################################################################
# Binaries
install(TARGETS cboil RUNTIME DESTINATION ${cb_INSTALL_PATH})
# Configuration files
install(FILES config/cboil.ini DESTINATION ${cb_CONFIG_PATH})
# Log files
install(FILES config/cboil.log DESTINATION ${cb_LOG_PATH})
