	.file	"dotprod_4.c"
	.text
	.p2align 4
	.globl	dotprod
	.type	dotprod, @function
dotprod:
.LFB0:
	.cfi_startproc
	endbr64
	movq	%rdx, %rax
	andl	$1, %eax
	je	.L5
	movsd	(%rdi), %xmm2
	mulsd	(%rsi), %xmm2
	pxor	%xmm3, %xmm3
	addsd	%xmm3, %xmm2
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L4:
	movsd	(%rdi,%rax,8), %xmm1
	mulsd	(%rsi,%rax,8), %xmm1
	addq	$4, %rax
	addsd	%xmm1, %xmm2
.L7:
	cmpq	%rax, %rdx
	ja	.L4
	addq	$1, %rax
	movsd	(%rdi,%rax,8), %xmm0
	mulsd	(%rsi,%rax,8), %xmm0
	leaq	0(,%rax,8), %rdx
	addsd	%xmm3, %xmm0
	addsd	%xmm0, %xmm2
	movsd	8(%rdi,%rdx), %xmm0
	mulsd	8(%rsi,%rdx), %xmm0
	addsd	%xmm3, %xmm0
	addsd	%xmm2, %xmm0
	movsd	16(%rdi,%rdx), %xmm2
	mulsd	16(%rsi,%rdx), %xmm2
	addsd	%xmm3, %xmm2
	addsd	%xmm2, %xmm0
	ret
	.p2align 4,,10
	.p2align 3
.L5:
	pxor	%xmm3, %xmm3
	movapd	%xmm3, %xmm2
	jmp	.L7
	.cfi_endproc
.LFE0:
	.size	dotprod, .-dotprod
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
