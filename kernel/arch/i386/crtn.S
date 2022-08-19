/* Nicely put the contents of crtend.o's .init and .fini sections here */

.section .init
	popl %ebp
	ret

.section .fini
	popl %ebp
	ret
