#include <array>
#include <gtest/gtest.h>
#include "libaesni/aesni.h"

using namespace libaesni;

// Test vectors from NIST FIPS 197, Appendix C

TEST(TestDecryptBlock, DecryptBlock128)
{
    const std::array<uint8_t, aesni_key_size_128> key = {
        0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b,
        0x0c, 0x0d, 0x0e, 0x0f
    };
    const std::array<uint8_t, aesni_block_size> input_block = {
        0x69, 0xc4, 0xe0, 0xd8, 0x6a, 0x7b, 0x04, 0x30, 0xd8, 0xcd, 0xb7, 0x80,
        0x70, 0xb4, 0xc5, 0x5a
    };
    const std::array<uint8_t, aesni_block_size> expected_output_block = {
        0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb,
        0xcc, 0xdd, 0xee, 0xff
    };
    std::array<uint8_t, aesni_block_size> output_block = {};

    std::array<uint8_t, aesni_round_keys_size_128> round_keys;
    aesni_key_expansion_inv_128(round_keys.data(), key.data());
    aesni_decrypt_block_128(output_block.data(), input_block.data(), round_keys.data());
    ASSERT_EQ(output_block, expected_output_block);
}
