#!/bin/bash

# following util is assured to be running under jenkins env

CWD=$(cd $(dirname $0) && pwd)

cwd() {
	echo $CWD
}

changed() {
	bash $CWD/check_changed.sh $JENKINS_URL lastSuccessfulBuild $@
}

changed_at() {
	bash $CWD/check_changed.sh $JENKINS_URL $@
}

