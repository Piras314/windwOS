/* Declare multiboot constants */
.set ALIGN,		1 << 0			/* Align loaded modules on page boundaries */
.set MEMINFO,	1 << 1			/* Provide a memory map */
.set FLAGS,		ALIGN | MEMINFO	/* Add flags */
.set MAGIC,		0x1BADB002		/* "magic" number that allows the bootloader find the multiboot header */
.set CHECKSUM,	-(MAGIC + FLAGS)/* Prove that this is multiboot */

.section .multiboot
	.align 4

	.long MAGIC
	.long FLAGS
	.long CHECKSUM

/* Reserve stack for initial thread */
.section .bss
	.align 16

	stack_bottom:
		.skip 16384 /* 16 KiB */

	stack_top:

/* Entry point to the kernel */
.section .text
	.global _start

	.type _start, @function
	_start:
		mov $stack_top, %esp

		/* Call the constructors */
		call _init

		/* Transfer control to the kernel */
		call kernel_main

		/* Hang if kernel_main returns */
		cli
1:		hlt
		jmp 1b

.size _start, . - _start
