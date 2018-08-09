cmake_minimum_required(VERSION 3.0)

project(libaesni
    VERSION 0.1
    DESCRIPTION "Thin wrapper around AES-NI instructions."
    LANGUAGES C CXX ASM
)

add_library(libaesni
    src/aesni.s
)
set_target_properties(libaesni PROPERTIES OUTPUT_NAME aesni)
target_include_directories(libaesni INTERFACE include)
