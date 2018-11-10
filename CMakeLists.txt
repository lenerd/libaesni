cmake_minimum_required(VERSION 3.0)

project(libaesni
    VERSION 0.1
    DESCRIPTION "Thin wrapper around AES-NI instructions."
    LANGUAGES C CXX ASM
)

option(LIBAESNI_TEST "build tests and benchmarks" ON)

add_library(libaesni
    src/aesni.s
)
set_target_properties(libaesni PROPERTIES OUTPUT_NAME aesni)
target_include_directories(libaesni INTERFACE include)

if(LIBAESNI_TEST)
    add_subdirectory(extern/googletest/googletest)
    add_subdirectory(test)

    set(BENCHMARK_ENABLE_TESTING OFF CACHE BOOL "Suppressing benchmark's tests" FORCE)
    add_subdirectory(extern/benchmark)
    add_subdirectory(bench)
endif()
