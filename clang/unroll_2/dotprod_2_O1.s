	.text
	.file	"dotprod_2.c"
	.globl	dotprod                 # -- Begin function dotprod
	.p2align	4, 0x90
	.type	dotprod,@function
dotprod:                                # @dotprod
	.cfi_startproc
# %bb.0:
	xorpd	%xmm1, %xmm1
	testb	$1, %dl
	jne	.LBB0_2
# %bb.1:
	xorl	%eax, %eax
	xorpd	%xmm0, %xmm0
	cmpq	%rdx, %rax
	jb	.LBB0_4
	jmp	.LBB0_6
.LBB0_2:
	movsd	(%rdi), %xmm2           # xmm2 = mem[0],zero
	mulsd	(%rsi), %xmm2
	xorpd	%xmm0, %xmm0
	addsd	%xmm2, %xmm0
	movl	$1, %eax
	cmpq	%rdx, %rax
	jae	.LBB0_6
.LBB0_4:
	xorpd	%xmm1, %xmm1
	.p2align	4, 0x90
.LBB0_5:                                # =>This Inner Loop Header: Depth=1
	movsd	(%rdi,%rax,8), %xmm2    # xmm2 = mem[0],zero
	movsd	8(%rdi,%rax,8), %xmm3   # xmm3 = mem[0],zero
	mulsd	(%rsi,%rax,8), %xmm2
	mulsd	8(%rsi,%rax,8), %xmm3
	addsd	%xmm2, %xmm0
	addsd	%xmm3, %xmm1
	addq	$2, %rax
	cmpq	%rdx, %rax
	jb	.LBB0_5
.LBB0_6:
	addsd	%xmm1, %xmm0
	retq
.Lfunc_end0:
	.size	dotprod, .Lfunc_end0-dotprod
	.cfi_endproc
                                        # -- End function
	.ident	"clang version 10.0.0-4ubuntu1 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
