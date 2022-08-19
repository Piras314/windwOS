#!/bin/sh

set -e
. ./config.sh

for PROJECT in $PROJECTS; do
	(cd $PROJECT && $MAKE clean)
done

rm -rf sysroot
rm -rf isoroot
rm -rf windwos.iso
