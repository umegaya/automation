#!/bin/bash

pushd /home/slave/.ssh
	cat id_rsa.pub >> authorized_keys
	echo 'export PATH=$PATH:/usr/local/bin' >> rc
	cat >config <<CONF
Host *
    ServerAliveInterval 60
    ServerAliveCountMax 3600
CONF
	chown -R slave:slave *
popd
