# Devoir Maison (TD SIMD)
## Information
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
### The Assembly equivalent code:
Code assembleur compilé en 'gcc' avec l'option d'optimisation '-O1':
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
	movupd	(%rdi,%rax), %xmm1
	movupd	(%rsi,%rax), %xmm3
	addq	$16, %rax
	mulpd	%xmm3, %xmm1
	movapd	%xmm1, %xmm2
	unpckhpd	%xmm1, %xmm1
	addsd	%xmm0, %xmm2
	movapd	%xmm1, %xmm0
	addsd	%xmm2, %xmm0
	cmpq	%rax, %rcx
	jne	.L4
	movq	%rdx, %rax
	andq	$-2, %rax
	andl	$1, %edx
	je	.L11
.L3:
	movsd	(%rsi,%rax,8), %xmm1
	mulsd	(%rdi,%rax,8), %xmm1
	addsd	%xmm1, %xmm0
	ret
	.p2align 4,,10
	.p2align 3
.L11:
	ret
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

### Observations:
In this assembly code we represented the ***unsigned long long i*** by a 32 bits register (**eax**) but we are manipulating this "*variable*" with a 64 bits register (**rax**).

- **eax** is used to wipe and initialize the register **rax**.

The difference between the assembly codes generated with the optimization options *-O1* and the other with *-O2* are more or less the same. The copying of the SEE register %xmm1 to our return value equivalent to the SEE register %xmm0 has been inlined into the .L3 and .L4 sections.

A way to optimize an initialization a register to 0, instead of copying 0 to a register, we could perform a bitwise exclusive OR (XOR) operation.
```
    # Instead of this
    movl $0, %destination               # %destination = 0

    # We could use this
    pxor %destination, %destination     # %destination = 0
```

