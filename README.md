# docker-compose-mesos
A docker-compose file for a full Mesos *(master and slave)*, Marathon and Chronos stack

Links to the host-OS Docker daemon are passed to the 'mesos-slave', meaning Docker containers are launched alongside the docker-compose containers on the host OS.

# Required:
The host OS must have the following installed:
- make
- docker *(docker-ce is recommended instead of default OS packages)*
- docker-compose

This project has only been tested on CentOS 7.x with Docker Community Edition packages. Your results may vary!

*Note: is very likely you will need to run all 'make' commands below as 'root'*

# Start
```
make start
```

# Stop
```
make stop
```

# Cleanup
*Note: this deletes all data created by the containers!*

```
make clean
```

# Docker Images

The docker-compose.yml launches the following:
- mesoscloud/zookeeper:3.4.8-centos-7
- mesosphere/mesos-master:1.5.0
- mesosphere/mesos-slave:1.5.0
- mesoscloud/marathon:1.1.1-centos-7
- mesosphere/chronos:v3.0.2

# Ports

The docker-compose.yml requires the following ports.

*Note: change in docker-compose.yml if required*

- 5050/tcp *(http://host:5050)*: Mesos Master
- 5051/tcp *(http://host:5051)*: Mesos Slave
- 8080/tcp *(http://host:8080)*: Marathon
- 8081/tcp *(http://host:8081)*: Chronos
