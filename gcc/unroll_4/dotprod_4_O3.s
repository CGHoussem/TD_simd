	.file	"dotprod_4.c"
	.text
	.p2align 4
	.globl	dotprod
	.type	dotprod, @function
dotprod:
.LFB0:
	.cfi_startproc
	endbr64
	movq	%rdx, %rcx
	andl	$1, %ecx
	je	.L9
	movsd	(%rdi), %xmm9
	mulsd	(%rsi), %xmm9
	pxor	%xmm1, %xmm1
	addsd	%xmm1, %xmm9
	cmpq	%rcx, %rdx
	jbe	.L10
.L21:
	leaq	-1(%rdx), %r9
	subq	%rcx, %r9
	cmpq	$-4, %rdx
	ja	.L11
	cmpq	$7, %r9
	jbe	.L11
	shrq	$2, %r9
	movapd	%xmm1, %xmm0
	movapd	%xmm1, %xmm10
	xorl	%r8d, %r8d
	addq	$1, %r9
	leaq	0(,%rcx,8), %rax
	movapd	%xmm1, %xmm8
	movq	%r9, %r10
	leaq	(%rsi,%rax), %rdx
	addq	%rdi, %rax
	shrq	%r10
	.p2align 4,,10
	.p2align 3
.L5:
	movupd	(%rax), %xmm4
	movupd	(%rdx), %xmm12
	addq	$1, %r8
	addq	$64, %rdx
	movupd	32(%rax), %xmm3
	movupd	-32(%rdx), %xmm13
	addq	$64, %rax
	movhpd	-48(%rax), %xmm4
	movhpd	-48(%rdx), %xmm12
	movupd	-48(%rax), %xmm2
	movupd	-48(%rdx), %xmm5
	movhpd	-16(%rax), %xmm3
	movhpd	-16(%rdx), %xmm13
	movapd	%xmm4, %xmm7
	movlpd	-56(%rax), %xmm2
	movapd	%xmm12, %xmm6
	unpcklpd	%xmm3, %xmm7
	movlpd	-56(%rdx), %xmm5
	movupd	-16(%rdx), %xmm11
	unpcklpd	%xmm13, %xmm6
	movlpd	-24(%rdx), %xmm11
	movupd	-16(%rax), %xmm1
	unpckhpd	%xmm3, %xmm4
	mulpd	%xmm6, %xmm7
	movlpd	-24(%rax), %xmm1
	movapd	%xmm12, %xmm3
	unpckhpd	%xmm13, %xmm3
	mulpd	%xmm4, %xmm3
	movapd	%xmm7, %xmm6
	unpckhpd	%xmm7, %xmm7
	addsd	%xmm9, %xmm6
	movapd	%xmm7, %xmm9
	movapd	%xmm5, %xmm7
	unpckhpd	%xmm11, %xmm5
	unpcklpd	%xmm11, %xmm7
	addsd	%xmm3, %xmm10
	unpckhpd	%xmm3, %xmm3
	addsd	%xmm6, %xmm9
	movapd	%xmm2, %xmm6
	unpckhpd	%xmm1, %xmm2
	unpcklpd	%xmm1, %xmm6
	movapd	%xmm5, %xmm1
	addsd	%xmm3, %xmm10
	mulpd	%xmm7, %xmm6
	mulpd	%xmm2, %xmm1
	addsd	%xmm6, %xmm8
	unpckhpd	%xmm6, %xmm6
	addsd	%xmm1, %xmm0
	unpckhpd	%xmm1, %xmm1
	addsd	%xmm6, %xmm8
	addsd	%xmm1, %xmm0
	cmpq	%r10, %r8
	jb	.L5
	movq	%r9, %rax
	andq	$-2, %rax
	leaq	(%rcx,%rax,4), %rdx
	cmpq	%r9, %rax
	je	.L3
	movsd	(%rsi,%rdx,8), %xmm1
	mulsd	(%rdi,%rdx,8), %xmm1
	leaq	0(,%rdx,8), %rax
	addsd	%xmm1, %xmm9
	movsd	8(%rsi,%rax), %xmm1
	mulsd	8(%rdi,%rax), %xmm1
	addsd	%xmm1, %xmm8
	movsd	16(%rsi,%rax), %xmm1
	mulsd	16(%rdi,%rax), %xmm1
	addsd	%xmm1, %xmm10
	movsd	24(%rsi,%rax), %xmm1
	mulsd	24(%rdi,%rax), %xmm1
	addsd	%xmm1, %xmm0
.L3:
	movapd	%xmm8, %xmm6
	addsd	%xmm9, %xmm6
	movapd	%xmm6, %xmm3
	addsd	%xmm10, %xmm3
	addsd	%xmm3, %xmm0
	ret
	.p2align 4,,10
	.p2align 3
.L9:
	pxor	%xmm1, %xmm1
	movapd	%xmm1, %xmm9
	cmpq	%rcx, %rdx
	ja	.L21
.L10:
	movapd	%xmm1, %xmm0
	movapd	%xmm1, %xmm10
	movapd	%xmm1, %xmm8
	jmp	.L3
	.p2align 4,,10
	.p2align 3
.L11:
	movapd	%xmm1, %xmm0
	movapd	%xmm1, %xmm10
	movapd	%xmm1, %xmm8
	.p2align 4,,10
	.p2align 3
.L4:
	movsd	(%rsi,%rcx,8), %xmm1
	mulsd	(%rdi,%rcx,8), %xmm1
	addsd	%xmm1, %xmm9
	movsd	8(%rsi,%rcx,8), %xmm1
	mulsd	8(%rdi,%rcx,8), %xmm1
	addsd	%xmm1, %xmm8
	movsd	16(%rsi,%rcx,8), %xmm1
	mulsd	16(%rdi,%rcx,8), %xmm1
	addsd	%xmm1, %xmm10
	movsd	24(%rsi,%rcx,8), %xmm1
	mulsd	24(%rdi,%rcx,8), %xmm1
	addq	$4, %rcx
	addsd	%xmm1, %xmm0
	cmpq	%rcx, %rdx
	ja	.L4
	jmp	.L3
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
