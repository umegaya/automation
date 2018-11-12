#!/bin/bash

set -e
set -o pipefail

cwd=`dirname $0`
source $cwd/common.sh

target=$1
if [ -z $2 ]; then
	digest=$(set -e; build_image $4)
else
	digest=$2
fi
if [ -z $3 ]; then
	webdigest=$(set -e; build_webimage)
else
	webdigest=$3
fi
echo "digest=[$digest]"
echo "webdigest=[$webdigest]"

deploy $target $webdigest mgoweb

dbmig $target $digest #idempotent
dbinit $target $digest #currently idempotent operation

deploy $target $digest mgolgin
sleep 1
deploy $target $digest mgorbtl
sleep 30
deploy $target $digest mgoesys
sleep 1
deploy $target $digest mgofe
sleep 1
