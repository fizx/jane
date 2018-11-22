#!/bin/bash

function abspath() {
    # generate absolute path from relative path
    # $1     : relative filename
    # return : absolute path
    if [ -d "$1" ]; then
        # dir
        (cd "$1"; pwd)
    elif [ -f "$1" ]; then
        # file
        if [[ $1 = /* ]]; then
            echo "$1"
        elif [[ $1 == */* ]]; then
            echo "$(cd "${1%/*}"; pwd)/${1##*/}"
        else
            echo "$(pwd)/$1"
        fi
    fi
}


original=`pwd`
cd `dirname $0`/..
cd lib/vendor/swift-protobuf
make
cd -
for i in `find . -name protoc-gen-swift -type f`
do
  if [ -x $i ]
  then
    PATH=$PATH:$(abspath $(dirname i))
  fi
done
PATH=`pwd`/exe:$PATH

if uname | grep -i darwin
then
  PROTOC=`pwd`/lib/vendor/protoc-osx/bin/protoc
else
  PROTOC=`pwd`/lib/vendor/protoc-linux/bin/protoc
fi
echo $PROTOC --swift_out=$1 -I lib/vendor/protoc-linux/include proto/*.proto ${@:2}
$PROTOC --swift_out=$1 -I `dirname $0`/../lib/vendor/protoc-linux/include -I `dirname $0`/../proto ${@:2}
$PROTOC --jane_out=$1 -I `dirname $0`/../lib/vendor/protoc-linux/include -I `dirname $0`/../proto ${@:2}