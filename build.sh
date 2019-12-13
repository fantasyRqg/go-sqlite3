#!/bin/bash

TMP_BUILD_DIR="out"

#rm -rf ${TMP_BUILD_DIR}
mkdir ${TMP_BUILD_DIR}

BUILD_PREFIX_DIR="$(pwd -P)/${TMP_BUILD_DIR}/"

pushd sqlcipher || exit

./configure --prefix="${BUILD_PREFIX_DIR}" --enable-tempstore=yes CFLAGS="-DSQLITE_HAS_CODEC -I/usr/local/opt/openssl@1.1/include" LDFLAGS="-lcrypto -L/usr/local/opt/openssl@1.1/lib"

make
make install
popd || exit

CGO_CFLAGS="-I${BUILD_PREFIX_DIR}/include/sqlcipher" CGO_LDFLAGS="-L${BUILD_PREFIX_DIR}/lib/ -lsqlcipher" go test

