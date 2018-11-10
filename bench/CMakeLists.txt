add_executable(bench
    bench_main.cpp
)
set_target_properties(bench PROPERTIES CXX_STANDARD 11)
target_compile_options(bench PRIVATE "-Wall" "-Wextra" "-pedantic")
target_link_libraries(bench libaesni)
target_link_libraries(bench benchmark)
