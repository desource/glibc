#!/usr/bin/env bash
#
# Download and build glibc
set -euo pipefail

src=$PWD/glibc
out=$PWD/out

# _download "version" "sha256"
_download() {
  mkdir -p ${src}/build
  curl -OL http://ftp.gnu.org/gnu/libc/glibc-${1}.tar.xz
  echo "${2}  glibc-${1}.tar.xz" | sha256sum -c
  tar -C ${src} --strip-components=1 -xf glibc-${1}.tar.xz
}

_build() {
  cd ${src}/build
  ../configure \
    --enable-shared \
    --without-cvs \
    --without-gd \
    --disable-profile \
    --disable-sanity-checks
  make
  mv ${src}/build/* $out
}
  
_download 2.24 99d4a3e8efd144d71488e478f62587578c0f4e1fa0b4eed47ee3d4975ebeb5d3
_build
