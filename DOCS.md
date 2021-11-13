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
CLI Usage
          | COMMAND | SUB_CMD   | PROJECT    | TARGET      |                                             ||                               |
----------|---------|-----------|------------|-------------|---------------------------------------------||-------------------------------|
          |         |           | portainer  | docker      |                                             || TARGET_IP                     |                                                                                                                                      
devkit.sh | run     |           | agent      | swarm       |  [EDGE_KEY]                                 || TARGET_NAME                   |
          |         |           | edge-agent | k8s         |                                             || DLV_PORT                      |                                                                                                                                      
          |         |           |            | workspace   |                                             || DATA_PATH                     |                                                                                                                                      
          |         |           |            |             |                                             ||                               |                                                                                                                                      
          |         |           |            |             |                                             ||                               |                                                                                                                                      
          |         |           |            |             |                                             ||                               |                                                                                                                                      
          |         |           |            |             |                                             ||                               |                                                                                                                                      
          |         |           |            |             |                                             ||                               |                                                                                                                                      
          |         |           |            |             |                                             ||                               |                                                                                                                                      
          |         |           |            |             |                                             ||                               |                                                                                                                                      
----------|---------|-----------|------------|-------------|---------------------------------------------||-------------------------------|
          |         |           | portainer  |             |  ENV_VAR_LIST:                              ||                               |                                                                                                                                      
devkit.sh | dlv     | exec|kill | agent      |             |  DLV_PORT:DATA_PATH:EDGE_KEY:DEVKIT_DEBUG   ||                               |
          |         |           | edge-agent |             |                                             ||                               |                                                                                                                                      
----------|---------|-----------|------------|-------------|---------------------------------------------||-------------------------------|
          |         |           |            |             |                                             ||                               |
          |         |           |            |             |                                             ||                               |                                                                                                                                      
devkit.sh | init    |           |            |             |                                             ||                               |
          |         |           |            |             |                                             ||                               |                                                                                                                                      
----------|---------|-----------|------------|-------------|---------------------------------------------||-------------------------------|
devkit.sh | ensure  |           |            | docker      |                                             ||                               |
          |         |           |            | swarm       |                                             ||                               |                                                                                                                                      
          |         |           |            | k8s         |                                             ||                               |                                                                                                                                      
          |         |           |            | workspace   |                                             ||                               |                                                                                                                                      
          |         |           |            | network     |                                             ||                               |                                                                                                                                      
----------|---------|-----------|------------|-------------|---------------------------------------------||-------------------------------|
          |         |           |            |             |                                             ||                               |                                                                                                                                      
devkit.sh | clean   |           |            | targets     |                                             ||                               |
          |         |           |            | all         |                                             ||                               |                                                                                                                                      
```