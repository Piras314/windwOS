#!/bin/sh

set -e
. ./build.sh

mkdir -p isoroot
mkdir -p isoroot/boot
mkdir -p isoroot/boot/grub

cp sysroot/boot/windwos.kernel isoroot/boot/windwos.kernel
cat > isoroot/boot/grub/grub.cfg << EOF
menuentry "windwos" {
	multiboot /boot/windwos.kernel
}
EOF
grub-mkrescue -o windwos.iso isoroot
