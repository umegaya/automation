#!/bin/bash

set -e

# https://$host:$port/job/$jobname
JOB_URL=$1
# number or lastSucessfulBuild
BUILD_TAG=$2
FILTER_PATH=$3

python_func="import json, sys
obj = json.loads(sys.stdin.read())
ch_list = obj['changeSet']['items']
_list = [ j['affectedPaths'] for j in ch_list ]
for outer in _list:
	  for inner in outer:
		      print inner
		      "
_affected_files=`curl --silent ${JOB_URL}${BUILD_TAG}'/api/json' | python -c "$python_func"`

if [ ! -z "`echo \"$_affected_files\" | grep \"${FILTER_PATH}\"`" ]; then
	for a_file in `echo "$_affected_files" | grep "${FILTER_PATH}"`; do
		echo "$a_file"
	done;
fi;
