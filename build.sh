#!/usr/bin/env bash
set -eux

GLIBC_VERSION=2.23
GLIBC_SHA256SUM=94efeb00e4603c8546209cefb3e1a50a5315c86fa9b078b6fad758e187ce13e9

SRC=$PWD/src
OUT=$PWD/out

mkdir -p $SRC/build

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

mv $SRC/build $OUT
