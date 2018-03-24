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
	      "image": "mesosphere/chronos:v3.0.2",
	      "network": "HOST",
	      "privileged": false,
	      "parameters": [],
	      "forcePullImage": false
	    }
	  },
	  "command": "--zk_hosts='${HOSTNAME}':2181 --master=zk://'${HOSTNAME}':2181/mesos",
	  "env": {
	    "PORT0": "4040",
	    "PORT1": "4041"
	  },
	  "portDefinitions": [
	    {
	      "port": 4040,
	      "protocol": "tcp",
	      "name": "chronos",
	      "labels": {}
	    }
	  ]
	}' | curl -s -d @- \
		--retry 3 \
		--retry-delay 3 \
		--header 'Content-Type: application/json' \
	http://${HOSTNAME}:8080/v2/apps

	if [ $? -gt 0 ]; then
		echo
		sleep 3
		tries=$(($tries + 1))
	else
		echo
		echo "# Done. Added chronos to Marathon scheduler"
		exit 0
	fi
done
echo "# Failed to add chronos to the Marathon scheduler!"
exit 1
