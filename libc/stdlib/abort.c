#include <stdio.h>
#include <stdlib.h>

/* TODO: Add kernel panic */
__attribute__((__noreturn__))
void abort(void) {
#if defined(__is_libk)
	printf("kernel: panic: abort()\n");
	asm volatile("hlt");
#else
	/* TODO: Terminate the process like SIGABRT, abnormally */
	printf("abort()\n");
#endif

	while(1) { }
	__builtin_unreachable();
}
