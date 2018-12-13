	.file	"clock.c"
	.local	cyc_hi
	.comm	cyc_hi,4,4
	.local	cyc_lo
	.comm	cyc_lo,4,4
	.text
	.globl	access_counter
	.type	access_counter, @function
access_counter:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
#APP
# 37 "clock.c" 1
	rdtsc; movl %edx,%esi; movl %eax,%ecx
# 0 "" 2
#NO_APP
	movq	-8(%rbp), %rax
	movl	%esi, (%rax)
	movq	-16(%rbp), %rax
	movl	%ecx, (%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	access_counter, .-access_counter
	.globl	start_counter
	.type	start_counter, @function
start_counter:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$cyc_lo, %esi
	movl	$cyc_hi, %edi
	call	access_counter
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	start_counter, .-start_counter
	.section	.rodata
	.align 8
.LC3:
	.string	"Error: counter returns neg value: %.0f\n"
	.text
	.globl	get_counter
	.type	get_counter, @function
get_counter:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-32(%rbp), %rdx
	leaq	-36(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	access_counter
	movl	-32(%rbp), %edx
	movl	cyc_lo(%rip), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -28(%rbp)
	movl	-32(%rbp), %eax
	cmpl	%eax, -28(%rbp)
	seta	%al
	movzbl	%al, %eax
	movl	%eax, -24(%rbp)
	movl	-36(%rbp), %edx
	movl	cyc_hi(%rip), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	subl	-24(%rbp), %eax
	movl	%eax, -20(%rbp)
	movl	-20(%rbp), %eax
	testq	%rax, %rax
	js	.L4
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	jmp	.L5
.L4:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rdx, %xmm0
	addsd	%xmm0, %xmm0
.L5:
	movsd	.LC0(%rip), %xmm1
	mulsd	%xmm1, %xmm0
	movsd	.LC1(%rip), %xmm1
	mulsd	%xmm0, %xmm1
	movl	-28(%rbp), %eax
	testq	%rax, %rax
	js	.L6
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	jmp	.L7
.L6:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rdx, %xmm0
	addsd	%xmm0, %xmm0
.L7:
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -16(%rbp)
	pxor	%xmm0, %xmm0
	ucomisd	-16(%rbp), %xmm0
	jbe	.L8
	movq	stderr(%rip), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, -56(%rbp)
	movsd	-56(%rbp), %xmm0
	movl	$.LC3, %esi
	movq	%rax, %rdi
	movl	$1, %eax
	call	fprintf
.L8:
	movsd	-16(%rbp), %xmm0
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L11
	call	__stack_chk_fail
.L11:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	get_counter, .-get_counter
	.globl	ovhd
	.type	ovhd, @function
ovhd:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$0, -12(%rbp)
	jmp	.L14
.L15:
	movl	$0, %eax
	call	start_counter
	movl	$0, %eax
	call	get_counter
	movq	%xmm0, %rax
	movq	%rax, -8(%rbp)
	addl	$1, -12(%rbp)
.L14:
	cmpl	$1, -12(%rbp)
	jle	.L15
	movsd	-8(%rbp), %xmm0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	ovhd, .-ovhd
	.section	.rodata
	.align 8
.LC5:
	.string	"Processor clock rate ~= %.1f MHz\n"
	.text
	.globl	mhz_full
	.type	mhz_full, @function
mhz_full:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	$0, %eax
	call	start_counter
	movl	-24(%rbp), %eax
	movl	%eax, %edi
	call	sleep
	movl	$0, %eax
	call	get_counter
	movapd	%xmm0, %xmm2
	pxor	%xmm0, %xmm0
	cvtsi2sd	-24(%rbp), %xmm0
	movsd	.LC4(%rip), %xmm1
	mulsd	%xmm1, %xmm0
	divsd	%xmm0, %xmm2
	movapd	%xmm2, %xmm0
	movsd	%xmm0, -8(%rbp)
	cmpl	$0, -20(%rbp)
	je	.L18
	movq	-8(%rbp), %rax
	movq	%rax, -32(%rbp)
	movsd	-32(%rbp), %xmm0
	movl	$.LC5, %edi
	movl	$1, %eax
	call	printf
.L18:
	movsd	-8(%rbp), %xmm0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	mhz_full, .-mhz_full
	.globl	mhz
	.type	mhz, @function
mhz:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %eax
	movl	$2, %esi
	movl	%eax, %edi
	call	mhz_full
	movq	%xmm0, %rax
	movq	%rax, -16(%rbp)
	movsd	-16(%rbp), %xmm0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	mhz, .-mhz
	.local	cyc_per_tick
	.comm	cyc_per_tick,8,8
	.type	callibrate, @function
callibrate:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movl	%edi, -100(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -92(%rbp)
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	times
	movq	-48(%rbp), %rax
	movq	%rax, -80(%rbp)
	movl	$0, %eax
	call	start_counter
	movl	$0, %eax
	call	get_counter
	movq	%xmm0, %rax
	movq	%rax, -88(%rbp)
	jmp	.L23
.L31:
	movl	$0, %eax
	call	get_counter
	movq	%xmm0, %rax
	movq	%rax, -72(%rbp)
	movsd	-72(%rbp), %xmm0
	subsd	-88(%rbp), %xmm0
	ucomisd	.LC6(%rip), %xmm0
	jnb	.L33
	jmp	.L23
.L33:
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	times
	movq	-48(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	cmpq	-80(%rbp), %rax
	jle	.L25
	movsd	-72(%rbp), %xmm0
	subsd	-88(%rbp), %xmm0
	movq	-64(%rbp), %rax
	subq	-80(%rbp), %rax
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -56(%rbp)
	movsd	cyc_per_tick(%rip), %xmm0
	pxor	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jp	.L34
	pxor	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	je	.L26
.L34:
	movsd	cyc_per_tick(%rip), %xmm0
	ucomisd	-56(%rbp), %xmm0
	jbe	.L28
.L26:
	movsd	-56(%rbp), %xmm0
	ucomisd	.LC7(%rip), %xmm0
	jbe	.L28
	movsd	-56(%rbp), %xmm0
	movsd	%xmm0, cyc_per_tick(%rip)
.L28:
	addl	$1, -92(%rbp)
	movq	-64(%rbp), %rax
	movq	%rax, -80(%rbp)
.L25:
	movsd	-72(%rbp), %xmm0
	movsd	%xmm0, -88(%rbp)
.L23:
	cmpl	$99, -92(%rbp)
	jle	.L31
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L32
	call	__stack_chk_fail
.L32:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	callibrate, .-callibrate
	.local	start_tick
	.comm	start_tick,8,8
	.globl	start_comp_counter
	.type	start_comp_counter, @function
start_comp_counter:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movsd	cyc_per_tick(%rip), %xmm0
	pxor	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jp	.L37
	pxor	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jne	.L37
	movl	$1, %edi
	call	callibrate
.L37:
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	times
	movq	-48(%rbp), %rax
	movq	%rax, start_tick(%rip)
	movl	$0, %eax
	call	start_counter
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L39
	call	__stack_chk_fail
.L39:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	start_comp_counter, .-start_comp_counter
	.globl	get_comp_counter
	.type	get_comp_counter, @function
get_comp_counter:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, %eax
	call	get_counter
	movq	%xmm0, %rax
	movq	%rax, -72(%rbp)
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	times
	movq	-48(%rbp), %rdx
	movq	start_tick(%rip), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	movq	%rax, -64(%rbp)
	pxor	%xmm0, %xmm0
	cvtsi2sdq	-64(%rbp), %xmm0
	movsd	cyc_per_tick(%rip), %xmm1
	mulsd	%xmm1, %xmm0
	movsd	-72(%rbp), %xmm1
	subsd	%xmm0, %xmm1
	movapd	%xmm1, %xmm0
	movsd	%xmm0, -56(%rbp)
	movsd	-56(%rbp), %xmm0
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L43
	call	__stack_chk_fail
.L43:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	get_comp_counter, .-get_comp_counter
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1104150528
	.align 8
.LC1:
	.long	0
	.long	1074790400
	.align 8
.LC4:
	.long	0
	.long	1093567616
	.align 8
.LC6:
	.long	0
	.long	1083129856
	.align 8
.LC7:
	.long	0
	.long	1084715008
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
