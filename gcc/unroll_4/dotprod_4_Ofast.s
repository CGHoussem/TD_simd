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
	movl	$32, %r8d
	movl	$24, %r9d
	movl	$16, %ecx
.L2:
	cmpq	%rax, %rdx
	jbe	.L3
	.p2align 4,,10
	.p2align 3
.L4:
	movsd	(%rdi,%rax,8), %xmm1
	mulsd	(%rsi,%rax,8), %xmm1
	movq	%rax, %rcx
	addq	$4, %rax
	addsd	%xmm1, %xmm2
	cmpq	%rax, %rdx
	ja	.L4
	leaq	40(,%rcx,8), %rcx
	leaq	8(%rcx), %r9
	leaq	16(%rcx), %r8
.L3:
	movsd	(%rdi,%rcx), %xmm0
	movsd	(%rdi,%r9), %xmm1
	mulsd	(%rsi,%rcx), %xmm0
	mulsd	(%rsi,%r9), %xmm1
	addsd	%xmm1, %xmm0
	movsd	(%rdi,%r8), %xmm1
	mulsd	(%rsi,%r8), %xmm1
	addsd	%xmm1, %xmm2
	addsd	%xmm2, %xmm0
	ret
	.p2align 4,,10
	.p2align 3
.L5:
	movl	$24, %r8d
	movl	$16, %r9d
	movl	$8, %ecx
	pxor	%xmm2, %xmm2
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
