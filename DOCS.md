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

        |         |           |           |                    || calculated       |                                                                                                                                      
COMMAND | SUB_CMD | PROJECT   | TARGET    |                    || global vars      |
--------|---------|-----------|-----------|--------------------||------------------|
 run    |         | portainer | docker    | [EDGE_KEY]         ||                  |                                                                                                                                      
        |         | agent     | swarm     |                    ||                  |
        |         | edge      | k8s       |                    || DLV_PORT         |                                                                                                                                      
        |         |           | workspace |                    || DATA_PATH        |                                                                                                                                      
        |         |           |           |                    || PROJECT_VER      |                                                                                                                                      
        |         |           |           |                    || DLV_WORK_DIR     |                                                                                                                                      
        |         |           |           |                    ||                  |                                                                                                                                      
--------|---------|-----------|-----------|--------------------||------------------|
 dlv    | exec    | portainer |           | ENV_VAR_LIST:      ||                  |                                                                                                                                      
        | kill    | agent     |           | DLV_PORT           ||                  |
        |         | edge      |           | DATA_PATH          ||                  |                                                                                                                                      
        |         |           |           | EDGE_KEY           ||                  |                                                                                                                                      
        |         |           |           | DEVKIT_DEBUG       ||                  |                                                                                                                                      
        |         |           |           | AGENT_CLUSTER_ADDR ||                  |                                                                                                                                      
        |         |           |           | EDGE               ||                  |                                                                                                                                      
        |         |           |           | EDGE_INSECURE_POLL ||                  |                                                                                                                                      
        |         |           |           | EDGE_ID            ||                  |                                                                                                                                      
        |         |           |           | DLV_WORK_DIR       ||                  |                                                                                                                                      
        |         |           |           |                    ||                  |                                                                                                                                      
--------|---------|-----------|-----------|--------------------||------------------|
 init   |         |           |           |                    ||                  |
        |         |           |           |                    ||                  |                                                                                                                                      
--------|---------|-----------|-----------|--------------------||------------------|
 ensure |         |           | docker    |                    ||                  |
        |         |           | swarm     |                    ||                  |                                                                                                                                      
        |         |           | k8s       |                    ||                  |                                                                                                                                      
        |         |           | workspace | PORTAINER_WORKSPACE||                  |                                                                                                                                      
        |         |           | network   |                    ||                  |                                                                                                                                      
--------|---------|-----------|-----------|--------------------||------------------|
 clean  |         |           | targets   |                    ||                  |
        |         |           | all       |                    ||                  |                                                                                                                                      
        |         |           |           |                    ||                  |                                                                                                                                      


Common Caculated Global Vars: 
CURRENT_FILE_PATH=/home/workspace/agent/.vscode/devkit/scripts
PROJECT_ROOT_PATH=/home/workspace/agent
WORKSPACE_PATH=/home/workspace
MUTE=/dev/stdout
DEV_MODE=false
IMAGE_NAME_AGENT=mcpacino/portainer-devkit-agent:dev
IMAGE_NAME_WORKSPACE=mcpacino/portainer-devkit-workspace:dev
TARGET_IP
TARGET_NAME

Caculated Vars for run command:
TARGET_IP=192.168.100.10
TARGET_NAME=portainer-workspace
DLV_PORT=23451
PROJECT_VER=ee
DATA_PATH=/home/workspace/data-ee
DLV_WORK_DIR=/app-portainer-ee

```

##devkit.sh is called in:
* vscode  (in workspace)
.vscode/devkit/scripts/devkit.sh run  (in workspace)  


* rpc_dlv_exec()   (in workspace)
DLV_WORK_DIR/scripts/devkit.sh dlv    (in agent) 
agent

* entry.sh          (in workspace)
/home/workspace/portainer-devkit/devkit/scripts/devkit.sh ensure workspace PORTAINER_WORKSPACE  (in workspace)  


* users          (in workspace)
/home/workspace/portainer-devkit/devkit/scripts/devkit.sh (in workspace)  
