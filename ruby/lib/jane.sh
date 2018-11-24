#!/bin/bash
original=`pwd`
cd `dirname $0`/..

PATH=`pwd`/exe:`pwd`/lib/vendor/grpc-swift:$PATH

if uname | grep -i darwin > /dev/null
then
  PROTOC=`pwd`/lib/vendor/protoc-osx/bin/protoc
else
  PROTOC=`pwd`/lib/vendor/protoc-linux/bin/protoc
fi

cd $original

echo $PROTOC --swift_out=$1 -I `dirname $0`/../lib/vendor/protoc-linux/include -I `dirname $0`/../proto ${@:2}
$PROTOC --swift_out=$1 -I `dirname $0`/../lib/vendor/protoc-linux/include -I `dirname $0`/../proto ${@:2}
$PROTOC --swiftgrpc_out=$1 -I `dirname $0`/../lib/vendor/protoc-linux/include -I `dirname $0`/../proto ${@:2}
$PROTOC --jane_out=$1 -I `dirname $0`/../lib/vendor/protoc-linux/include -I `dirname $0`/../proto ${@:2}