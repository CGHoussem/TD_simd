	.file	"dotprod_2.c"
	.text
	.p2align 4
	.globl	dotprod
	.type	dotprod, @function
dotprod:
.LFB0:
	.cfi_startproc
	endbr64
	movq	%rdx, %r11
	andl	$1, %r11d
	je	.L8
	vmovsd	(%rdi), %xmm0
	movl	$16, %r9d
	vmulsd	(%rsi), %xmm0, %xmm0
.L2:
	cmpq	%r11, %rdx
	jbe	.L74
	leaq	-1(%rdx), %r9
	subq	%r11, %r9
	cmpq	$-1, %rdx
	je	.L46
	cmpq	$7, %r9
	jbe	.L46
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	0(,%r11,8), %rax
	vmovupd	(%rsi,%rax), %ymm6
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	.cfi_offset 3, -24
	vmovupd	(%rdi,%rax), %ymm7
	shrq	$3, %r9
	vunpcklpd	32(%rsi,%rax), %ymm6, %ymm1
	vunpcklpd	32(%rdi,%rax), %ymm7, %ymm2
	leaq	-1(%r9), %rbx
	vpermpd	$216, %ymm1, %ymm1
	vpermpd	$216, %ymm2, %ymm4
	vxorpd	%xmm3, %xmm3, %xmm3
	movl	$1, %r10d
	leaq	(%rdi,%rax), %rcx
	leaq	(%rsi,%rax), %r8
	vfmadd132pd	%ymm4, %ymm3, %ymm1
	andl	$3, %ebx
	movl	$64, %eax
	cmpq	%r9, %r10
	jnb	.L69
	testq	%rbx, %rbx
	je	.L5
	cmpq	$1, %rbx
	je	.L55
	cmpq	$2, %rbx
	jne	.L79
.L56:
	vmovupd	(%r8,%rax), %ymm13
	vmovupd	(%rcx,%rax), %ymm6
	vunpcklpd	32(%r8,%rax), %ymm13, %ymm14
	vunpcklpd	32(%rcx,%rax), %ymm6, %ymm7
	vpermpd	$216, %ymm14, %ymm15
	vpermpd	$216, %ymm7, %ymm2
	vfmadd231pd	%ymm2, %ymm15, %ymm1
	incq	%r10
	addq	$64, %rax
.L55:
	vmovupd	(%r8,%rax), %ymm4
	vmovupd	(%rcx,%rax), %ymm5
	vunpcklpd	32(%r8,%rax), %ymm4, %ymm3
	vunpcklpd	32(%rcx,%rax), %ymm5, %ymm9
	vpermpd	$216, %ymm3, %ymm8
	vpermpd	$216, %ymm9, %ymm10
	incq	%r10
	vfmadd231pd	%ymm10, %ymm8, %ymm1
	addq	$64, %rax
	cmpq	%r9, %r10
	jnb	.L69
.L5:
	vmovupd	(%r8,%rax), %ymm11
	vmovupd	(%rcx,%rax), %ymm14
	vunpcklpd	32(%r8,%rax), %ymm11, %ymm12
	vunpcklpd	32(%rcx,%rax), %ymm14, %ymm15
	vpermpd	$216, %ymm12, %ymm13
	vpermpd	$216, %ymm15, %ymm6
	vfmadd231pd	%ymm6, %ymm13, %ymm1
	vmovupd	64(%r8,%rax), %ymm7
	vmovupd	64(%rcx,%rax), %ymm4
	vunpcklpd	96(%r8,%rax), %ymm7, %ymm2
	vunpcklpd	96(%rcx,%rax), %ymm4, %ymm3
	vpermpd	$216, %ymm2, %ymm8
	vpermpd	$216, %ymm3, %ymm5
	vfmadd132pd	%ymm5, %ymm1, %ymm8
	vmovupd	128(%rcx,%rax), %ymm11
	vmovupd	128(%r8,%rax), %ymm1
	vunpcklpd	160(%rcx,%rax), %ymm11, %ymm12
	vunpcklpd	160(%r8,%rax), %ymm1, %ymm9
	vpermpd	$216, %ymm12, %ymm13
	vpermpd	$216, %ymm9, %ymm10
	vmovupd	192(%r8,%rax), %ymm14
	vmovupd	192(%rcx,%rax), %ymm7
	vfmadd231pd	%ymm13, %ymm10, %ymm8
	vunpcklpd	224(%r8,%rax), %ymm14, %ymm15
	vunpcklpd	224(%rcx,%rax), %ymm7, %ymm2
	vpermpd	$216, %ymm15, %ymm6
	vpermpd	$216, %ymm2, %ymm1
	addq	$4, %r10
	vfmadd132pd	%ymm6, %ymm8, %ymm1
	addq	$256, %rax
	cmpq	%r9, %r10
	jb	.L5
.L69:
	leaq	(%r11,%r9,8), %rcx
	vextractf128	$0x1, %ymm1, %xmm8
	vaddpd	%xmm1, %xmm8, %xmm4
	vmovsd	(%rsi,%rcx,8), %xmm9
	leaq	2(%rcx), %r8
	vfmadd231sd	(%rdi,%rcx,8), %xmm9, %xmm0
	vunpckhpd	%xmm4, %xmm4, %xmm3
	vaddpd	%xmm4, %xmm3, %xmm5
	vaddsd	%xmm5, %xmm0, %xmm0
	cmpq	%r8, %rdx
	jbe	.L72
	vmovsd	(%rdi,%r8,8), %xmm10
	vfmadd231sd	(%rsi,%r8,8), %xmm10, %xmm0
	leaq	4(%rcx), %r8
	cmpq	%r8, %rdx
	jbe	.L72
	vmovsd	(%rdi,%r8,8), %xmm11
	vfmadd231sd	(%rsi,%r8,8), %xmm11, %xmm0
	leaq	6(%rcx), %r8
	cmpq	%r8, %rdx
	jbe	.L72
	vmovsd	(%rsi,%r8,8), %xmm12
	vfmadd231sd	(%rdi,%r8,8), %xmm12, %xmm0
	leaq	8(%rcx), %r8
	vzeroupper
.L7:
	leaq	8(,%r8,8), %rdx
	vmovsd	(%rdi,%rdx), %xmm13
	popq	%rbx
	vfmadd231sd	(%rsi,%rdx), %xmm13, %xmm0
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L8:
	.cfi_restore 3
	.cfi_restore 6
	movl	$8, %r9d
	vxorpd	%xmm0, %xmm0, %xmm0
	jmp	.L2
	.p2align 4,,10
	.p2align 3
.L72:
	.cfi_def_cfa 6, 16
	.cfi_offset 3, -24
	.cfi_offset 6, -16
	vzeroupper
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L79:
	vmovupd	64(%r8), %ymm5
	vmovupd	64(%rcx), %ymm10
	vunpcklpd	96(%r8), %ymm5, %ymm8
	vunpcklpd	96(%rcx), %ymm10, %ymm11
	vpermpd	$216, %ymm8, %ymm9
	vpermpd	$216, %ymm11, %ymm12
	vfmadd231pd	%ymm12, %ymm9, %ymm1
	movl	$2, %r10d
	movl	$128, %eax
	jmp	.L56
	.p2align 4,,10
	.p2align 3
.L46:
	.cfi_def_cfa 7, 8
	.cfi_restore 3
	.cfi_restore 6
	movq	%r11, %r10
	notq	%r10
	vmovsd	(%rsi,%r11,8), %xmm14
	addq	%rdx, %r10
	shrq	%r10
	leaq	2(%r11), %rax
	vfmadd231sd	(%rdi,%r11,8), %xmm14, %xmm0
	andl	$7, %r10d
	cmpq	%rax, %rdx
	jbe	.L75
	testq	%r10, %r10
	je	.L11
	cmpq	$1, %r10
	je	.L49
	cmpq	$2, %r10
	je	.L50
	cmpq	$3, %r10
	je	.L51
	cmpq	$4, %r10
	je	.L52
	cmpq	$5, %r10
	je	.L53
	cmpq	$6, %r10
	je	.L54
	vmovsd	(%rsi,%rax,8), %xmm15
	vfmadd231sd	(%rdi,%rax,8), %xmm15, %xmm0
	leaq	4(%r11), %rax
.L54:
	vmovsd	(%rsi,%rax,8), %xmm6
	vfmadd231sd	(%rdi,%rax,8), %xmm6, %xmm0
	addq	$2, %rax
.L53:
	vmovsd	(%rsi,%rax,8), %xmm7
	vfmadd231sd	(%rdi,%rax,8), %xmm7, %xmm0
	addq	$2, %rax
.L52:
	vmovsd	(%rsi,%rax,8), %xmm2
	vfmadd231sd	(%rdi,%rax,8), %xmm2, %xmm0
	addq	$2, %rax
.L51:
	vmovsd	(%rsi,%rax,8), %xmm1
	vfmadd231sd	(%rdi,%rax,8), %xmm1, %xmm0
	addq	$2, %rax
.L50:
	vmovsd	(%rsi,%rax,8), %xmm8
	vfmadd231sd	(%rdi,%rax,8), %xmm8, %xmm0
	addq	$2, %rax
.L49:
	vmovsd	(%rsi,%rax,8), %xmm4
	vfmadd231sd	(%rdi,%rax,8), %xmm4, %xmm0
	addq	$2, %rax
	cmpq	%rax, %rdx
	jbe	.L75
.L11:
	vmovsd	(%rsi,%rax,8), %xmm3
	vmovsd	16(%rsi,%rax,8), %xmm5
	vfmadd231sd	(%rdi,%rax,8), %xmm3, %xmm0
	vmovsd	32(%rsi,%rax,8), %xmm9
	vmovsd	48(%rsi,%rax,8), %xmm10
	vmovsd	64(%rsi,%rax,8), %xmm11
	vmovsd	80(%rsi,%rax,8), %xmm12
	vfmadd231sd	16(%rdi,%rax,8), %xmm5, %xmm0
	vmovsd	96(%rsi,%rax,8), %xmm13
	vmovsd	112(%rsi,%rax,8), %xmm14
	vfmadd231sd	32(%rdi,%rax,8), %xmm9, %xmm0
	vfmadd231sd	48(%rdi,%rax,8), %xmm10, %xmm0
	vfmadd231sd	64(%rdi,%rax,8), %xmm11, %xmm0
	vfmadd231sd	80(%rdi,%rax,8), %xmm12, %xmm0
	vfmadd231sd	96(%rdi,%rax,8), %xmm13, %xmm0
	vfmadd231sd	112(%rdi,%rax,8), %xmm14, %xmm0
	addq	$16, %rax
	cmpq	%rax, %rdx
	ja	.L11
.L75:
	leaq	8(,%rax,8), %r9
.L74:
	vmovsd	(%rdi,%r9), %xmm15
	vfmadd231sd	(%rsi,%r9), %xmm15, %xmm0
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
