cmake_minimum_required(VERSION 3.0)

project(libaesni
    VERSION 0.1
    DESCRIPTION "Thin wrapper around AES-NI instructions."
    LANGUAGES C CXX ASM
)

option(LIBAESNI_TEST "build tests and benchmarks" Off)

add_library(libaesni
    src/aesni.s
)
add_library(libaesni::libaesni ALIAS libaesni)
set_target_properties(libaesni PROPERTIES OUTPUT_NAME aesni)
# target_include_directories(libaesni INTERFACE include)
target_include_directories(libaesni INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)

install(TARGETS libaesni
        EXPORT "${PROJECT_NAME}Targets"
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib
        INCLUDES DESTINATION include
)
install(DIRECTORY "${PROJECT_SOURCE_DIR}/include/"
        DESTINATION include
        FILES_MATCHING PATTERN "*.h"
)

export(TARGETS libaesni NAMESPACE "${PROJECT_NAME}::" FILE "${PROJECT_NAME}Targets.cmake")
install(EXPORT "${PROJECT_NAME}Targets"
        NAMESPACE "${PROJECT_NAME}::"
        DESTINATION "lib/cmake/${PROJECT_NAME}"
)

include(CMakePackageConfigHelpers)

configure_package_config_file("${PROJECT_SOURCE_DIR}/cmake/${PROJECT_NAME}Config.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
    INSTALL_DESTINATION "lib/cmake//${PROJECT_NAME}"
)
install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
    DESTINATION "lib/cmake/${PROJECT_NAME}"
)


if(LIBAESNI_TEST)
    add_subdirectory(extern/googletest/googletest)
    add_subdirectory(test)

    set(BENCHMARK_ENABLE_TESTING OFF CACHE BOOL "Suppressing benchmark's tests" FORCE)
    add_subdirectory(extern/benchmark)
    add_subdirectory(bench)
endif()
