#!/bin/sh

set -e
. ./headers.sh

for PROJECT in $PROJECTS; do
	(cd $PROJECT && DESTDIR="$SYSROOT" $MAKE -j4 install)
done
