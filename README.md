# Docker VerneMQ

An Alpine Linux image running VerneMQ MQTT broker (https://vernemq.com), supporting swarm mode.


## Env var

| name  | description  | default  |
|---|---|---|
| SELF_IP  | The container IP. It will be discovered in swarm mode.  | 127.0.0.1  |
| SERVICE_NAME  | The swarm service name, used to discover other nodes. Cluster mode is disabled if this variable is empty  |  "" |
| DISCOVERY_NAME  | The DNS name to resolve to fetch a list of all nodes. Only used in cluster mode.  |  "tasks.${SERVICE_NAME}" |
| MIN_NODES_SIZE  | The minimum number of node to wait before starting when running in cluster mode  | 3  |

## Exploitation

The vmq-admin utility is located in /usr/share/vernemq/bin/vmq-admin, so you can run:

```
#!/bin/bash

id=$(docker ps | grep "jbonachera/vernemq:" | awk '{ print $1 }')
docker exec -it $id vmq-admin  $@
```

# Testing with docker-compose

edit the docker-compose.yml to add the environment variable DISCOVERY_NAME="vernemq"

```
docker-compose up --scale vernemq=3
```

A cluster of 3 nodes should be started, and MQTT service should be exposed on a random port on localhost.

## show the cluster nodes

```
docker-compose exec vernemq vmq-admin cluster show
```

## subscribe to a topic running

```
mosquitto_sub -h localhost --host 127.0.0.1 --port $(docker-compose port vernemq 1883 | cut -d : -f 2) -d -t devices/+/temperature/degrees
```

# Testing with Swarm mode

```
docker swarm init
docker stack deploy -c docker-compose.yml mqtt
```
