# libaesni

*libaesni* is a small library providing an implementation of AES primitives
using the x86 AES-NI instructions.

The code is published under the [MIT license](LICENSE).

Only use *libaesni* if you know what you are doing.


## Build

*libaesni* can be built as follows:

    $ git clone --recursive https://github.com/lenerd/libaesni.git
    $ cd libaesni
    $ mkdir build_release
    $ cd build_release
    $ cmake .. -DCMAKE_BUILD_TYPE=Release
    $ make

We use [googletest](https://github.com/google/googletest) and
[benchmark](https://github.com/google/benchmark) for unit tests and benchmarks,
respectively.  Building theses can be disabled using the `-DLIBAESNI_TEST=Off`
option with `cmake`.  In that case, the `--recursive` can also be omitted.

## Benchmarks

Here, we compare the performance of *libaesni* with the OpenSSL implementation
using the [included benchmarks](bench/) and the OpenSSL speed tool:

### Blockwise Application of the AES Permutation (ECB Mode)

The AES permutation is applied blockwise to buffers from 16B (single block) to
16384B (1024 blocks).  The values were obtained by  running:

* `./bench/bench --benchmark_filter=BM_AES_128_ECB/`
* `openssl speed -elapsed -evp aes-128-ecb`

**Intel(R) Core(TM) i7-3520M CPU @ 2.90GHz (Ivy Bridge)**

| Implementation |         16B |         64B |        256B |       1024B |       4096B |      16384B |
|----------------|-------------|-------------|-------------|-------------|-------------|-------------|
| libaesni       | 374.524MB/s | 1.11362GB/s | 2.38834GB/s | 3.34417GB/s | 3.54524GB/s | 3.62803GB/s |
| OpenSSL        | 616.952MB/s | 1.77097GB/s | 3.13291GB/s | 3.57786GB/s | 3.70504GB/s | 3.71732GB/s |


**Intel(R) Core(TM) i7-4770K CPU @ 3.50GHz (Haswell)**

| Implementation |         16B |         64B |        256B |       1024B |       4096B |      16384B |
|----------------|-------------|-------------|-------------|-------------|-------------|-------------|
| libaesni       | 411.752MB/s | 1.23252GB/s | 3.08868GB/s | 4.74336GB/s | 5.38624GB/s | 5.58579GB/s |
| OpenSSL        | 772.393MB/s | 2.92154GB/s | 4.56934GB/s | 5.27706GB/s | 5.51819GB/s | 5.53285GB/s |
