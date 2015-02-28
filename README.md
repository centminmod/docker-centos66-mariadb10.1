MariaDB 10.1.x on CentOS 6.6 64bit Docker container build intended for use with [CentminMod.com LEMP stack](http://centminmod.com). 

### My Docker Hub repo

* https://registry.hub.docker.com/u/centminmod/docker-centos66-mariadb10.1/

### Centmin Mod Docker Development forums

* https://community.centminmod.com/forums/centmin-mod-docker-development.52/

---
### Default MySQL root user password 

* The default MySQL root user password is set to = mysqlpass with added replication user = repl

#### Grab from Docker Hub

    docker pull centminmod/docker-centos66-mariadb10.1

Run docker container

    docker run -d -p 3306:3306 -t centminmod/docker-centos66-mariadb10.1

or specify a name e.g. mdb1

    docker run --name mdb1 -d -p 3306:3306 -t centminmod/docker-centos66-mariadb10.1

or if host system already has MySQL running on port 3306 need to map to another local host port e.g. 3307

    docker run --name mdb1 -d -p 3307:3306 -t centminmod/docker-centos66-mariadb10.1

to access container via bash if started with name = mdb1

    docker exec -ti mdb1 /bin/bash

to connect from host system to MariaDB docker container use the -h IP address which is shown for the docker0 network interface

    ifconfig docker0 | grep 'inet '
    inet addr:172.17.42.1  Bcast:0.0.0.0  Mask:255.255.0.0

e.g. host system running CentminMod.com LEMP stack MariaDB 5.5 server hence the client is 5.5.42 to connect to MariaDB 10.1.2 docker container

    mysqladmin -P 3307 -h 172.17.42.1 -u root -p ver
    Enter password: 
    mysqladmin  Ver 9.1 Distrib 10.1.2-MariaDB, for Linux on x86_64
    Copyright (c) 2000, 2014, Oracle, SkySQL Ab and others.
    
    Server version          10.1.2-MariaDB-wsrep
    Protocol version        10
    Connection              Localhost via UNIX socket
    UNIX socket             /var/lib/mysql/mysql.sock
    Uptime:                 4 min 20 sec
    
    Threads: 1  Questions: 8  Slow queries: 0  Opens: 0  Flush tables: 1  Open tables: 11  Queries per second avg: 0.030

---

#### Building from Dockerfile

Grab files

    git clone https://github.com/centminmod/docker-centos66-mariadb10.1.git

Build docker container with image name = centos66-mariadb10.1. Run command within same directory as Dockerfile

    docker build -t centos66-mariadb10.1 .

To run follow same run steps above.

