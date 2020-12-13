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
	je	.L8
	movsd	(%rdi), %xmm0
	mulsd	(%rsi), %xmm0
	movl	$16, %eax
.L2:
	cmpq	%rcx, %rdx
	jbe	.L3
	leaq	-1(%rdx), %r10
	subq	%rcx, %r10
	cmpq	$-1, %rdx
	je	.L11
	cmpq	$7, %r10
	jbe	.L11
	shrq	$2, %r10
	xorl	%eax, %eax
	pxor	%xmm3, %xmm3
	xorl	%r8d, %r8d
	leaq	0(,%rcx,8), %r9
	leaq	(%rdi,%r9), %r11
	addq	%rsi, %r9
	.p2align 4,,10
	.p2align 3
.L5:
	movupd	(%r9,%rax), %xmm1
	movupd	(%r11,%rax), %xmm2
	addq	$1, %r8
	movhpd	16(%r9,%rax), %xmm1
	movhpd	16(%r11,%rax), %xmm2
	addq	$32, %rax
	mulpd	%xmm2, %xmm1
	addpd	%xmm1, %xmm3
	cmpq	%r10, %r8
	jb	.L5
	movapd	%xmm3, %xmm1
	leaq	(%rcx,%r10,4), %rax
	unpckhpd	%xmm3, %xmm1
	leaq	2(%rax), %rcx
	addpd	%xmm1, %xmm3
	movsd	(%rsi,%rax,8), %xmm1
	mulsd	(%rdi,%rax,8), %xmm1
	addsd	%xmm1, %xmm0
	addsd	%xmm3, %xmm0
	cmpq	%rdx, %rcx
	jnb	.L7
	movsd	(%rsi,%rcx,8), %xmm1
	mulsd	(%rdi,%rcx,8), %xmm1
	leaq	4(%rax), %rcx
	addsd	%xmm1, %xmm0
.L7:
	leaq	8(,%rcx,8), %rax
.L3:
	movsd	(%rdi,%rax), %xmm1
	mulsd	(%rsi,%rax), %xmm1
	addsd	%xmm1, %xmm0
	ret
	.p2align 4,,10
	.p2align 3
.L11:
	movsd	(%rsi,%rcx,8), %xmm1
	mulsd	(%rdi,%rcx,8), %xmm1
	addq	$2, %rcx
	addsd	%xmm1, %xmm0
	cmpq	%rcx, %rdx
	ja	.L11
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L8:
	movl	$8, %eax
	pxor	%xmm0, %xmm0
	jmp	.L2
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
