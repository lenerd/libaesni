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
