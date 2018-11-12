#!/bin/bash

set -e
set -o pipefail

cwd=`dirname $0`
source $cwd/common.sh

workspace=
for service in "$@" ; do
	if [[ $service == *"/"* ]]; then
		workspace=$service
	fi
done
target=$1
echo "workspace=$workspace"
digest=$(set -e; build_image $workspace)

dbmig $target $digest #idempotent
dbinit $target $digest #currently idempotent operation
