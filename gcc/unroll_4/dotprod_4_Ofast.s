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
	pxor	%xmm3, %xmm3
	andl	$1, %eax
	je	.L2
	movsd	(%rdi), %xmm3
	mulsd	(%rsi), %xmm3
.L2:
	cmpq	%rax, %rdx
	jbe	.L1
	cmpq	$-4, %rdx
	ja	.L9
	subq	$1, %rdx
	movq	%xmm3, %xmm2
	pxor	%xmm1, %xmm1
	xorl	%ecx, %ecx
	subq	%rax, %rdx
	salq	$3, %rax
	shrq	$2, %rdx
	addq	%rax, %rdi
	addq	%rax, %rsi
	xorl	%eax, %eax
	addq	$1, %rdx
	.p2align 4,,10
	.p2align 3
.L5:
	movupd	(%rsi,%rax), %xmm0
	movupd	(%rdi,%rax), %xmm5
	addq	$1, %rcx
	movupd	16(%rdi,%rax), %xmm6
	mulpd	%xmm5, %xmm0
	addpd	%xmm0, %xmm2
	movupd	16(%rsi,%rax), %xmm0
	addq	$32, %rax
	mulpd	%xmm6, %xmm0
	addpd	%xmm0, %xmm1
	cmpq	%rdx, %rcx
	jb	.L5
	movapd	%xmm2, %xmm3
	unpckhpd	%xmm2, %xmm2
	movapd	%xmm2, %xmm0
	movapd	%xmm1, %xmm2
	unpckhpd	%xmm1, %xmm1
.L7:
	addsd	%xmm2, %xmm1
	addsd	%xmm3, %xmm0
	movapd	%xmm1, %xmm3
	addsd	%xmm0, %xmm3
.L1:
	movapd	%xmm3, %xmm0
	ret
	.p2align 4,,10
	.p2align 3
.L9:
	pxor	%xmm1, %xmm1
	movapd	%xmm1, %xmm2
	movapd	%xmm1, %xmm0
	.p2align 4,,10
	.p2align 3
.L4:
	movsd	(%rsi,%rax,8), %xmm4
	mulsd	(%rdi,%rax,8), %xmm4
	addsd	%xmm4, %xmm3
	movsd	8(%rsi,%rax,8), %xmm4
	mulsd	8(%rdi,%rax,8), %xmm4
	addsd	%xmm4, %xmm0
	movsd	16(%rsi,%rax,8), %xmm4
	mulsd	16(%rdi,%rax,8), %xmm4
	addsd	%xmm4, %xmm2
	movsd	24(%rsi,%rax,8), %xmm4
	mulsd	24(%rdi,%rax,8), %xmm4
	addq	$4, %rax
	addsd	%xmm4, %xmm1
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
