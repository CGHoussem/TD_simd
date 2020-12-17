	.file	"dotprod_2.c"
	.text
	.p2align 4
	.globl	dotprod
	.type	dotprod, @function
dotprod:
.LFB0:
	.cfi_startproc
	endbr64
	movq	%rdx, %rax
	pxor	%xmm0, %xmm0
	andl	$1, %eax
	je	.L2
	movsd	(%rdi), %xmm0
	mulsd	(%rsi), %xmm0
.L2:
	cmpq	%rax, %rdx
	jbe	.L1
	leaq	-1(%rdx), %rcx
	subq	%rax, %rcx
	cmpq	$-1, %rdx
	je	.L9
	cmpq	$1, %rcx
	jbe	.L9
	salq	$3, %rax
	shrq	%rcx
	movq	%xmm0, %xmm1
	xorl	%edx, %edx
	addq	%rax, %rdi
	addq	%rax, %rsi
	addq	$1, %rcx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L5:
	movupd	(%rsi,%rax), %xmm0
	movupd	(%rdi,%rax), %xmm3
	addq	$1, %rdx
	addq	$16, %rax
	mulpd	%xmm3, %xmm0
	addpd	%xmm0, %xmm1
	cmpq	%rcx, %rdx
	jb	.L5
	movapd	%xmm1, %xmm0
	unpckhpd	%xmm1, %xmm1
.L7:
	addsd	%xmm1, %xmm0
.L1:
	ret
	.p2align 4,,10
	.p2align 3
.L9:
	pxor	%xmm1, %xmm1
	.p2align 4,,10
	.p2align 3
.L4:
	movsd	(%rsi,%rax,8), %xmm2
	mulsd	(%rdi,%rax,8), %xmm2
	addsd	%xmm2, %xmm0
	movsd	8(%rsi,%rax,8), %xmm2
	mulsd	8(%rdi,%rax,8), %xmm2
	addq	$2, %rax
	addsd	%xmm2, %xmm1
	cmpq	%rax, %rdx
	ja	.L4
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
