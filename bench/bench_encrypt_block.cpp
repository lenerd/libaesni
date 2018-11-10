#include <array>
#include <benchmark/benchmark.h>
#include "libaesni/aesni.h"

using namespace libaesni;

static void BM_AES_128_ECB_single_blocks(benchmark::State& state)
{
    const std::array<uint8_t, aesni_key_size_128> key = {
        0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b,
        0x0c, 0x0d, 0x0e, 0x0f
    };
    std::array<uint8_t, aesni_round_keys_size_128> round_keys = {};
    aesni_key_expansion_128(round_keys.data(), key.data());

    std::vector<uint8_t> input_blocks(state.range(0));
    std::vector<uint8_t> output_blocks(state.range(0));
    for (auto _ : state)
    {
        aesni_key_expansion_128(round_keys.data(), key.data());
        for (size_t i = 0; i < input_blocks.size(); i += aesni_block_size)
        {
            aesni_encrypt_block_128(output_blocks.data() + i,
                    input_blocks.data() + i, round_keys.data());
        }
    }
    state.SetBytesProcessed(int64_t(state.iterations()) *
            int64_t(state.range(0)));
}
BENCHMARK(BM_AES_128_ECB_single_blocks)->RangeMultiplier(4)->Range(16, 1 << 14);


static void BM_AES_256_ECB_single_blocks(benchmark::State& state)
{
    const std::array<uint8_t, aesni_key_size_256> key = {
        0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b,
        0x0c, 0x0d, 0x0e, 0x0f
    };
    std::array<uint8_t, aesni_round_keys_size_256> round_keys = {};
    aesni_key_expansion_256(round_keys.data(), key.data());

    std::vector<uint8_t> input_blocks(state.range(0));
    std::vector<uint8_t> output_blocks(state.range(0));
    for (auto _ : state)
    {
        aesni_key_expansion_256(round_keys.data(), key.data());
        for (size_t i = 0; i < input_blocks.size(); i += aesni_block_size)
        {
            aesni_encrypt_block_256(output_blocks.data() + i,
                    input_blocks.data() + i, round_keys.data());
        }
    }
    state.SetBytesProcessed(int64_t(state.iterations()) *
            int64_t(state.range(0)));
}
BENCHMARK(BM_AES_256_ECB_single_blocks)->RangeMultiplier(4)->Range(16, 1 << 14);
