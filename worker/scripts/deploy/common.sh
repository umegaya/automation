#!/bin/bash

cwd=`dirname $0`

function build_image_raw() {
        pushd $cwd/../../../../
                if [ -z $1 ]; then
                        sudo make image
                else
                        sudo make image MOUNT="--volumes-from `echo $HOSTNAME`" BUILD_DIR=$1/Server
                fi
                sudo docker push umegaya/mgosv
        popd
}

function build_image() {
		local ret
        ret=$(set -e; build_image_raw $1)
        echo $ret|awk '{match($0,"sha256:([^ ]+)",a)}END{print a[0]}'
}

function build_webimage_raw() {
        pushd $cwd/../../../mgoweb
                sudo make build CERTS_PATH=/etc/letsencrypt
                sudo docker push umegaya/mgoweb
        popd
}

function build_webimage() {
		local ret
        ret=$(set -e; build_webimage_raw)
        echo $ret|awk '{match($0,"sha256:([^ ]+)",a)}END{print a[0]}'
}

function deploy() {
	pushd $cwd/../../../
		./cluster/deploy.sh ./cluster/params_$1.sh $2 $3
	popd
}

function dbinit() {
	pushd $cwd/../../../
		./cluster/dbinit.sh ./cluster/params_$1.sh $2
	popd	
}

function dbmig() {
	pushd $cwd/../../../
		./cluster/dbmig.sh ./cluster/params_$1.sh $2
	popd	
}

function deploy_cadvisor() {
        pushd $cwd/../../../monitor
                sudo make agent # for this node
                make agent # for service running node
        popd
}

function deploy_dashboard() {
        # dashboard will be built on this node
        pushd $cwd/../../../monitor
                sudo make build CONFIG=$1
                sudo make dashboard
        popd
}
        
function deploy_bot() {
        pushd $cwd/../../../jenkins/bot
                sudo make build 
                sudo make bot
        popd
}

function renew_cert() {
        pushd $cwd/../../../
                ./cluster/renew_cert.sh ./cluster/params_$1.sh
        popd
}

function init_cert() {
        pushd $cwd/../../../
                ./cluster/init_cert.sh ./cluster/params_$1.sh
        popd
}