	.text
	.file	"dotprod_2.c"
	.globl	dotprod                 # -- Begin function dotprod
	.p2align	4, 0x90
	.type	dotprod,@function
dotprod:                                # @dotprod
	.cfi_startproc
# %bb.0:
	testb	$1, %dl
	jne	.LBB0_2
# %bb.1:
	vpxor	%xmm0, %xmm0, %xmm0
	xorl	%eax, %eax
	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
	jmp	.LBB0_5
.LBB0_2:
	vmovsd	(%rsi), %xmm0           # xmm0 = mem[0],zero
	vmulsd	(%rdi), %xmm0, %xmm0
	movl	$1, %eax
	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
	jmp	.LBB0_5
	.p2align	4, 0x90
.LBB0_4:                                #   in Loop: Header=BB0_5 Depth=1
	vmovupd	(%rsi,%rax,8), %xmm1
	vfmadd231pd	(%rdi,%rax,8), %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
	addq	$2, %rax
.LBB0_5:                                # =>This Inner Loop Header: Depth=1
	cmpq	%rdx, %rax
	jb	.LBB0_4
# %bb.6:
	vpermilpd	$1, %xmm0, %xmm1 # xmm1 = xmm0[1,0]
	vaddsd	%xmm0, %xmm1, %xmm0
	retq
.Lfunc_end0:
	.size	dotprod, .Lfunc_end0-dotprod
	.cfi_endproc
                                        # -- End function
	.ident	"clang version 10.0.0-4ubuntu1 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
