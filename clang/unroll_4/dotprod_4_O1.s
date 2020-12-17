	.text
	.file	"dotprod_4.c"
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
	jb	.LBB0_5
.LBB0_4:
	xorpd	%xmm3, %xmm3
	xorpd	%xmm2, %xmm2
	jmp	.LBB0_7
.LBB0_2:
	movsd	(%rdi), %xmm2           # xmm2 = mem[0],zero
	mulsd	(%rsi), %xmm2
	xorpd	%xmm0, %xmm0
	addsd	%xmm2, %xmm0
	movl	$1, %eax
	cmpq	%rdx, %rax
	jae	.LBB0_4
.LBB0_5:
	xorpd	%xmm2, %xmm2
	xorpd	%xmm3, %xmm3
	xorpd	%xmm1, %xmm1
	.p2align	4, 0x90
.LBB0_6:                                # =>This Inner Loop Header: Depth=1
	movsd	(%rdi,%rax,8), %xmm4    # xmm4 = mem[0],zero
	movsd	8(%rdi,%rax,8), %xmm5   # xmm5 = mem[0],zero
	mulsd	(%rsi,%rax,8), %xmm4
	mulsd	8(%rsi,%rax,8), %xmm5
	addsd	%xmm4, %xmm0
	movsd	16(%rdi,%rax,8), %xmm4  # xmm4 = mem[0],zero
	mulsd	16(%rsi,%rax,8), %xmm4
	addsd	%xmm5, %xmm1
	movsd	24(%rdi,%rax,8), %xmm5  # xmm5 = mem[0],zero
	mulsd	24(%rsi,%rax,8), %xmm5
	addsd	%xmm4, %xmm3
	addsd	%xmm5, %xmm2
	addq	$4, %rax
	cmpq	%rdx, %rax
	jb	.LBB0_6
.LBB0_7:
	addsd	%xmm1, %xmm0
	addsd	%xmm3, %xmm0
	addsd	%xmm2, %xmm0
	retq
.Lfunc_end0:
	.size	dotprod, .Lfunc_end0-dotprod
	.cfi_endproc
                                        # -- End function
	.ident	"clang version 10.0.0-4ubuntu1 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
