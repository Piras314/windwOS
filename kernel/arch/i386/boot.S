/* Declare multiboot header constants */
.set ALIGN,    1 << 0			/* Align modules on page boundaries */
.set MEMINFO,  1 << 1			/* Provide a memory map */
.set FLAGS,    ALIGN | MEMINFO	/* Set multiboot flags */
.set MAGIC,    0x1BADB002		/* "magic" number that tells the bootloader this is multiboot */
.set CHECKSUM, -(MAGIC + FLAGS)	/* A checksum to prove this is multiboot */

.section .multiboot
	.align 4

	.long MAGIC
	.long FLAGS
	.long CHECKSUM

/* Reserve a 16 KiB stack */
.section .bss
	.align 16

	stack_bottom:
		.skip 16384 # 16 KiB
	stack_top:

/* The entry point to the windwOS kernel */
.section .text
	.global _start

	.type _start, @function
	_start:
		mov $stack_top, %esp

		/* Call the global constructors */
		call _init

	/* Transfer control to C */
	call kernel_main

	/* Hang the CPU if kernel_main returns */
	cli
1:	hlt
	jmp 1b

.size _start, . - _start
