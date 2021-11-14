# Portainer DevKit

## Run Portainer
* In Host? 
  * ensure network
  * ensure workspace
  * RPC->Workspace: devkit.sh run portainer
* In Workspace?
  * ensure dev watch
  * build portainer
  * ensure target
  * ensure agent container
  * rsync portainer to target
  * RPC->Target: devkit.sh dlv portainer

## Run Agent
* In Host?
  * ensure network
  * ensure workspace
  * RPC: run agent in Workspace
* In Workspace?
  * build agent
  * ensure target
  * ensure agent container
  * rsync agent to target
  * RPC->Target: devkit.sh dlv agent

```
devkit.sh CLI Usage

        |         |           |           |                    || calculated   |                                                                                                                                      
COMMAND | SUB_CMD | PROJECT   | TARGET    |                    || global vars  |
--------|---------|-----------|-----------|--------------------||--------------|
 run    |         | portainer | docker    | [EDGE_KEY]         || TARGET_IP    |                                                                                                                                      
        |         | agent     | swarm     |                    || TARGET_NAME  |
        |         | edge      | k8s       |                    || DLV_PORT     |                                                                                                                                      
        |         |           | workspace |                    || DATA_PATH    |                                                                                                                                      
        |         |           |           |                    ||              |                                                                                                                                      
--------|---------|-----------|-----------|--------------------||--------------|
 dlv    | exec    | portainer |           | ENV_VAR_LIST:      ||              |                                                                                                                                      
        | kill    | agent     |           | DLV_PORT           ||              |
        |         | edge      |           | DATA_PATH          ||              |                                                                                                                                      
        |         |           |           | EDGE_KEY           ||              |                                                                                                                                      
        |         |           |           | DEVKIT_DEBUG       ||              |                                                                                                                                      
        |         |           |           | AGENT_CLUSTER_ADDR ||              |                                                                                                                                      
        |         |           |           | EDGE               ||              |                                                                                                                                      
        |         |           |           | EDGE_INSECURE_POLL ||              |                                                                                                                                      
        |         |           |           | EDGE_ID            ||              |                                                                                                                                      
        |         |           |           |                    ||              |                                                                                                                                      
--------|---------|-----------|-----------|--------------------||--------------|
 init   |         |           |           |                    ||              |
        |         |           |           |                    ||              |                                                                                                                                      
--------|---------|-----------|-----------|--------------------||--------------|
 ensure |         |           | docker    |                    ||              |
        |         |           | swarm     |                    ||              |                                                                                                                                      
        |         |           | k8s       |                    ||              |                                                                                                                                      
        |         |           | workspace |                    ||              |                                                                                                                                      
        |         |           | network   |                    ||              |                                                                                                                                      
--------|---------|-----------|-----------|--------------------||--------------|
 clean  |         |           | targets   |                    ||              |
        |         |           | all       |                    ||              |                                                                                                                                      
        |         |           |           |                    ||              |                                                                                                                                      
```