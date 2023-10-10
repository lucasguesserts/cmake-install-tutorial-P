cmake_minimum_required(VERSION 3.26)

project(
    P
    VERSION 0.0.0
    LANGUAGES CXX
)

# Prevent building in the source directory
if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(FATAL_ERROR "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there.\n")
endif()

# build options
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug")
endif()

# dependencies
include(cmake/get_cpm.cmake)
CPMAddPackage(
    NAME fmt
    GITHUB_REPOSITORY fmtlib/fmt
    GIT_TAG 10.1.1
    OPTIONS "CMAKE_CXX_FLAGS -fPIC"
)

# local dependencies
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/")
set(Q_VERSION 0.0.0)
find_package(Q
    ${Q_VERSION} EXACT
    REQUIRED
)

# setup library
set(PROJECT_INCLUDE_DIRECTORY "include")
set(SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src)
set(
    PROJECT_SOURCE_FILES
    ${SOURCE_DIR}/ClassP.cpp
)
add_library(${PROJECT_NAME} SHARED ${PROJECT_SOURCE_FILES})
target_include_directories(
    ${PROJECT_NAME}
    PUBLIC
        $<INSTALL_INTERFACE:${PROJECT_INCLUDE_DIRECTORY}>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/${PROJECT_INCLUDE_DIRECTORY}>
)
target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_17)
set_target_properties(
    ${PROJECT_NAME}
    PROPERTIES
        ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
        LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
        RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)
target_link_libraries(
    ${PROJECT_NAME}
    PRIVATE fmt::fmt
    PUBLIC Q::Q
)
add_library(${PROJECT_NAME}::${PROJECT_NAME} ALIAS ${PROJECT_NAME})

# install
include(GNUInstallDirs)
set(HEADER_DESTINATION ${PROJECT_INCLUDE_DIRECTORY})
set(CMAKE_CONFIG_INSTALL_DIR ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})

## library
install(
    TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}Targets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    INCLUDES DESTINATION ${HEADER_DESTINATION}
    PUBLIC_HEADER DESTINATION ${HEADER_DESTINATION}
)
install(
  EXPORT ${PROJECT_NAME}Targets
  FILE ${PROJECT_NAME}Targets.cmake
  NAMESPACE ${PROJECT_NAME}::
  DESTINATION ${CMAKE_CONFIG_INSTALL_DIR}
)

## version header
set(VERSION_FILE_PATH "${CMAKE_CURRENT_BINARY_DIR}/${HEADER_DESTINATION}/${PROJECT_NAME}/version.hpp")
configure_file(
    ${CMAKE_CURRENT_LIST_DIR}/cmake/version.hpp.in
    ${VERSION_FILE_PATH}
    @ONLY
)
install(
    FILES ${VERSION_FILE_PATH}
    DESTINATION ${HEADER_DESTINATION}/${PROJECT_NAME}
)

# include dir
install(
    DIRECTORY ${PROJECT_INCLUDE_DIRECTORY}/${PROJECT_NAME}
    DESTINATION ${HEADER_DESTINATION}
)

# ConfigVersion.cmake
include(CMakePackageConfigHelpers)
write_basic_package_version_file(
    ${PROJECT_NAME}ConfigVersion.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY ExactVersion
)
configure_package_config_file(
    ${CMAKE_CURRENT_LIST_DIR}/cmake/${PROJECT_NAME}Config.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
    INSTALL_DESTINATION ${CMAKE_CONFIG_INSTALL_DIR}
)
install(
    FILES
        ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
    DESTINATION ${CMAKE_CONFIG_INSTALL_DIR}
)

# Find dependencies
install(
    FILES ${CMAKE_CURRENT_SOURCE_DIR}/cmake/FindQ.cmake
    DESTINATION ${CMAKE_CONFIG_INSTALL_DIR}
)


# logs
message("\n")
message("---- Project ${PROJECT_NAME} ----")
message("Version               = ${PROJECT_VERSION}")
message("C++ compiler          = ${CMAKE_CXX_COMPILER}")
message("Compiler version      = ${CMAKE_CXX_COMPILER_VERSION}")
message("\n")
