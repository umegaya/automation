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
echo "workspace=$workspace"
digest=$(set -e; build_image $workspace)

target=$1
shift
for service in "$@" ; do
	if [[ $service != *"/"* ]]; then
		deploy $target $digest $service
	fi
done
