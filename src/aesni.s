.intel_syntax noprefix

.text

.globl aesni_available
aesni_available:
push rbx
mov eax, 0x01
cpuid
shr ecx, 25  # AES-NI
and ecx, 0x01
mov eax, ecx
pop rbx
ret


.macro aes_key_expand rcon
# old in xmm1
aeskeygenassist xmm3, xmm1, \rcon
pshufd xmm3, xmm3, 0xff
movdqa xmm2, xmm1
pslldq xmm2, 4
pxor xmm1, xmm2
pslldq xmm2, 4
pxor xmm1, xmm2
pslldq xmm2, 4
pxor xmm1, xmm2
pxor xmm1, xmm3
# new in xmm1
.endm


.globl aesni_key_expansion_128
aesni_key_expansion_128:
# rdi: pointer to output
# rsi: pointer to key
movdqa xmm1, [rsi]
movdqa [rdi], xmm1
aes_key_expand 0x01
movdqa 0x10[rdi], xmm1
aes_key_expand 0x02
movdqa 0x20[rdi], xmm1
aes_key_expand 0x04
movdqa 0x30[rdi], xmm1
aes_key_expand 0x08
movdqa 0x40[rdi], xmm1
aes_key_expand 0x10
movdqa 0x50[rdi], xmm1
aes_key_expand 0x20
movdqa 0x60[rdi], xmm1
aes_key_expand 0x40
movdqa 0x70[rdi], xmm1
aes_key_expand 0x80
movdqa 0x80[rdi], xmm1
aes_key_expand 0x1b
movdqa 0x90[rdi], xmm1
aes_key_expand 0x36
movdqa 0xa0[rdi], xmm1
ret


.macro aes_key_expand_256_1 rcon
# old in xmm1
aeskeygenassist xmm4, xmm2, \rcon
pshufd xmm4, xmm4, 0xff
movdqa xmm3, xmm1
pslldq xmm3, 4
pxor xmm1, xmm3
pslldq xmm3, 4
pxor xmm1, xmm3
pslldq xmm3, 4
pxor xmm1, xmm3
pxor xmm1, xmm4
# new in xmm1
.endm


.macro aes_key_expand_256_2
# old in xmm2
aeskeygenassist xmm4, xmm1, 0
pshufd xmm4, xmm4, 0xaa
movdqa xmm3, xmm2
pslldq xmm3, 4
pxor xmm2, xmm3
pslldq xmm3, 4
pxor xmm2, xmm3
pslldq xmm3, 4
pxor xmm2, xmm3
pxor xmm2, xmm4
# new in xmm2
.endm


.globl aesni_key_expansion_256
aesni_key_expansion_256:
# rdi: pointer to output
# rsi: pointer to key
movdqa xmm1, [rsi]
movdqa [rdi], xmm1
movdqa xmm2, 0x10[rsi]
movdqa 0x10[rdi], xmm2

aes_key_expand_256_1 0x01
movdqa 0x20[rdi], xmm1
aes_key_expand_256_2
movdqa 0x30[rdi], xmm2

aes_key_expand_256_1 0x02
movdqa 0x40[rdi], xmm1
aes_key_expand_256_2
movdqa 0x50[rdi], xmm2

aes_key_expand_256_1 0x04
movdqa 0x60[rdi], xmm1
aes_key_expand_256_2
movdqa 0x70[rdi], xmm2

aes_key_expand_256_1 0x08
movdqa 0x80[rdi], xmm1
aes_key_expand_256_2
movdqa 0x90[rdi], xmm2

aes_key_expand_256_1 0x10
movdqa 0xa0[rdi], xmm1
aes_key_expand_256_2
movdqa 0xb0[rdi], xmm2

aes_key_expand_256_1 0x20
movdqa 0xc0[rdi], xmm1
aes_key_expand_256_2
movdqa 0xd0[rdi], xmm2

aes_key_expand_256_1 0x40
movdqa 0xe0[rdi], xmm1

ret


.globl aesni_encrypt_block_128
aesni_encrypt_block_128:
# rdi: pointer to output
# rsi: pointer to input
# rdx: pointer to round keys
movdqa xmm0, [rsi]
pxor xmm0, [rdx]
aesenc xmm0, 0x10[rdx]
aesenc xmm0, 0x20[rdx]
aesenc xmm0, 0x30[rdx]
aesenc xmm0, 0x40[rdx]
aesenc xmm0, 0x50[rdx]
aesenc xmm0, 0x60[rdx]
aesenc xmm0, 0x70[rdx]
aesenc xmm0, 0x80[rdx]
aesenc xmm0, 0x90[rdx]
aesenclast xmm0, 0xa0[rdx]
movdqa [rdi], xmm0
ret


.globl aesni_encrypt_block_256
aesni_encrypt_block_256:
# rdi: pointer to output
# rsi: pointer to input
# rdx: pointer to round keys
movdqa xmm0, [rsi]
pxor xmm0, [rdx]
aesenc xmm0, 0x10[rdx]
aesenc xmm0, 0x20[rdx]
aesenc xmm0, 0x30[rdx]
aesenc xmm0, 0x40[rdx]
aesenc xmm0, 0x50[rdx]
aesenc xmm0, 0x60[rdx]
aesenc xmm0, 0x70[rdx]
aesenc xmm0, 0x80[rdx]
aesenc xmm0, 0x90[rdx]
aesenc xmm0, 0xa0[rdx]
aesenc xmm0, 0xb0[rdx]
aesenc xmm0, 0xc0[rdx]
aesenc xmm0, 0xd0[rdx]
aesenclast xmm0, 0xe0[rdx]
movdqa [rdi], xmm0
ret


.globl aesni_encrypt_blocks_128
aesni_encrypt_blocks_128:
# rdi: pointer to output
# rsi: pointer to input
# rdx: pointer to round keys
# rcx: number of blocks

movdqa xmm0, [rdx]
movdqa xmm1, 0x10[rdx]
movdqa xmm2, 0x20[rdx]
movdqa xmm3, 0x30[rdx]
movdqa xmm4, 0x40[rdx]
movdqa xmm5, 0x50[rdx]
movdqa xmm6, 0x60[rdx]
movdqa xmm7, 0x70[rdx]
movdqa xmm8, 0x80[rdx]
movdqa xmm9, 0x90[rdx]
movdqa xmm10, 0xa0[rdx]

jmp 1f

0:

movdqa xmm11, [rsi]
pxor xmm11, xmm0
aesenc xmm11, xmm1
aesenc xmm11, xmm2
aesenc xmm11, xmm3
aesenc xmm11, xmm4
aesenc xmm11, xmm5
aesenc xmm11, xmm6
aesenc xmm11, xmm7
aesenc xmm11, xmm8
aesenc xmm11, xmm9
aesenclast xmm11, xmm10
movdqa [rdi], xmm11

dec rcx
add rdi, 0x10
add rsi, 0x10

1:
test rcx, rcx
jnz 0b

ret
