# Docker VerneMQ

An Alpine Linux image running VerneMQ MQTT broker (https://vernemq.com), supporting swarm mode.


## Env var

| name  | description  | default  |
|---|---|---|
| SELF_IP  | The container IP. It will be discovered in swarm mode.  | 127.0.0.1  |
| SERVICE_NAME  | The swarm service name, used to discover other nodes. Swarm mode is disabled if this variable is empty  |  "" |
| MIN_NODES_SIZE  | The minimum number of node to wait before starting when running in swarm mode  | 3  |
