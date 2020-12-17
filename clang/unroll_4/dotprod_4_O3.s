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
	pxor	%xmm0, %xmm0
	xorl	%eax, %eax
	movq	%xmm0, %xmm1            # xmm1 = xmm0[0],zero
	pxor	%xmm0, %xmm0
	cmpq	%rdx, %rax
	jb	.LBB0_4
	jmp	.LBB0_6
.LBB0_2:
	movsd	(%rdi), %xmm1           # xmm1 = mem[0],zero
	mulsd	(%rsi), %xmm1
	xorpd	%xmm0, %xmm0
	addsd	%xmm1, %xmm0
	movl	$1, %eax
	movq	%xmm0, %xmm1            # xmm1 = xmm0[0],zero
	pxor	%xmm0, %xmm0
	cmpq	%rdx, %rax
	jae	.LBB0_6
	.p2align	4, 0x90
.LBB0_4:                                # =>This Inner Loop Header: Depth=1
	movupd	(%rdi,%rax,8), %xmm2
	movupd	16(%rdi,%rax,8), %xmm3
	movupd	(%rsi,%rax,8), %xmm4
	mulpd	%xmm2, %xmm4
	addpd	%xmm4, %xmm1
	movupd	16(%rsi,%rax,8), %xmm2
	mulpd	%xmm3, %xmm2
	addpd	%xmm2, %xmm0
	addq	$4, %rax
	cmpq	%rdx, %rax
	jb	.LBB0_4
.LBB0_6:
	movapd	%xmm1, %xmm2
	unpckhpd	%xmm1, %xmm2    # xmm2 = xmm2[1],xmm1[1]
	addsd	%xmm1, %xmm2
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
