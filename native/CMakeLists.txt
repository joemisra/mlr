cmake_minimum_required(VERSION 3.25)
set(CMAKE_OSX_ARCHITECTURES "x86_64;arm64" CACHE STRING "Max architectures")
project(MLRNativePrototype LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(sequence_player_tests sequence_player_tests.cpp)
target_compile_options(sequence_player_tests PRIVATE -Wall -Wextra -Werror)
enable_testing()
add_test(NAME sequence_player_core COMMAND sequence_player_tests)

# Keep SDK headers outside this repository/release. Core tests need no SDK.
set(MAX_SDK_PATH "" CACHE PATH "Path to Cycling74/max-sdk-base")
if(MAX_SDK_PATH)
    if(NOT APPLE)
        message(FATAL_ERROR "Prototype external packaging currently supports macOS only")
    endif()
    add_library(sequence_player MODULE sequence_player_max.cpp)
    target_include_directories(sequence_player PRIVATE "${MAX_SDK_PATH}/c74support/max-includes")
    target_link_options(sequence_player PRIVATE "-undefined" "dynamic_lookup")
    set_target_properties(sequence_player PROPERTIES BUNDLE TRUE BUNDLE_EXTENSION mxo
        OUTPUT_NAME "mlr.sequence_player" PREFIX ""
        LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/.."
        MACOSX_BUNDLE_INFO_PLIST "${CMAKE_CURRENT_SOURCE_DIR}/Info.plist.in")
    add_custom_command(TARGET sequence_player POST_BUILD
        COMMAND codesign --force --sign - "$<TARGET_BUNDLE_DIR:sequence_player>" VERBATIM)
endif()
