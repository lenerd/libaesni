#ifndef LIBAESNI_AESNI_H
#define LIBAESNI_AESNI_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdbool.h>
#include <stddef.h>

#ifdef __cplusplus
namespace libaesni {
#endif

/**
 * Size of an AES block in bytes.
 */
const size_t aesni_block_size = 16;

/**
 * Size of an AES-128 key in bytes.
 */
const size_t aesni_key_size_128 = 16;

/**
 * Size of an AES-256 key in bytes.
 */
const size_t aesni_key_size_256 = 32;

/**
 * Size of the AES-128 round keys in bytes.
 */
const size_t aesni_round_keys_size_128 = 176;

/**
 * Size of an AES-256 round keys in bytes.
 */
const size_t aesni_round_keys_size_256 = 240;

/**
 * Check whether the AES-NI instructions are available using the cpuid
 * instruction.
 */
bool aesni_available();

/**
 * Run the AES key expansion algorithm to generate the round keys for 128 bit
 * keys.
 */
void aesni_key_expansion_128(void* round_keys, const void* key);

/**
 * Run the AES key expansion algorithm to generate the round keys for
 * decryption for 128 bit keys.
 */
void aesni_key_expansion_inv_128(void* round_keys, const void* key);

/**
 * Run the AES key expansion algorithm to generate the round keys for 256 bit
 * keys.
 */
void aesni_key_expansion_256(void* round_keys, const void* key);

/**
 * Run the AES-128 permutation on a single block of 16 byte.
 */
void aesni_encrypt_block_128(void* ciphertext, const void* plaintext, const void* round_keys);

/**
 * Run the AES-256 permutation on a single block of 16 byte.
 */
void aesni_encrypt_block_256(void* ciphertext, const void* plaintext, const void* round_keys);

/**
 * Run the AES-128 permutation on a number of block of 16 byte each.
 */
void aesni_encrypt_blocks_128(void* ciphertext, const void* plaintext, const void* round_keys,
                              size_t num_blocks);


/**
 * Run the inverse AES permutation on a single block of 16 byte.
 */
void aesni_decrypt_block_128(void* plaintext, const void* ciphertext, const void* round_keys);

#ifdef __cplusplus
}  // end namespace
}  // extern "C"
#endif

#endif /* LIBAESNI_AESNI_H */
