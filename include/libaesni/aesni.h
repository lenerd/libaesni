#ifndef LIBAESNI_AESNI_H
#define LIBAESNI_AESNI_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdbool.h>

#ifdef __cplusplus
namespace libaesni {
#endif

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
 * Run the AES permutation on a single block of 16 byte.
 */
void aesni_encrypt_block_128(void* ciphertext, const void* plaintext, const void* round_keys);

/**
 * Run the inverse AES permutation on a single block of 16 byte.
 */
void aesni_decrypt_block_128(void* plaintext, const void* ciphertext, const void* round_keys);

#ifdef __cplusplus
}  // end namespace
}  // extern "C"
#endif

#endif /* LIBAESNI_AESNI_H */
