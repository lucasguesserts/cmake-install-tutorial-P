# FindQ.cmake
#
# Instructions for using this file:
# 1. Copy this file, 'FindQ.cmake', to the directory '${CMAKE_SOURCE_DIR}/cmake/'.
# 2. Set Q's install path. By default it is '$ENV{HOME}/goo'.
#   If it is not installed there, you can do one of the following:
#   2.1. Set the environment variable 'Q_HOME' to the directory where Q is installed.
#   2.2. Set the variable 'Q_HOME' to the directory where Q is installed.
# 3. Set the variable 'Q_VERBOSE' to 'ON' if you want to see some extra info of this file.
# 4. Add the following lines to your 'CMakeLists.txt' file:
#   set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")
#   find_package(Q REQUIRED)
#   target_link_libraries(${ANY_LIBRARY_OF_YOURS} PUBLIC Q::Q)
#
# Target created by this file:
#   Q::Q: The Q library.
#
# Variables set by this file:
#   1. Q_INCLUDE_DIR: The directory where the header files of Q are located.
#   2. Q_LIBRARY: The path to the Q library.
#   4. Q_FOUND: True if Q is found, false otherwise.
# Normally, one does not need to use these variables directly,
# because one can use the targets Q::Q.

cmake_minimum_required(VERSION 3.26)

# auxiliary variables
set(Q_DEFAULT_INSTALL_DIR "$ENV{HOME}/goo")
set(Q_HINTS ${Q_HOME} $ENV{Q_HOME} ${Q_DEFAULT_INSTALL_DIR})
set(Q_HEADER "Q/ClassQ.hpp")
set(Q_LIBRARY_TO_FIND "Q")

# find Q

find_path(
    Q_INCLUDE_DIR
    NAMES ${Q_HEADER}
    HINTS ${Q_HINTS}
    PATH_SUFFIXES include
    REQUIRED
    DOC "directory with the header files of Q"
)

find_library(
    Q_LIBRARY
    NAMES ${Q_LIBRARY_TO_FIND}
    HINTS ${Q_HINTS}
    PATH_SUFFIXES lib
    REQUIRED
    DOC "Q library"
)

mark_as_advanced(Q_INCLUDE_DIR Q_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    Q
    REQUIRED_VARS
        Q_INCLUDE_DIR
        Q_LIBRARY
)

# logs
if(Q_VERBOSE)
    message("")
    message("Find Q result:")
    message("Q_INCLUDE_DIR = ${Q_INCLUDE_DIR}")
    message("Q_LIBRARY = ${Q_LIBRARY}")
    message("Q_FOUND = ${Q_FOUND}")
    message("")
endif()

# check if header files exist
if(Q_FOUND AND NOT EXISTS "${Q_INCLUDE_DIR}/${Q_HEADER}")
    message(FATAL_ERROR "Q header file not found: ${Q_INCLUDE_DIR}/${Q_HEADER}")
endif()

# set targets
if(Q_FOUND)
    add_library(Q::Q INTERFACE IMPORTED)
    set_target_properties(Q::Q PROPERTIES IMPORTED_LOCATION ${Q_LIBRARY})
    target_include_directories(Q::Q SYSTEM INTERFACE ${Q_INCLUDE_DIR})
    target_link_libraries(Q::Q INTERFACE ${Q_LIBRARY})
endif()
