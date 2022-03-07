# Portainer DevKit

## A. Features
1. One-click to create Docker, Swarm and K8s Environments
2. One-click to run and debug Portainer in Docker and K8s
3. One-click to run and debug Agent and Edge-Agent in Docker, Swarm and K8s

<br/>

## B. Prerequisites
* Install [Docker](https://docs.docker.com/get-docker/)
* Install curl

<br/>

## C. Get Started
### 1. start portainer workspace
```
mkdir /tmp/devkit
PORTAINER_WORKSPACE="/tmp/devkit" DEVKIT_DEBUG="false" \
bash -c "`curl -s https://raw.githubusercontent.com/mcpacino/portainer-devkit/main/devkit/devkit`"
```
### 2. open vscode http://localhost:3000

<br/>

## D. Debug Portainer EE in Workspace
### 1. Open Folder of Portainer EE
![open-portainer-ee](/images/A01.open-portainer-ee.png)

### 2. Add a Breakpoint
![add-breakpoint](/images/A02.add-breakpoint.png)

### 3. Run Portainer EE in Workspace
![run-portainer](/images/A03.run-portainer.png)

### 4. Debug Portainer EE
![debug-portainer](/images/A04.debug-portainer.png)

### 5. Visit Portainer EE http://localhost:9000

<br/>

## E. Debug Agent in K8s
### 1. Open Folder of Agent
![B01.open-agent](/images/B01.open-agent.png)

### 2. Run Agent in K8s
![B02.run-agent-in-k8s](/images/B02.run-agent-in-k8s.png)

### 3. Building Agent and Starting K8s
![B03.building-agent-and-start-k8s](/images/B03.building-agent-and-start-k8s.png)

### 4. Add a K8s Agent Environment
![B04.add-k8s-environment](/images/B04.add-k8s-environment.png)

### 5. Check the K8s Agent Environment is Up
![B05.environment-up](/images/B05.environment-up.png)

<br/>

## F. Debug Edge Agent in K8s for Portainer EE
### 1. Create an Edge Agent Environment
![C01.create-edge-environment](/images/C01.create-edge-environment.png)

### 2. Copy the Edge Token
![C02.copy-edge-token](/images/C02.copy-edge-token.png)

### 3. Paste the Edge Token to tasks.json file (Note: use the EDGE_KEY_EE_K8S key)
![C03.past-edge-token-to-tasks-json](/images/C03.past-edge-token-to-tasks-json.png)

### 4. Run Edge Agent in K8s for EE
![C04.run-edge-agent-in-k8s](/images/C04.run-edge-agent-in-k8s.png)

### 5. Check the K8s Edge Agent Environment is Associated
![C05.edge-associated](/images/C05.edge-associated.png)

<br/>

## G. Containers Overview
~~~~
  +===========================================================+
  |  Container Name: portainer-workspace                      |
  +===========================================================+
  |  Host Name:      w01                                      |
  |  IP Addr:        192.168.100.10                           |
  |  Expose:         3000 (vscode)                            |
  |                  9000,9443 (portainer in workspace)       |
  +===========================================================+
  |  Running Apps:   vscode, portainer                        |
  +===========================================================+
  |  Port Mapping:   3000:3000                                |
  |                  9000:9000                                |
  |                  9443:9443                                |
  +===========================================================+
  
  
  +===========================================================+
  |  Container Name: portainer-k8s-control-plane              |
  +===========================================================+
  |  Host Name:      k01                                      |
  |  IP Addr:        192.168.100.1                            |
  |  Expose:         30778 (agent)                            |
  |                  9000,9443 (portainer in k8s)             |
  +===========================================================+
  |  Running Apps:   k8s, agent, portainer                    |
  +===========================================================+
  |  Port Mapping:   19000:9000                               |
  |                  19443:9443                               |
  +===========================================================+
  
  
  +===========================================================+
  |  Container Name: portainer-swarm                          |
  +===========================================================+
  |  Host Name:      s01                                      |
  |  IP Addr:        192.168.100.2                            |
  |  Expose:         9001 (agent)                             |
  +===========================================================+
  |  Running Apps:   swarm, agent                             |
  +===========================================================+
  
  
  +===========================================================+
  |  Container Name: portainer-docker                         |
  +===========================================================+
  |  Host Name:      d01                                      |
  |  IP Addr:        192.168.100.3                            |
  |  Expose:         9001 (agent)                             |
  +===========================================================+
  |  Running Apps:   docker, agent                            |
  +===========================================================+
~~~~

<br/>
<br/>
<br/>
<br/>
<br/>
<br/>

# Below is Deprecated

### Dev Mode (For Maintainer Only)
```
mkdir /tmp/devkit
PORTAINER_WORKSPACE="/tmp/devkit" DEV_MODE="true" DEVKIT_DEBUG="false" \
bash -c "`curl -s https://raw.githubusercontent.com/mcpacino/portainer-devkit/dev/devkit/devkit.sh`" 
```

## Supported Operating Systems
* Linux (Only tested on Ubuntu 18.04)
* MacOS
* Windows + WSL

## FAQ
* Environment URLs
~~~~
  +==============+================+======================+===============================+==============+==============+
  |  Portainer   |  Evironment    |  Environment         |  Portainer                    |  Environment |  Agent       |
  |  Running In  |  Name          |  URL                 |  Server URL                   |  Type        |  Type        |
  +==============+================+======================+===============================+==============+==============+
  |              |  k8s-agent     |  192.168.100.1:30778 |                               |  K8s         |              |
  +              +----------------+----------------------+                               +--------------+              +
  |  Docker/K8s  |  swarm-agent   |  192.168.100.2:9001  |                               |  Swam        |  Agent       |
  +              +----------------+----------------------+                               +--------------+              +
  |              |  docker-agent  |  192.168.100.3:9001  |                               |  Docker      |              |
  +==============+================+======================+===============================+==============+==============+
  |              |  k8s-edge      |                      |                               |  K8s         |              |
  +              +----------------+                      +  http://192.168.100.10:9000   +--------------+              +
  |  Docker      |  swarm-edge    |                      |            or                 |  Swarm       |  Edge Agent  |
  +              +----------------+                      +  https://192.168.100.10:9443  +--------------+              +
  |              |  docker-edge   |                      |                               |  Docker      |              |
  +==============+================+======================+===============================+==============+==============+
  |              |  k8s-edge      |                      |                               |  K8s         |              |
  +              +----------------+                      +  http://192.168.100.1:9000    +--------------+              +
  |  K8s         |  swarm-edge    |                      |            or                 |  Swarm       |  Edge Agent  |
  +              +----------------+                      +  https://192.168.100.1:9443   +--------------+              +
  |              |  docker-edge   |                      |                               |  Docker      |              |
  +--------------+----------------+----------------------+-------------------------------+--------------+--------------+
~~~~
* How to access the K8s environment with kubectl  
  `docker exec -it portainer-devkit bash`  
  `kubectl -n portainer get all`
* How to login to containers
* How to enable debug log for Devkit
* How to access portainer.db and other files in data folder  
  * In Workspace, they are in  
    `/home/workspace/devkit/data-ce`  
    `/home/workspace/devkit/data-ee`
  * In Host, they are in  
    `<your-workspace>/data-ce`  
    `<your-workspace>/data-ee`  
* How to clean all environments
* How to access portainer.db
* How to check output of background processes  
  run `tmux attach` in vscode terminal then press `ctrl+b s` to select output  
* how to run `yarn install`  
Using `tmux` to stop `yarn` results in running `yarn install` next time 
