/* The bootloader will look at this first, and start execution at the function passed to this function */
ENTRY(_start)

/* Tell the linker where sections of the object files will be put in the kernel image. */
SECTIONS {
	/* Start putting sections in at 1M because x86 reserves 1M for other things */
	. = 1M;

	/* First put the multiboot header in as the bootloader won't find it if it's not early in the kernel */
	/* After that, put the ".text" section in */
	.text BLOCK(4K) : ALIGN(4K) {
		*(.multiboot)
		*(.text)
	}

	/* RO Data (Read-Only) */
	.rodata BLOCK(4K) : ALIGN(4K) {
		*(.rodata)
	}

	/* Initialized RW data (Read-Write) */
	.data BLOCK(4K) : ALIGN(4K) {
		*(.data)
	}

	/* Uninitialized RW data + the stack */
	.bss BLOCK(4K) : ALIGN(4K) {
		*(COMMON)
		*(.bss)
	}

	/* When more sections are needed in the final kernel, remember to add them in this file in the correct place. */
}
