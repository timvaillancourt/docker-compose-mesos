#!/bin/bash

set -x

tries=0
while [ $tries -lt 10 ]; do
	echo '{
	  "id": "/chronos",
	  "cmd": null,
	  "cpus": 1,
	  "mem": 256,
	  "disk": 0,
	  "instances": 1,
	  "container": {
	    "type": "DOCKER",
	    "volumes": [],
	    "docker": {
	      "image": "mesoscloud/chronos:2.4.0-centos",
	      "network": "HOST",
	      "privileged": false,
	      "parameters": [],
	      "forcePullImage": false
	    }
	  },
	  "env": {
	    "CHRONOS_HTTP_PORT": "4400",
	    "CHRONOS_MASTER": "zk://'${HOSTNAME}':2181/mesos",
	    "CHRONOS_ZK_HOSTS": "'${HOSTNAME}':2181"
	  },
	  "portDefinitions": [
	    {
	      "port": 4400,
	      "protocol": "tcp",
	      "name": "chronos",
	      "labels": {}
	    }
	  ]
	}' | curl -s -d @- \
		--retry 3 \
		--retry-delay 3 \
		--header 'Content-Type: application/json' \
	http://localhost:8080/v2/apps

	if [ $? -gt 0 ]; then
		echo
		tries=$(($tries + 1))
		sleep 3
	else
		echo
		break
	fi
done
