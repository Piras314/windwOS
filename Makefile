# NOTE: THIS MAKEFILE IS ONLY FOR TYPICAL, QUICK DEVELOPMENT BUILDS.
all:
	./clean.sh && ./headers.sh && ./isogen.sh && ./qemu.sh
