	.file	"dotprod_4.c"
	.text
	.p2align 4
	.globl	dotprod
	.type	dotprod, @function
dotprod:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdx, %r10
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	andl	$1, %r10d
	je	.L8
	vmovsd	(%rdi), %xmm3
	movl	$32, %ecx
	vmulsd	(%rsi), %xmm3, %xmm3
	movl	$24, %r9d
	movl	$16, %r11d
.L2:
	cmpq	%r10, %rdx
	jbe	.L3
	leaq	-1(%rdx), %r8
	subq	%r10, %r8
	cmpq	$-4, %rdx
	ja	.L40
	cmpq	$19, %r8
	jbe	.L40
	leaq	0(,%r10,8), %rax
	vmovupd	(%rsi,%rax), %ymm5
	vmovupd	64(%rsi,%rax), %ymm6
	vmovupd	(%rdi,%rax), %ymm8
	vmovupd	64(%rdi,%rax), %ymm11
	vunpcklpd	32(%rsi,%rax), %ymm5, %ymm0
	vunpcklpd	96(%rsi,%rax), %ymm6, %ymm1
	vunpcklpd	32(%rdi,%rax), %ymm8, %ymm9
	vunpcklpd	96(%rdi,%rax), %ymm11, %ymm12
	vpermpd	$216, %ymm0, %ymm2
	vpermpd	$216, %ymm1, %ymm4
	vpermpd	$216, %ymm9, %ymm10
	vpermpd	$216, %ymm12, %ymm13
	shrq	$4, %r8
	vunpcklpd	%ymm4, %ymm2, %ymm7
	vunpcklpd	%ymm13, %ymm10, %ymm14
	leaq	(%rsi,%rax), %r12
	leaq	(%rdi,%rax), %rbx
	leaq	-1(%r8), %r11
	vpermpd	$216, %ymm7, %ymm0
	vpermpd	$216, %ymm14, %ymm15
	vxorpd	%xmm5, %xmm5, %xmm5
	movl	$1, %r9d
	vfmadd132pd	%ymm15, %ymm5, %ymm0
	andl	$1, %r11d
	leaq	128(%r12), %rcx
	leaq	128(%rbx), %rax
	cmpq	%r8, %r9
	jnb	.L59
	testq	%r11, %r11
	je	.L5
	vmovupd	(%rcx), %ymm2
	vmovupd	64(%rcx), %ymm1
	vmovupd	(%rax), %ymm11
	vmovupd	64(%rax), %ymm14
	vunpcklpd	32(%rcx), %ymm2, %ymm6
	vunpcklpd	96(%rcx), %ymm1, %ymm7
	vunpcklpd	32(%rax), %ymm11, %ymm12
	vunpcklpd	96(%rax), %ymm14, %ymm15
	vpermpd	$216, %ymm6, %ymm4
	vpermpd	$216, %ymm7, %ymm8
	vpermpd	$216, %ymm12, %ymm13
	vpermpd	$216, %ymm15, %ymm5
	vunpcklpd	%ymm8, %ymm4, %ymm9
	vunpcklpd	%ymm5, %ymm13, %ymm2
	vpermpd	$216, %ymm9, %ymm10
	vpermpd	$216, %ymm2, %ymm6
	movl	$2, %r9d
	vfmadd231pd	%ymm6, %ymm10, %ymm0
	leaq	256(%r12), %rcx
	leaq	256(%rbx), %rax
	cmpq	%r8, %r9
	jnb	.L59
	.p2align 4,,10
	.p2align 3
.L5:
	vmovupd	(%rcx), %ymm4
	vmovupd	64(%rcx), %ymm8
	vmovupd	(%rax), %ymm13
	vmovupd	64(%rax), %ymm5
	vunpcklpd	32(%rcx), %ymm4, %ymm1
	vunpcklpd	96(%rcx), %ymm8, %ymm9
	vunpcklpd	32(%rax), %ymm13, %ymm14
	vunpcklpd	96(%rax), %ymm5, %ymm2
	vpermpd	$216, %ymm1, %ymm7
	vpermpd	$216, %ymm9, %ymm10
	vpermpd	$216, %ymm14, %ymm15
	vpermpd	$216, %ymm2, %ymm6
	vunpcklpd	%ymm10, %ymm7, %ymm11
	vunpcklpd	%ymm6, %ymm15, %ymm4
	vmovupd	128(%rcx), %ymm7
	vmovupd	192(%rcx), %ymm10
	vmovupd	128(%rax), %ymm15
	vmovupd	192(%rax), %ymm6
	vpermpd	$216, %ymm11, %ymm12
	vpermpd	$216, %ymm4, %ymm1
	vunpcklpd	160(%rcx), %ymm7, %ymm8
	vfmadd231pd	%ymm1, %ymm12, %ymm0
	vunpcklpd	224(%rcx), %ymm10, %ymm11
	vunpcklpd	160(%rax), %ymm15, %ymm5
	vunpcklpd	224(%rax), %ymm6, %ymm4
	vpermpd	$216, %ymm8, %ymm9
	vpermpd	$216, %ymm11, %ymm12
	vpermpd	$216, %ymm5, %ymm2
	vpermpd	$216, %ymm4, %ymm1
	vunpcklpd	%ymm12, %ymm9, %ymm13
	vunpcklpd	%ymm1, %ymm2, %ymm7
	vpermpd	$216, %ymm13, %ymm14
	vpermpd	$216, %ymm7, %ymm8
	addq	$2, %r9
	vfmadd231pd	%ymm8, %ymm14, %ymm0
	addq	$256, %rcx
	addq	$256, %rax
	cmpq	%r8, %r9
	jb	.L5
.L59:
	salq	$4, %r8
	addq	%r10, %r8
	vextractf128	$0x1, %ymm0, %xmm9
	vaddpd	%xmm0, %xmm9, %xmm0
	vmovsd	(%rsi,%r8,8), %xmm12
	leaq	4(%r8), %rbx
	vfmadd231sd	(%rdi,%r8,8), %xmm12, %xmm3
	vunpckhpd	%xmm0, %xmm0, %xmm10
	vaddpd	%xmm0, %xmm10, %xmm11
	vaddsd	%xmm11, %xmm3, %xmm3
	cmpq	%rbx, %rdx
	jbe	.L62
	vmovsd	(%rsi,%rbx,8), %xmm13
	vfmadd231sd	(%rdi,%rbx,8), %xmm13, %xmm3
	leaq	8(%r8), %rbx
	cmpq	%rbx, %rdx
	jbe	.L62
	vmovsd	(%rdi,%rbx,8), %xmm14
	vfmadd231sd	(%rsi,%rbx,8), %xmm14, %xmm3
	leaq	12(%r8), %rbx
	cmpq	%rbx, %rdx
	jbe	.L62
	vmovsd	(%rsi,%rbx,8), %xmm15
	vfmadd231sd	(%rdi,%rbx,8), %xmm15, %xmm3
	leaq	16(%r8), %rbx
	vzeroupper
.L7:
	leaq	8(,%rbx,8), %r11
	leaq	8(%r11), %r9
	leaq	16(%r11), %rcx
.L3:
	vmovsd	(%rdi,%r9), %xmm2
	vmovsd	(%rdi,%r11), %xmm4
	vmulsd	(%rsi,%r9), %xmm2, %xmm6
	vmovsd	(%rdi,%rcx), %xmm1
	popq	%rbx
	vfmadd231sd	(%rsi,%rcx), %xmm1, %xmm3
	popq	%r12
	vfmadd231sd	(%rsi,%r11), %xmm4, %xmm6
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	vaddsd	%xmm3, %xmm6, %xmm0
	ret
	.p2align 4,,10
	.p2align 3
.L8:
	.cfi_restore_state
	movl	$24, %ecx
	movl	$16, %r9d
	movl	$8, %r11d
	vxorpd	%xmm3, %xmm3, %xmm3
	jmp	.L2
	.p2align 4,,10
	.p2align 3
.L62:
	vzeroupper
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L40:
	movq	%r10, %r12
	notq	%r12
	vmovsd	(%rsi,%r10,8), %xmm5
	addq	%rdx, %r12
	shrq	$2, %r12
	leaq	4(%r10), %rbx
	vfmadd231sd	(%rdi,%r10,8), %xmm5, %xmm3
	andl	$7, %r12d
	cmpq	%rbx, %rdx
	jbe	.L7
	testq	%r12, %r12
	je	.L11
	cmpq	$1, %r12
	je	.L43
	cmpq	$2, %r12
	je	.L44
	cmpq	$3, %r12
	je	.L45
	cmpq	$4, %r12
	je	.L46
	cmpq	$5, %r12
	je	.L47
	cmpq	$6, %r12
	je	.L48
	vmovsd	(%rsi,%rbx,8), %xmm2
	vfmadd231sd	(%rdi,%rbx,8), %xmm2, %xmm3
	leaq	8(%r10), %rbx
.L48:
	vmovsd	(%rsi,%rbx,8), %xmm6
	vfmadd231sd	(%rdi,%rbx,8), %xmm6, %xmm3
	addq	$4, %rbx
.L47:
	vmovsd	(%rsi,%rbx,8), %xmm4
	vfmadd231sd	(%rdi,%rbx,8), %xmm4, %xmm3
	addq	$4, %rbx
.L46:
	vmovsd	(%rsi,%rbx,8), %xmm1
	vfmadd231sd	(%rdi,%rbx,8), %xmm1, %xmm3
	addq	$4, %rbx
.L45:
	vmovsd	(%rsi,%rbx,8), %xmm7
	vfmadd231sd	(%rdi,%rbx,8), %xmm7, %xmm3
	addq	$4, %rbx
.L44:
	vmovsd	(%rsi,%rbx,8), %xmm8
	vfmadd231sd	(%rdi,%rbx,8), %xmm8, %xmm3
	addq	$4, %rbx
.L43:
	vmovsd	(%rsi,%rbx,8), %xmm9
	vfmadd231sd	(%rdi,%rbx,8), %xmm9, %xmm3
	addq	$4, %rbx
	cmpq	%rbx, %rdx
	jbe	.L7
.L11:
	vmovsd	(%rsi,%rbx,8), %xmm0
	vmovsd	32(%rsi,%rbx,8), %xmm10
	vfmadd231sd	(%rdi,%rbx,8), %xmm0, %xmm3
	vmovsd	64(%rsi,%rbx,8), %xmm11
	vmovsd	96(%rsi,%rbx,8), %xmm12
	vmovsd	128(%rsi,%rbx,8), %xmm13
	vmovsd	160(%rsi,%rbx,8), %xmm14
	vfmadd231sd	32(%rdi,%rbx,8), %xmm10, %xmm3
	vmovsd	192(%rsi,%rbx,8), %xmm15
	vmovsd	224(%rsi,%rbx,8), %xmm5
	vfmadd231sd	64(%rdi,%rbx,8), %xmm11, %xmm3
	vfmadd231sd	96(%rdi,%rbx,8), %xmm12, %xmm3
	vfmadd231sd	128(%rdi,%rbx,8), %xmm13, %xmm3
	vfmadd231sd	160(%rdi,%rbx,8), %xmm14, %xmm3
	vfmadd231sd	192(%rdi,%rbx,8), %xmm15, %xmm3
	vfmadd231sd	224(%rdi,%rbx,8), %xmm5, %xmm3
	addq	$32, %rbx
	cmpq	%rbx, %rdx
	ja	.L11
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
