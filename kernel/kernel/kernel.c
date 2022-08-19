#include <stdio.h>

#include <kernel/tty.h>

void kernel_main(void) {
	term_init();

	printf("Hello\n");
	printf("Welcome to windwOS!\n");
}
