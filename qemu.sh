#!/bin/sh

set -e
. ./isogen.sh

qemu-system-$(./target-triplet-to-arch.sh $HOST) -cdrom windwos.iso
