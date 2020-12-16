# Devoir Maison (TD SIMD)
## Useful Information (TO DELETE!!)
The first 6 function arguments are passed in registers:
    %rdi, %rsi, %rdx, %rcx, %r8 and %r9
## No Unroll Code
### The C code of the function:
```c
    double dotprod(double *a, double *b, unsigned long long n)
    {
        double d = 0.0;
        unsigned long long i = 0;

        for (; i < n; i++)
            d += a[i] * b[i];

        return d;
    }
```
### The equivalent assembly compiled with 'gcc':
Code assembleur compilé avec l'option d'optimisation '-O1':
```asm
dotprod:
.LFB0:
	.cfi_startproc
	endbr64
	testq	%rdx, %rdx              # Compare if n equals 0
	je	.L4                         # Then jump to .L4
	movl	$0, %eax                # Copie 0 into a 32 bits register
	pxor	%xmm1, %xmm1            # Initializes the double 'd' to 0
.L3:                            # FOR LOOP
    # movsd: SSE2 Instruction
	movsd	(%rdi,%rax,8), %xmm0    # Move 8*(%rax) bits from %rdi to %xmm0
                                    # %xmm0 = a[i]          \w { i = (%rax)/8 }
	mulsd	(%rsi,%rax,8), %xmm0    # Multiply 8*(%rax) bits from %rsi with %xmm0
                                    # %xmm0 = b[i] * %xmm0  \w { i = (%rax)/8 }
	addsd	%xmm0, %xmm1            # Adds %xmm0 to %xmm1
                                    # %xmm1 = %xmm1 + %xmm0
                                    # d = d + a[i] * b[i]   \w { i = (%rax)/8 }
	addq	$1, %rax                # Adds 1 to %rax (i = i + 1)
	cmpq	%rax, %rdx              # Compare if i equals n
	jne	.L3                         # Jump if not equal to .L3 (FOR LOOP)
.L1:
	movapd	%xmm1, %xmm0            # Move 32 bit(single precision) doubles to %xmm0
	ret                             # Return (exit)
.L4:
	pxor	%xmm1, %xmm1            # Initializes the double 'd' to 0
	jmp	.L1                         # Jumps to .L1
	.cfi_endproc
```
Code assembleur compilé en 'gcc' avec l'option d'optimisation '-O2':
```asm
dotprod:
.LFB0:
	.cfi_startproc
	endbr64
	testq	%rdx, %rdx              # Compare if n equals 0
	je	.L4                         # Jump to .L4
	xorl	%eax, %eax              # Initialize %eax therefore %rax to 0 by executing a xor operation
                                    # Meaning: Initializing i to 0 (i = 0)
	pxor	%xmm1, %xmm1            # Initialize %xmm1 (the double d) to 0
	.p2align 4,,10
	.p2align 3
.L3:
	movsd	(%rdi,%rax,8), %xmm0    # %xmm0 = a[i]
	mulsd	(%rsi,%rax,8), %xmm0    # %xmm0 = %xmm0 * b[i]
	addq	$1, %rax                # i + = 1
	addsd	%xmm0, %xmm1            # d = d + %xmm0
	cmpq	%rax, %rdx              # Compare if i equals to n
	jne	.L3                         # If not, jump to .L3
	movapd	%xmm1, %xmm0            # Moves 32 bits of %xmm1 to %xmm0 (our return value)
	ret                             # Return (exit)
	.p2align 4,,10
	.p2align 3
.L4:
	pxor	%xmm1, %xmm1            # Initializes the double 'd' to 0
	movapd	%xmm1, %xmm0            # Moves (copies) %xmm1 to %xmm0 (our return value)
	ret                             # Return (exit)
	.cfi_endproc
```
Code assembleur compilé en 'gcc' avec l'option d'optimisation '-O3':
```asm
dotprod:
.LFB0:
	.cfi_startproc
	endbr64
	testq	%rdx, %rdx              # Performing a bit-wise AND operation on the register %rdx (argument n) to itself.
	je	.L7                         # If %rdx (n) is 0 then jump to .L7
	cmpq	$1, %rdx                # Comparing if n == 1
	je	.L8                         # If n == 1 then jump to .L8
	movq	%rdx, %rcx              # Moving the variable n to a 4th function argument %rcx
	xorl	%eax, %eax              # Initialize i to 0
	pxor	%xmm0, %xmm0            # Initialize the double d to 0
	shrq	%rcx                    # Shifting %rcx to the right by 1
	salq	$4, %rcx                # Shifting %rcx to the right by 4 
	.p2align 4,,10
	.p2align 3
.L4:
	movupd	(%rdi,%rax), %xmm1		# %xmm1 = a[i]
	movupd	(%rsi,%rax), %xmm3		# %xmm3 = b[i]
	addq	$16, %rax				# i += 16
	mulpd	%xmm3, %xmm1			# %xmm1 = %xmm1 * %xmm3 (a[i] * b[i])
	movapd	%xmm1, %xmm2			# %xmm2 = %xmm1
	unpckhpd	%xmm1, %xmm1		# Unpack %xmm1
	addsd	%xmm0, %xmm2			# %xmm2 += d
	movapd	%xmm1, %xmm0			# d = %xmm1
	addsd	%xmm2, %xmm0			# d += %xmm2
	cmpq	%rax, %rcx				# Compare i with 4th function argument (n)
	jne	.L4							# If we didn't get to the end of the loop jump to .L4 (back to loop)
	movq	%rdx, %rax				# i = n
	andq	$-2, %rax				# i = i & -2 | if 'i' is an odd number then subtract 1
	andl	$1, %edx				# Didn't understand the use of this instruction (%edx is unused!)
	je	.L11						# Jump to .L11
.L3:
	movsd	(%rsi,%rax,8), %xmm1	# %xmm1 = b[i]
	mulsd	(%rdi,%rax,8), %xmm1	# %xmm1 *= a[i]
	addsd	%xmm1, %xmm0			# d += %xmm1
	ret								# Return (exit)
	.p2align 4,,10
	.p2align 3
.L11:
	ret								# Return (exit)
	.p2align 4,,10
	.p2align 3
.L7:
	pxor	%xmm0, %xmm0            # Initialize the variable double d to 0 by performing XOR operation.
	ret                             # Return (exit)
.L8:
	xorl	%eax, %eax              # Initialize the variable unsigned long long i to 0
	pxor	%xmm0, %xmm0            # Initialize the varaible double d to 0
	jmp	.L3                         # Jump to .L3 (FOR LOOP)
	.cfi_endproc
```
Code assembleur compilé en 'gcc' avec l'option d'optimisation '-Ofast':
```asm
dotprod:
.LFB0:
	.cfi_startproc
	endbr64
	testq	%rdx, %rdx
	je	.L7
	cmpq	$1, %rdx				# check if n == 1
	je	.L8							# jump to .L8
	movq	%rdx, %rcx
	xorl	%eax, %eax
	pxor	%xmm0, %xmm0
	shrq	%rcx
	salq	$4, %rcx
	.p2align 4,,10
	.p2align 3
.L4:
	movupd	(%rdi,%rax), %xmm1
	movupd	(%rsi,%rax), %xmm2
	addq	$16, %rax
	mulpd	%xmm2, %xmm1			# vector multiplication
	addpd	%xmm1, %xmm0			# vector addition
	cmpq	%rax, %rcx
	jne	.L4
	movq	%rdx, %rax
	movapd	%xmm0, %xmm1
	unpckhpd	%xmm0, %xmm1
	andq	$-2, %rax
	andl	$1, %edx
	addpd	%xmm0, %xmm1			# vector addition
	je	.L1
.L3:								# Executed only if n = 1 which means our returned value is (0 + a[1] * b[1])
	movsd	(%rsi,%rax,8), %xmm0	# %xmm0 = b[i]
	mulsd	(%rdi,%rax,8), %xmm0	# %xmm0 *= a[i]
	addsd	%xmm0, %xmm1			# %xmm1 += %xmm0
.L1:
	movapd	%xmm1, %xmm0			# move %xmm1 to %xmm0 (return value)
	ret								# return (exit)
	.p2align 4,,10
	.p2align 3
.L7:
	pxor	%xmm1, %xmm1
	movapd	%xmm1, %xmm0
	ret
.L8:
	xorl	%eax, %eax			# %eax = 0
	pxor	%xmm1, %xmm1		# %xmm1 = 0
	jmp	.L3						# jump to .L3
	.cfi_endproc
```
### Observations:
In this assembly code we represented the ***unsigned long long i*** by a 32 bits register (**eax**) but we are manipulating this "*variable*" with a 64 bits register (**rax**).

> Side note: **eax** is used to wipe and initialize the register **rax**.

The difference between the assembly codes generated with the optimization options *-O1* and the other with *-O2* are more or less the same. The copying of the SEE register __%xmm1__ to our return value equivalent to the SEE register __%xmm0__, has been inlined into the .L3 and .L4 sections in the *-O2* code.

A way to optimize an initialization of a register to 0, instead of copying 0 to a register, we could perform a bitwise exclusive OR (XOR) operation on the destination register.
```
    # Instead of this
    movl $0, %destination               # %destination = 0

    # We could use this
    pxor %destination, %destination     # %destination = 0
```
Having said that, the assembly code generated with *-O3* is way different from both *-O1* and *-O2* codes.

There isn't much difference between *-O3* and *-Ofast* but the lack of vector addition in the *-O3* code.

I didn't include the assembly code of the ___kamikaze___ version because it's a bit long (115 lines). So I am going to comment directly on the difference between itself and the other versions (*-O1*, *-O2*, *-O3*, *-Ofast*).

In the ___kamikaze___ version, AVX (Advanced Vector eXtensions) has been put to use with the vectors ymm0 to ymm15.

### The equivalent assembly compiled with 'clang':
Code assembleur compilé avec l'option d'optimisation '-O1':
```asm
dotprod:                                # @dotprod
	.cfi_startproc
# %bb.0:
	xorpd	%xmm0, %xmm0
	testq	%rdx, %rdx
	je	.LBB0_3
# %bb.1:
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB0_2:                                # =>This Inner Loop Header: Depth=1
	movsd	(%rdi,%rax,8), %xmm1    # xmm1 = mem[0],zero
	mulsd	(%rsi,%rax,8), %xmm1
	addsd	%xmm1, %xmm0
	addq	$1, %rax
	cmpq	%rax, %rdx
	jne	.LBB0_2
.LBB0_3:
	retq
```
More or less the same observations for *gcc*.
Code assembleur compilé avec l'option d'optimisation '-O2':
```asm
dotprod:                                # @dotprod
	.cfi_startproc
# %bb.0:
	testq	%rdx, %rdx
	je	.LBB0_1
# %bb.2:
	leaq	-1(%rdx), %rcx
	movl	%edx, %eax
	andl	$3, %eax
	cmpq	$3, %rcx
	jae	.LBB0_4
# %bb.3:
	xorpd	%xmm0, %xmm0
	xorl	%ecx, %ecx
	jmp	.LBB0_6
.LBB0_1:
	xorps	%xmm0, %xmm0
	retq
.LBB0_4:
	subq	%rax, %rdx
	xorpd	%xmm0, %xmm0
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB0_5:                                # =>This Inner Loop Header: Depth=1
	movsd	(%rdi,%rcx,8), %xmm1    # xmm1 = mem[0],zero
	movsd	8(%rdi,%rcx,8), %xmm2   # xmm2 = mem[0],zero
	mulsd	(%rsi,%rcx,8), %xmm1
	mulsd	8(%rsi,%rcx,8), %xmm2
	addsd	%xmm0, %xmm1
	movsd	16(%rdi,%rcx,8), %xmm3  # xmm3 = mem[0],zero
	mulsd	16(%rsi,%rcx,8), %xmm3
	addsd	%xmm1, %xmm2
	movsd	24(%rdi,%rcx,8), %xmm0  # xmm0 = mem[0],zero
	mulsd	24(%rsi,%rcx,8), %xmm0
	addsd	%xmm2, %xmm3
	addsd	%xmm3, %xmm0
	addq	$4, %rcx
	cmpq	%rcx, %rdx
	jne	.LBB0_5
.LBB0_6:
	testq	%rax, %rax
	je	.LBB0_9
# %bb.7:
	leaq	(%rsi,%rcx,8), %rdx
	leaq	(%rdi,%rcx,8), %rcx
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB0_8:                                # =>This Inner Loop Header: Depth=1
	movsd	(%rcx,%rsi,8), %xmm1    # xmm1 = mem[0],zero
	mulsd	(%rdx,%rsi,8), %xmm1
	addsd	%xmm1, %xmm0
	addq	$1, %rsi
	cmpq	%rsi, %rax
	jne	.LBB0_8
.LBB0_9:
	retq
```
I've pasted the code to talk about the size of this _monster_, we have already more than 50 lines of assembly code, whether we have around 20 lines.
It is always using single double scalar ASM instructions (movsd, mulsd, addsd).

### Observations for the other optimization options (-O3, -Ofast and 'kamikaze'):
In *-O3*, *-Ofast* and *kamikaze*, we have evolved from single double precision to packed double precision which makes the use of vector operations. But, just like '__gcc__', there is only vector operations for mulplication and scalar operations for addition in *-O3*. On the other hand, in *-Ofast* there is the use of vector operations for both addition and multiplication.

>### Summary for the 'No Unroll' code (gcc vs clang)
>|          | SIMD Instructions (*gcc*)| SIMD Instructions (*clang*)|
>|----------|------------------------| -------------------------|
>| -O1      | Scalar           	 	 | Scalar           	 	|
>| -O2      | Scalar            	 | Scalar            	 	|
>| -O3      | Vector Multiplication	 | Vector Multiplication	|
>|			| + Scalar Addition		 | + Scalar Addition		|
>| -Ofast   | Vector Add and Mul	 | Vector Add and Mul	 	|
>| Kamikaze | Vector     	     	 | Vector     	     	 	|

## Code that has been unroll twice
### The C code of the function:
```c
	double dotprod(double *a, double *b, unsigned long long n)
	{
	double d = 0.0;
	double d_2 = 0.0;
	unsigned long long i = 0;
	if (n&1) 
	{
		d += a[i] * b[i];
		i++;
	}
	for (; i < n; i+=2)
		d += a[i] * b[i];
		d_2 += a[i+1] * b[i+1];

	return d + d_2;
	}
```
### The assembly equivalent codes:
```asm

```