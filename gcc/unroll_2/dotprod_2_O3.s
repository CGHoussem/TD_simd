	.file	"dotprod_2.c"
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
	movsd	(%rdi), %xmm2
	mulsd	(%rsi), %xmm2
	pxor	%xmm1, %xmm1
	movapd	%xmm2, %xmm3
	addsd	%xmm1, %xmm3
	cmpq	%rcx, %rdx
	jbe	.L10
.L21:
	leaq	-1(%rdx), %r10
	subq	%rcx, %r10
	cmpq	$-1, %rdx
	je	.L11
	cmpq	$3, %r10
	jbe	.L11
	shrq	%r10
	leaq	0(,%rcx,8), %r8
	xorl	%eax, %eax
	xorl	%edx, %edx
	addq	$1, %r10
	leaq	(%rdi,%r8), %r9
	movapd	%xmm1, %xmm0
	addq	%rsi, %r8
	movq	%r10, %r11
	shrq	%r11
	.p2align 4,,10
	.p2align 3
.L5:
	movupd	(%r9,%rax), %xmm2
	movupd	(%r8,%rax), %xmm1
	addq	$1, %rdx
	movhpd	16(%r8,%rax), %xmm1
	movhpd	16(%r9,%rax), %xmm2
	mulpd	%xmm1, %xmm2
	movupd	16(%r9,%rax), %xmm1
	movlpd	8(%r9,%rax), %xmm1
	addsd	%xmm2, %xmm3
	unpckhpd	%xmm2, %xmm2
	addsd	%xmm2, %xmm3
	movupd	16(%r8,%rax), %xmm2
	movlpd	8(%r8,%rax), %xmm2
	addq	$32, %rax
	mulpd	%xmm2, %xmm1
	addsd	%xmm1, %xmm0
	unpckhpd	%xmm1, %xmm1
	addsd	%xmm1, %xmm0
	cmpq	%r11, %rdx
	jb	.L5
	movq	%r10, %rdx
	andq	$-2, %rdx
	leaq	(%rcx,%rdx,2), %rax
	cmpq	%r10, %rdx
	je	.L3
	movsd	(%rsi,%rax,8), %xmm1
	mulsd	(%rdi,%rax,8), %xmm1
	addsd	%xmm1, %xmm3
	movsd	8(%rsi,%rax,8), %xmm1
	mulsd	8(%rdi,%rax,8), %xmm1
	addsd	%xmm1, %xmm0
.L3:
	addsd	%xmm3, %xmm0
	ret
	.p2align 4,,10
	.p2align 3
.L9:
	pxor	%xmm1, %xmm1
	movapd	%xmm1, %xmm3
	cmpq	%rcx, %rdx
	ja	.L21
.L10:
	movapd	%xmm1, %xmm0
	addsd	%xmm3, %xmm0
	ret
	.p2align 4,,10
	.p2align 3
.L11:
	movapd	%xmm1, %xmm0
	.p2align 4,,10
	.p2align 3
.L4:
	movsd	(%rsi,%rcx,8), %xmm1
	mulsd	(%rdi,%rcx,8), %xmm1
	addsd	%xmm1, %xmm3
	movsd	8(%rsi,%rcx,8), %xmm1
	mulsd	8(%rdi,%rcx,8), %xmm1
	addq	$2, %rcx
	addsd	%xmm1, %xmm0
	cmpq	%rcx, %rdx
	ja	.L4
	addsd	%xmm3, %xmm0
	ret
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
