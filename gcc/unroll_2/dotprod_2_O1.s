	.file	"dotprod_2.c"
	.text
	.globl	dotprod
	.type	dotprod, @function
dotprod:
.LFB0:
	.cfi_startproc
	endbr64
	pxor	%xmm0, %xmm0
	movq	%rdx, %rax
	andl	$1, %eax
	je	.L2
	movsd	(%rdi), %xmm0
	mulsd	(%rsi), %xmm0
	addsd	.LC0(%rip), %xmm0
.L2:
	cmpq	%rax, %rdx
	jbe	.L6
	pxor	%xmm2, %xmm2
.L4:
	movsd	(%rdi,%rax,8), %xmm1
	mulsd	(%rsi,%rax,8), %xmm1
	addsd	%xmm1, %xmm0
	movsd	8(%rdi,%rax,8), %xmm1
	mulsd	8(%rsi,%rax,8), %xmm1
	addsd	%xmm1, %xmm2
	addq	$2, %rax
	cmpq	%rax, %rdx
	ja	.L4
.L3:
	addsd	%xmm2, %xmm0
	ret
.L6:
	pxor	%xmm2, %xmm2
	jmp	.L3
	.cfi_endproc
.LFE0:
	.size	dotprod, .-dotprod
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	0
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
