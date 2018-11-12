#!/bin/bash

set -e
set -o pipefail

cwd=`dirname $0`
source $cwd/common.sh

echo "deploy cadvisor"
deploy_cadvisor 

echo "deploy dashboard"
deploy_dashboard stage

echo "deploy bot"
deploy_bot

