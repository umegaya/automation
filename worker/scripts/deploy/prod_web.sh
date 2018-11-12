#!/bin/bash

set -e
set -o pipefail

cwd=`dirname $0`
source $cwd/common.sh

webdigest=$(set -e; build_webimage)
echo "webdigest=[$webdigest]"

renew_cert $1
deploy $1 $webdigest mgoweb
