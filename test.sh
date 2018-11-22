#!/bin/bash
cd `dirname $0`
cd vendor/swift-protobuf
make
cd -
for i in `find . -name protoc-gen-swift -type f`
do
  if [ -x $i ]
  then
    PATH=$PATH:`dirname $i`
  fi
done
PATH=exe:$PATH
rm -rf build
mkdir -p build
protoc --swift_out=build -I proto -I vendor/protoc-linux/include proto/*.proto
protoc --jane_out=build -I proto -I vendor/protoc-linux/include proto/*.proto