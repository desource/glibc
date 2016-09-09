#!/usr/bin/env bash
set -eux

GLIBC_VERSION=2.24
GLIBC_SHA256SUM=99d4a3e8efd144d71488e478f62587578c0f4e1fa0b4eed47ee3d4975ebeb5d3

SRC=$PWD/src
OUT=$PWD/out

mkdir -p $SRC/build $OUT

curl -OL http://ftp.gnu.org/gnu/libc/glibc-$GLIBC_VERSION.tar.xz
echo "$GLIBC_SHA256SUM  glibc-$GLIBC_VERSION.tar.xz" | sha256sum -c
tar -C $SRC --strip-components=1 -xf glibc-$GLIBC_VERSION.tar.xz

cd $SRC/build
../configure \
    --enable-shared \
    --without-cvs \
    --without-gd \
    --disable-profile \
    --disable-sanity-checks
make

mv $SRC/build/* $OUT
