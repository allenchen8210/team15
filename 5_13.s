	.file	"5_13.c"
	.text
	.globl	create_vector_array
	.type	create_vector_array, @function
create_vector_array:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -40(%rbp)
	movl	$0, %edi
	call	time
	movl	%eax, %edi
	call	srand
	movq	-40(%rbp), %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.L2
	movl	$0, %eax
	jmp	.L3
.L2:
	movq	$0, -32(%rbp)
	jmp	.L4
.L5:
	movq	-32(%rbp), %rax
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	leaq	(%rdx,%rax), %rbx
	call	rand
	movslq	%eax, %rdx
	imulq	$838860819, %rdx, %rdx
	shrq	$32, %rdx
	sarl	$22, %edx
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, (%rbx)
	addq	$1, -32(%rbp)
.L4:
	movq	-32(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jb	.L5
	movq	-24(%rbp), %rax
.L3:
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	create_vector_array, .-create_vector_array
	.section	.rodata
	.align 8
.LC1:
	.string	"For %ld-Dimensional Vector Dot Product. Cycle = %f CPE = %f\n"
	.text
	.globl	inner4
	.type	inner4, @function
inner4:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movq	%rcx, -64(%rbp)
	movq	$0, -16(%rbp)
	movl	$0, -24(%rbp)
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -8(%rbp)
	movl	$0, %eax
	call	start_comp_counter
	movq	$0, -16(%rbp)
	jmp	.L7
.L8:
	movq	-64(%rbp), %rax
	movl	(%rax), %edx
	movq	-16(%rbp), %rax
	leaq	0(,%rax,4), %rcx
	movq	-40(%rbp), %rax
	addq	%rcx, %rax
	movl	(%rax), %ecx
	movq	-16(%rbp), %rax
	leaq	0(,%rax,4), %rsi
	movq	-48(%rbp), %rax
	addq	%rsi, %rax
	movl	(%rax), %eax
	imull	%ecx, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	movl	%edx, (%rax)
	addq	$1, -16(%rbp)
.L7:
	movq	-16(%rbp), %rax
	cmpq	-56(%rbp), %rax
	jl	.L8
	movl	$0, %eax
	call	get_comp_counter
	movq	%xmm0, %rax
	movq	%rax, -8(%rbp)
	pxor	%xmm0, %xmm0
	cvtsi2sdq	-56(%rbp), %xmm0
	movsd	-8(%rbp), %xmm1
	divsd	%xmm0, %xmm1
	movapd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm2
	movss	%xmm2, -20(%rbp)
	cvtss2sd	-20(%rbp), %xmm0
	movq	-8(%rbp), %rdx
	movq	-56(%rbp), %rax
	movapd	%xmm0, %xmm1
	movq	%rdx, -72(%rbp)
	movsd	-72(%rbp), %xmm0
	movq	%rax, %rsi
	movl	$.LC1, %edi
	movl	$2, %eax
	call	printf
	cvtsd2ss	-8(%rbp), %xmm0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	inner4, .-inner4
	.globl	inner5
	.type	inner5, @function
inner5:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -8(%rbp)
	movq	$0, -16(%rbp)
	jmp	.L11
.L12:
	movq	-16(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movsd	(%rax), %xmm1
	movq	-16(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movsd	(%rax), %xmm0
	mulsd	%xmm1, %xmm0
	movsd	-8(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -8(%rbp)
	addq	$1, -16(%rbp)
.L11:
	movq	-16(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jl	.L12
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	inner5, .-inner5
	.section	.rodata
.LC2:
	.string	"w"
.LC3:
	.string	"file_int_d_o3.txt"
.LC4:
	.string	"Error opening file!"
.LC5:
	.string	"%lu %llu\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movl	$.LC2, %esi
	movl	$.LC3, %edi
	call	fopen
	movq	%rax, -48(%rbp)
	cmpq	$0, -48(%rbp)
	jne	.L14
	movl	$.LC4, %edi
	call	puts
	movl	$1, %edi
	call	exit
.L14:
	movq	$10, -40(%rbp)
	movq	$10000, -32(%rbp)
	movq	$1, -72(%rbp)
	jmp	.L15
.L18:
	movq	$0, -64(%rbp)
	movq	$1, -56(%rbp)
	jmp	.L16
.L17:
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	create_vector_array
	movq	%rax, -24(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	create_vector_array
	movq	%rax, -16(%rbp)
	movl	$4, %edi
	call	malloc
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	$0, (%rax)
	movq	-72(%rbp), %rdx
	movq	-8(%rbp), %rcx
	movq	-16(%rbp), %rsi
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	inner4
	cvttss2siq	%xmm0, %rax
	addq	%rax, -64(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	free
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	free
	addq	$1, -56(%rbp)
.L16:
	movq	-56(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jbe	.L17
	movq	-64(%rbp), %rax
	movl	$0, %edx
	divq	-40(%rbp)
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rcx
	movq	-72(%rbp), %rdx
	movq	-48(%rbp), %rax
	movl	$.LC5, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	addq	$1, -72(%rbp)
.L15:
	movq	-72(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jbe	.L18
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	fclose
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
