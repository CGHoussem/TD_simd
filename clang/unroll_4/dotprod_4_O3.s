	.text
	.file	"dotprod_4.c"
	.globl	dotprod                 # -- Begin function dotprod
	.p2align	4, 0x90
	.type	dotprod,@function
dotprod:                                # @dotprod
	.cfi_startproc
# %bb.0:
	testb	$1, %dl
	jne	.LBB0_2
# %bb.1:
	xorpd	%xmm0, %xmm0
	xorl	%eax, %eax
	jmp	.LBB0_4
.LBB0_2:
	movsd	(%rdi), %xmm1           # xmm1 = mem[0],zero
	mulsd	(%rsi), %xmm1
	xorpd	%xmm0, %xmm0
	addsd	%xmm1, %xmm0
	movl	$1, %eax
	jmp	.LBB0_4
	.p2align	4, 0x90
.LBB0_3:                                #   in Loop: Header=BB0_4 Depth=1
	movsd	(%rdi,%rax,8), %xmm1    # xmm1 = mem[0],zero
	mulsd	(%rsi,%rax,8), %xmm1
	addsd	%xmm1, %xmm0
	addq	$4, %rax
.LBB0_4:                                # =>This Inner Loop Header: Depth=1
	cmpq	%rdx, %rax
	jb	.LBB0_3
# %bb.5:
	movsd	8(%rdi,%rax,8), %xmm1   # xmm1 = mem[0],zero
	mulsd	8(%rsi,%rax,8), %xmm1
	xorpd	%xmm2, %xmm2
	addsd	%xmm1, %xmm2
	addsd	%xmm0, %xmm2
	movupd	16(%rdi,%rax,8), %xmm0
	movupd	16(%rsi,%rax,8), %xmm1
	mulpd	%xmm0, %xmm1
	xorpd	%xmm0, %xmm0
	addpd	%xmm1, %xmm0
	addsd	%xmm0, %xmm2
	unpckhpd	%xmm0, %xmm0    # xmm0 = xmm0[1,1]
	addsd	%xmm2, %xmm0
	retq
.Lfunc_end0:
	.size	dotprod, .Lfunc_end0-dotprod
	.cfi_endproc
                                        # -- End function
	.ident	"clang version 10.0.0-4ubuntu1 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
