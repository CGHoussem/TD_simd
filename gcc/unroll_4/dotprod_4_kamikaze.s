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
	vxorpd	%xmm0, %xmm0, %xmm0
	andl	$1, %eax
	je	.L2
	vmovsd	(%rdi), %xmm0
	vmulsd	(%rsi), %xmm0, %xmm0
.L2:
	cmpq	%rax, %rdx
	jbe	.L86
	cmpq	$-4, %rdx
	ja	.L9
	leaq	-1(%rdx), %rcx
	subq	%rax, %rcx
	salq	$3, %rax
	addq	%rax, %rdi
	addq	%rsi, %rax
	shrq	$2, %rcx
	vmovupd	(%rax), %ymm6
	leaq	1(%rcx), %r8
	vmovq	%xmm0, %xmm9
	movl	$1, %esi
	vfmadd231pd	(%rdi), %ymm6, %ymm9
	andl	$7, %ecx
	movl	$32, %edx
	cmpq	%r8, %rsi
	jnb	.L85
	testq	%rcx, %rcx
	je	.L5
	cmpq	$1, %rcx
	je	.L64
	cmpq	$2, %rcx
	je	.L65
	cmpq	$3, %rcx
	je	.L66
	cmpq	$4, %rcx
	je	.L67
	cmpq	$5, %rcx
	je	.L68
	cmpq	$6, %rcx
	je	.L69
	vmovupd	32(%rax), %ymm2
	movl	$2, %esi
	vfmadd231pd	32(%rdi), %ymm2, %ymm9
	movl	$64, %edx
.L69:
	vmovupd	(%rax,%rdx), %ymm4
	incq	%rsi
	vfmadd231pd	(%rdi,%rdx), %ymm4, %ymm9
	addq	$32, %rdx
.L68:
	vmovupd	(%rax,%rdx), %ymm1
	incq	%rsi
	vfmadd231pd	(%rdi,%rdx), %ymm1, %ymm9
	addq	$32, %rdx
.L67:
	vmovupd	(%rax,%rdx), %ymm7
	incq	%rsi
	vfmadd231pd	(%rdi,%rdx), %ymm7, %ymm9
	addq	$32, %rdx
.L66:
	vmovupd	(%rax,%rdx), %ymm3
	incq	%rsi
	vfmadd231pd	(%rdi,%rdx), %ymm3, %ymm9
	addq	$32, %rdx
.L65:
	vmovupd	(%rax,%rdx), %ymm5
	incq	%rsi
	vfmadd231pd	(%rdi,%rdx), %ymm5, %ymm9
	addq	$32, %rdx
.L64:
	vmovupd	(%rax,%rdx), %ymm8
	incq	%rsi
	vfmadd231pd	(%rdi,%rdx), %ymm8, %ymm9
	addq	$32, %rdx
	cmpq	%r8, %rsi
	jnb	.L85
.L5:
	vmovupd	(%rax,%rdx), %ymm10
	vmovupd	32(%rax,%rdx), %ymm11
	vfmadd231pd	(%rdi,%rdx), %ymm10, %ymm9
	vmovupd	64(%rax,%rdx), %ymm12
	vmovupd	96(%rax,%rdx), %ymm13
	vmovupd	128(%rax,%rdx), %ymm14
	vmovupd	160(%rax,%rdx), %ymm15
	vfmadd231pd	32(%rdi,%rdx), %ymm11, %ymm9
	vmovupd	192(%rax,%rdx), %ymm0
	vmovupd	224(%rax,%rdx), %ymm6
	addq	$8, %rsi
	vfmadd231pd	64(%rdi,%rdx), %ymm12, %ymm9
	vfmadd231pd	96(%rdi,%rdx), %ymm13, %ymm9
	vfmadd231pd	128(%rdi,%rdx), %ymm14, %ymm9
	vfmadd231pd	160(%rdi,%rdx), %ymm15, %ymm9
	vfmadd231pd	192(%rdi,%rdx), %ymm0, %ymm9
	vfmadd231pd	224(%rdi,%rdx), %ymm6, %ymm9
	addq	$256, %rdx
	cmpq	%r8, %rsi
	jb	.L5
.L85:
	vextractf128	$0x1, %ymm9, %xmm4
	vmovapd	%xmm9, %xmm5
	vunpckhpd	%xmm9, %xmm9, %xmm3
	vmovapd	%xmm4, %xmm8
	vunpckhpd	%xmm4, %xmm4, %xmm9
	vzeroupper
.L7:
	vaddsd	%xmm9, %xmm8, %xmm8
	vaddsd	%xmm5, %xmm3, %xmm14
	vaddsd	%xmm14, %xmm8, %xmm0
.L86:
	ret
	.p2align 4,,10
	.p2align 3
.L9:
	movq	%rax, %r9
	vmovsd	(%rsi,%rax,8), %xmm5
	vmovsd	8(%rsi,%rax,8), %xmm3
	vmovsd	16(%rsi,%rax,8), %xmm8
	vmovsd	24(%rsi,%rax,8), %xmm9
	notq	%r9
	vxorpd	%xmm1, %xmm1, %xmm1
	addq	%rdx, %r9
	vfmadd132sd	(%rdi,%rax,8), %xmm0, %xmm5
	vfmadd132sd	8(%rdi,%rax,8), %xmm1, %xmm3
	vfmadd132sd	16(%rdi,%rax,8), %xmm1, %xmm8
	vfmadd132sd	24(%rdi,%rax,8), %xmm1, %xmm9
	shrq	$2, %r9
	addq	$4, %rax
	andl	$7, %r9d
	cmpq	%rax, %rdx
	jbe	.L7
	testq	%r9, %r9
	je	.L4
	cmpq	$1, %r9
	je	.L58
	cmpq	$2, %r9
	je	.L59
	cmpq	$3, %r9
	je	.L60
	cmpq	$4, %r9
	je	.L61
	cmpq	$5, %r9
	je	.L62
	cmpq	$6, %r9
	je	.L63
	vmovsd	(%rsi,%rax,8), %xmm7
	vmovsd	8(%rsi,%rax,8), %xmm10
	vmovsd	16(%rsi,%rax,8), %xmm11
	vmovsd	24(%rsi,%rax,8), %xmm12
	vfmadd231sd	(%rdi,%rax,8), %xmm7, %xmm5
	vfmadd231sd	8(%rdi,%rax,8), %xmm10, %xmm3
	vfmadd231sd	16(%rdi,%rax,8), %xmm11, %xmm8
	vfmadd231sd	24(%rdi,%rax,8), %xmm12, %xmm9
	addq	$4, %rax
.L63:
	vmovsd	(%rsi,%rax,8), %xmm13
	vmovsd	8(%rsi,%rax,8), %xmm14
	vmovsd	16(%rsi,%rax,8), %xmm15
	vmovsd	24(%rsi,%rax,8), %xmm0
	vfmadd231sd	(%rdi,%rax,8), %xmm13, %xmm5
	vfmadd231sd	8(%rdi,%rax,8), %xmm14, %xmm3
	vfmadd231sd	16(%rdi,%rax,8), %xmm15, %xmm8
	vfmadd231sd	24(%rdi,%rax,8), %xmm0, %xmm9
	addq	$4, %rax
.L62:
	vmovsd	(%rsi,%rax,8), %xmm6
	vmovsd	8(%rsi,%rax,8), %xmm2
	vmovsd	16(%rsi,%rax,8), %xmm4
	vmovsd	24(%rsi,%rax,8), %xmm1
	vfmadd231sd	(%rdi,%rax,8), %xmm6, %xmm5
	vfmadd231sd	8(%rdi,%rax,8), %xmm2, %xmm3
	vfmadd231sd	16(%rdi,%rax,8), %xmm4, %xmm8
	vfmadd231sd	24(%rdi,%rax,8), %xmm1, %xmm9
	addq	$4, %rax
.L61:
	vmovsd	(%rsi,%rax,8), %xmm7
	vmovsd	8(%rsi,%rax,8), %xmm10
	vmovsd	16(%rsi,%rax,8), %xmm11
	vmovsd	24(%rsi,%rax,8), %xmm12
	vfmadd231sd	(%rdi,%rax,8), %xmm7, %xmm5
	vfmadd231sd	8(%rdi,%rax,8), %xmm10, %xmm3
	vfmadd231sd	16(%rdi,%rax,8), %xmm11, %xmm8
	vfmadd231sd	24(%rdi,%rax,8), %xmm12, %xmm9
	addq	$4, %rax
.L60:
	vmovsd	(%rsi,%rax,8), %xmm13
	vmovsd	8(%rsi,%rax,8), %xmm14
	vmovsd	16(%rsi,%rax,8), %xmm15
	vmovsd	24(%rsi,%rax,8), %xmm0
	vfmadd231sd	(%rdi,%rax,8), %xmm13, %xmm5
	vfmadd231sd	8(%rdi,%rax,8), %xmm14, %xmm3
	vfmadd231sd	16(%rdi,%rax,8), %xmm15, %xmm8
	vfmadd231sd	24(%rdi,%rax,8), %xmm0, %xmm9
	addq	$4, %rax
.L59:
	vmovsd	(%rsi,%rax,8), %xmm6
	vmovsd	8(%rsi,%rax,8), %xmm2
	vmovsd	16(%rsi,%rax,8), %xmm4
	vmovsd	24(%rsi,%rax,8), %xmm1
	vfmadd231sd	(%rdi,%rax,8), %xmm6, %xmm5
	vfmadd231sd	8(%rdi,%rax,8), %xmm2, %xmm3
	vfmadd231sd	16(%rdi,%rax,8), %xmm4, %xmm8
	vfmadd231sd	24(%rdi,%rax,8), %xmm1, %xmm9
	addq	$4, %rax
.L58:
	vmovsd	(%rsi,%rax,8), %xmm7
	vmovsd	8(%rsi,%rax,8), %xmm10
	vmovsd	16(%rsi,%rax,8), %xmm11
	vmovsd	24(%rsi,%rax,8), %xmm12
	vfmadd231sd	(%rdi,%rax,8), %xmm7, %xmm5
	vfmadd231sd	8(%rdi,%rax,8), %xmm10, %xmm3
	vfmadd231sd	16(%rdi,%rax,8), %xmm11, %xmm8
	vfmadd231sd	24(%rdi,%rax,8), %xmm12, %xmm9
	addq	$4, %rax
	cmpq	%rax, %rdx
	jbe	.L7
.L4:
	vmovsd	8(%rsi,%rax,8), %xmm14
	vmovsd	(%rsi,%rax,8), %xmm13
	vfmadd132sd	8(%rdi,%rax,8), %xmm3, %xmm14
	vmovsd	16(%rsi,%rax,8), %xmm3
	vfmadd231sd	(%rdi,%rax,8), %xmm13, %xmm5
	vfmadd231sd	16(%rdi,%rax,8), %xmm3, %xmm8
	vmovsd	24(%rsi,%rax,8), %xmm15
	vmovsd	48(%rsi,%rax,8), %xmm6
	vfmadd231sd	24(%rdi,%rax,8), %xmm15, %xmm9
	vmovsd	32(%rsi,%rax,8), %xmm0
	vfmadd231sd	48(%rdi,%rax,8), %xmm6, %xmm8
	vfmadd132sd	32(%rdi,%rax,8), %xmm5, %xmm0
	vmovsd	56(%rsi,%rax,8), %xmm2
	vmovsd	40(%rsi,%rax,8), %xmm5
	vfmadd231sd	56(%rdi,%rax,8), %xmm2, %xmm9
	vfmadd231sd	40(%rdi,%rax,8), %xmm5, %xmm14
	vmovsd	80(%rsi,%rax,8), %xmm7
	vmovsd	64(%rsi,%rax,8), %xmm4
	vfmadd231sd	80(%rdi,%rax,8), %xmm7, %xmm8
	vmovsd	72(%rsi,%rax,8), %xmm1
	vmovsd	88(%rsi,%rax,8), %xmm10
	vfmadd231sd	64(%rdi,%rax,8), %xmm4, %xmm0
	vfmadd231sd	72(%rdi,%rax,8), %xmm1, %xmm14
	vfmadd231sd	88(%rdi,%rax,8), %xmm10, %xmm9
	vmovsd	112(%rsi,%rax,8), %xmm13
	vmovsd	96(%rsi,%rax,8), %xmm11
	vfmadd231sd	112(%rdi,%rax,8), %xmm13, %xmm8
	vmovsd	104(%rsi,%rax,8), %xmm12
	vmovsd	120(%rsi,%rax,8), %xmm3
	vfmadd231sd	96(%rdi,%rax,8), %xmm11, %xmm0
	vfmadd231sd	104(%rdi,%rax,8), %xmm12, %xmm14
	vfmadd231sd	120(%rdi,%rax,8), %xmm3, %xmm9
	vmovsd	128(%rsi,%rax,8), %xmm15
	vmovsd	144(%rsi,%rax,8), %xmm6
	vmovsd	136(%rsi,%rax,8), %xmm5
	vfmadd231sd	144(%rdi,%rax,8), %xmm6, %xmm8
	vmovsd	152(%rsi,%rax,8), %xmm2
	vfmadd231sd	128(%rdi,%rax,8), %xmm15, %xmm0
	vfmadd231sd	136(%rdi,%rax,8), %xmm5, %xmm14
	vfmadd231sd	152(%rdi,%rax,8), %xmm2, %xmm9
	vmovsd	176(%rsi,%rax,8), %xmm7
	vmovsd	160(%rsi,%rax,8), %xmm4
	vfmadd231sd	176(%rdi,%rax,8), %xmm7, %xmm8
	vmovsd	168(%rsi,%rax,8), %xmm1
	vmovsd	184(%rsi,%rax,8), %xmm10
	vfmadd231sd	160(%rdi,%rax,8), %xmm4, %xmm0
	vfmadd231sd	184(%rdi,%rax,8), %xmm10, %xmm9
	vfmadd231sd	168(%rdi,%rax,8), %xmm1, %xmm14
	vmovsd	208(%rsi,%rax,8), %xmm13
	vmovsd	192(%rsi,%rax,8), %xmm11
	vfmadd231sd	208(%rdi,%rax,8), %xmm13, %xmm8
	vmovsd	200(%rsi,%rax,8), %xmm12
	vmovsd	216(%rsi,%rax,8), %xmm15
	vfmadd231sd	192(%rdi,%rax,8), %xmm11, %xmm0
	vfmadd132sd	216(%rdi,%rax,8), %xmm9, %xmm15
	vfmadd231sd	200(%rdi,%rax,8), %xmm12, %xmm14
	vmovsd	240(%rsi,%rax,8), %xmm9
	vmovsd	224(%rsi,%rax,8), %xmm5
	vfmadd231sd	240(%rdi,%rax,8), %xmm9, %xmm8
	vmovsd	232(%rsi,%rax,8), %xmm3
	vmovsd	248(%rsi,%rax,8), %xmm9
	vfmadd132sd	224(%rdi,%rax,8), %xmm0, %xmm5
	vfmadd132sd	232(%rdi,%rax,8), %xmm14, %xmm3
	vfmadd132sd	248(%rdi,%rax,8), %xmm15, %xmm9
	addq	$32, %rax
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
