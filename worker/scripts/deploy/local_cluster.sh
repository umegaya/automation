#!/bin/bash

set -e
set -o pipefail

cwd=`dirname $0`
source $cwd/common.sh

if [ -z $1 ]; then
	digest=$(set -e; build_image $3)
else
	digest=$1
fi
if [ -z $2 ]; then
	webdigest=$(set -e; build_webimage)
else
	webdigest=$2
fi
echo "digest=[$digest]"
echo "webdigest=[$webdigest]"

deploy "local" $webdigest mgoweb

dbmig "local" $digest #idempotent
dbinit "local" $digest #currently idempotent operation

deploy "local" $digest mgolgin
sleep 1
deploy "local" $digest mgorbtl
sleep 1
deploy "local" $digest mgoesys
sleep 1
deploy "local" $digest mgofe
sleep 1
