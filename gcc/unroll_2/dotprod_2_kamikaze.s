	.file	"dotprod_2.c"
	.text
	.p2align 4
	.globl	dotprod
	.type	dotprod, @function
dotprod:
.LFB0:
	.cfi_startproc
	endbr64
	movq	%rdx, %r10
	andl	$1, %r10d
	vxorpd	%xmm0, %xmm0, %xmm0
	je	.L2
	vmovsd	(%rdi), %xmm0
	vmulsd	(%rsi), %xmm0, %xmm0
.L2:
	cmpq	%r10, %rdx
	jbe	.L96
	leaq	-1(%rdx), %rcx
	subq	%r10, %rcx
	cmpq	$-1, %rdx
	je	.L9
	cmpq	$1, %rcx
	jbe	.L9
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	shrq	%rcx
	leaq	0(,%r10,8), %rdx
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	.cfi_offset 3, -24
	incq	%rcx
	leaq	(%rdi,%rdx), %r8
	movq	%rcx, %rbx
	vmovupd	(%r8), %ymm7
	shrq	%rbx
	addq	%rsi, %rdx
	vmovq	%xmm0, %xmm9
	leaq	-1(%rbx), %r11
	vfmadd231pd	(%rdx), %ymm7, %ymm9
	andl	$7, %r11d
	movl	$1, %r9d
	movl	$32, %eax
	cmpq	$1, %rbx
	jbe	.L91
	testq	%r11, %r11
	je	.L5
	cmpq	$1, %r11
	je	.L68
	cmpq	$2, %r11
	je	.L69
	cmpq	$3, %r11
	je	.L70
	cmpq	$4, %r11
	je	.L71
	cmpq	$5, %r11
	je	.L72
	cmpq	$6, %r11
	je	.L73
	vmovupd	32(%r8), %ymm2
	movl	$2, %r9d
	vfmadd231pd	32(%rdx), %ymm2, %ymm9
	movl	$64, %eax
.L73:
	vmovupd	(%r8,%rax), %ymm4
	incq	%r9
	vfmadd231pd	(%rdx,%rax), %ymm4, %ymm9
	addq	$32, %rax
.L72:
	vmovupd	(%r8,%rax), %ymm3
	incq	%r9
	vfmadd231pd	(%rdx,%rax), %ymm3, %ymm9
	addq	$32, %rax
.L71:
	vmovupd	(%r8,%rax), %ymm1
	incq	%r9
	vfmadd231pd	(%rdx,%rax), %ymm1, %ymm9
	addq	$32, %rax
.L70:
	vmovupd	(%r8,%rax), %ymm5
	incq	%r9
	vfmadd231pd	(%rdx,%rax), %ymm5, %ymm9
	addq	$32, %rax
.L69:
	vmovupd	(%r8,%rax), %ymm6
	incq	%r9
	vfmadd231pd	(%rdx,%rax), %ymm6, %ymm9
	addq	$32, %rax
.L68:
	vmovupd	(%r8,%rax), %ymm8
	incq	%r9
	vfmadd231pd	(%rdx,%rax), %ymm8, %ymm9
	addq	$32, %rax
	cmpq	%r9, %rbx
	jbe	.L91
.L5:
	vmovupd	(%r8,%rax), %ymm10
	vmovupd	32(%r8,%rax), %ymm11
	vfmadd231pd	(%rdx,%rax), %ymm10, %ymm9
	vmovupd	64(%r8,%rax), %ymm12
	vmovupd	96(%r8,%rax), %ymm13
	vmovupd	128(%r8,%rax), %ymm14
	vmovupd	160(%r8,%rax), %ymm15
	vfmadd231pd	32(%rdx,%rax), %ymm11, %ymm9
	vmovupd	192(%r8,%rax), %ymm0
	vmovupd	224(%r8,%rax), %ymm7
	addq	$8, %r9
	vfmadd231pd	64(%rdx,%rax), %ymm12, %ymm9
	vfmadd231pd	96(%rdx,%rax), %ymm13, %ymm9
	vfmadd231pd	128(%rdx,%rax), %ymm14, %ymm9
	vfmadd231pd	160(%rdx,%rax), %ymm15, %ymm9
	vfmadd231pd	192(%rdx,%rax), %ymm0, %ymm9
	vfmadd231pd	224(%rdx,%rax), %ymm7, %ymm9
	addq	$256, %rax
	cmpq	%r9, %rbx
	ja	.L5
.L91:
	vextractf128	$0x1, %ymm9, %xmm3
	movq	%rcx, %rbx
	vunpckhpd	%xmm9, %xmm9, %xmm5
	vunpckhpd	%xmm3, %xmm3, %xmm6
	andq	$-2, %rbx
	vaddsd	%xmm3, %xmm9, %xmm8
	leaq	(%r10,%rbx,2), %rdx
	vaddsd	%xmm6, %xmm5, %xmm9
	cmpq	%rcx, %rbx
	je	.L92
	vmovsd	(%rsi,%rdx,8), %xmm10
	vmovsd	8(%rsi,%rdx,8), %xmm11
	vfmadd231sd	(%rdi,%rdx,8), %xmm10, %xmm8
	vfmadd231sd	8(%rdi,%rdx,8), %xmm11, %xmm9
	vzeroupper
	popq	%rbx
	vaddsd	%xmm9, %xmm8, %xmm0
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L92:
	.cfi_restore_state
	vzeroupper
	popq	%rbx
	vaddsd	%xmm9, %xmm8, %xmm0
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L9:
	.cfi_restore 3
	.cfi_restore 6
	movq	%r10, %r8
	notq	%r8
	vmovsd	(%rsi,%r10,8), %xmm12
	vmovsd	8(%rsi,%r10,8), %xmm1
	addq	%rdx, %r8
	shrq	%r8
	vxorpd	%xmm13, %xmm13, %xmm13
	leaq	2(%r10), %r11
	vfmadd231sd	(%rdi,%r10,8), %xmm12, %xmm0
	vfmadd132sd	8(%rdi,%r10,8), %xmm13, %xmm1
	andl	$7, %r8d
	cmpq	%r11, %rdx
	jbe	.L97
	testq	%r8, %r8
	je	.L4
	cmpq	$1, %r8
	je	.L62
	cmpq	$2, %r8
	je	.L63
	cmpq	$3, %r8
	je	.L64
	cmpq	$4, %r8
	je	.L65
	cmpq	$5, %r8
	je	.L66
	cmpq	$6, %r8
	je	.L67
	vmovsd	(%rsi,%r11,8), %xmm14
	vmovsd	8(%rsi,%r11,8), %xmm15
	vfmadd231sd	(%rdi,%r11,8), %xmm14, %xmm0
	vfmadd231sd	8(%rdi,%r11,8), %xmm15, %xmm1
	leaq	4(%r10), %r11
.L67:
	vmovsd	(%rsi,%r11,8), %xmm7
	vmovsd	8(%rsi,%r11,8), %xmm2
	vfmadd231sd	(%rdi,%r11,8), %xmm7, %xmm0
	vfmadd231sd	8(%rdi,%r11,8), %xmm2, %xmm1
	addq	$2, %r11
.L66:
	vmovsd	(%rsi,%r11,8), %xmm5
	vmovsd	8(%rsi,%r11,8), %xmm3
	vfmadd231sd	(%rdi,%r11,8), %xmm5, %xmm0
	vfmadd231sd	8(%rdi,%r11,8), %xmm3, %xmm1
	addq	$2, %r11
.L65:
	vmovsd	(%rsi,%r11,8), %xmm4
	vmovsd	8(%rsi,%r11,8), %xmm6
	vfmadd231sd	(%rdi,%r11,8), %xmm4, %xmm0
	vfmadd231sd	8(%rdi,%r11,8), %xmm6, %xmm1
	addq	$2, %r11
.L64:
	vmovsd	(%rsi,%r11,8), %xmm8
	vmovsd	8(%rsi,%r11,8), %xmm9
	vfmadd231sd	(%rdi,%r11,8), %xmm8, %xmm0
	vfmadd231sd	8(%rdi,%r11,8), %xmm9, %xmm1
	addq	$2, %r11
.L63:
	vmovsd	(%rsi,%r11,8), %xmm10
	vmovsd	8(%rsi,%r11,8), %xmm11
	vfmadd231sd	(%rdi,%r11,8), %xmm10, %xmm0
	vfmadd231sd	8(%rdi,%r11,8), %xmm11, %xmm1
	addq	$2, %r11
.L62:
	vmovsd	(%rsi,%r11,8), %xmm12
	vmovsd	8(%rsi,%r11,8), %xmm13
	vfmadd231sd	(%rdi,%r11,8), %xmm12, %xmm0
	vfmadd231sd	8(%rdi,%r11,8), %xmm13, %xmm1
	addq	$2, %r11
	cmpq	%r11, %rdx
	jbe	.L97
.L4:
	vmovsd	(%rsi,%r11,8), %xmm14
	vmovsd	8(%rsi,%r11,8), %xmm15
	vfmadd231sd	(%rdi,%r11,8), %xmm14, %xmm0
	vfmadd231sd	8(%rdi,%r11,8), %xmm15, %xmm1
	vmovsd	16(%rsi,%r11,8), %xmm7
	vmovsd	24(%rsi,%r11,8), %xmm2
	vmovsd	32(%rsi,%r11,8), %xmm5
	vfmadd231sd	16(%rdi,%r11,8), %xmm7, %xmm0
	vfmadd231sd	24(%rdi,%r11,8), %xmm2, %xmm1
	vmovsd	40(%rsi,%r11,8), %xmm3
	vmovsd	48(%rsi,%r11,8), %xmm4
	vmovsd	56(%rsi,%r11,8), %xmm6
	vfmadd231sd	32(%rdi,%r11,8), %xmm5, %xmm0
	vfmadd231sd	40(%rdi,%r11,8), %xmm3, %xmm1
	vmovsd	64(%rsi,%r11,8), %xmm8
	vmovsd	72(%rsi,%r11,8), %xmm9
	vmovsd	80(%rsi,%r11,8), %xmm10
	vfmadd231sd	48(%rdi,%r11,8), %xmm4, %xmm0
	vfmadd231sd	56(%rdi,%r11,8), %xmm6, %xmm1
	vmovsd	88(%rsi,%r11,8), %xmm11
	vmovsd	96(%rsi,%r11,8), %xmm12
	vmovsd	104(%rsi,%r11,8), %xmm13
	vfmadd231sd	64(%rdi,%r11,8), %xmm8, %xmm0
	vfmadd231sd	72(%rdi,%r11,8), %xmm9, %xmm1
	vmovsd	112(%rsi,%r11,8), %xmm14
	vmovsd	120(%rsi,%r11,8), %xmm15
	vfmadd231sd	80(%rdi,%r11,8), %xmm10, %xmm0
	vfmadd231sd	88(%rdi,%r11,8), %xmm11, %xmm1
	vfmadd231sd	96(%rdi,%r11,8), %xmm12, %xmm0
	vfmadd231sd	104(%rdi,%r11,8), %xmm13, %xmm1
	vfmadd231sd	112(%rdi,%r11,8), %xmm14, %xmm0
	vfmadd231sd	120(%rdi,%r11,8), %xmm15, %xmm1
	addq	$16, %r11
	cmpq	%r11, %rdx
	ja	.L4
.L97:
	vaddsd	%xmm1, %xmm0, %xmm0
	ret
	.p2align 4,,10
	.p2align 3
.L96:
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
