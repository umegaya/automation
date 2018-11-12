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

renew_cert stage
deploy stage $webdigest mgoweb

dbmig stage $digest #idempotent
dbinit stage $digest #currently idempotent operation

deploy stage $digest mgolgin
sleep 1
deploy stage $digest mgorbtl
sleep 20
deploy stage $digest mgoesys
sleep 1
deploy stage $digest mgofe
sleep 1
