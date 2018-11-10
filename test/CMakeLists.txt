add_executable(unit_test
    test_main.cpp
    test_key_expansion.cpp
    test_encrypt_block.cpp
)
set_target_properties(unit_test PROPERTIES CXX_STANDARD 11)
target_compile_options(unit_test PRIVATE "-Wall" "-Wextra" "-pedantic")
target_link_libraries(unit_test libaesni)
target_link_libraries(unit_test gtest)


add_executable(include_test
    include_test.c
)
target_link_libraries(include_test libaesni)
set_target_properties(include_test PROPERTIES C_STANDARD 11)
target_compile_options(include_test PRIVATE "-Wall" "-Wextra" "-pedantic")
