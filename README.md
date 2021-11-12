# Portainer DevKit

## Features
1. One-click to create Docker, Swarm and K8s Environments
2. One-click to run and debug Portainer in Docker and K8s
3. One-click to run and debug Agent and Edge-Agent in Docker, Swarm and K8s

##### Debug Portainer in Docker and K8s 
![debug-edge-agent-in-k8s](/data/debug-portainer-in-k8s.png)

##### Debug Agent and Edge-Agent in Docker, Swarm and K8s  
![debug-edge-agent-in-k8s](/data/debug-edge-agent-in-k8s.png)

## Supported Operating Systems
* Linux (Only tested on Ubuntu 18.04)
* MacOS
* Windows + WSL

## Prerequisites
* Install [Docker](https://docs.docker.com/get-docker/)
* Install [VS Code](https://code.visualstudio.com/download) 
* Install [Go](https://marketplace.visualstudio.com/items?itemName=golang.go) extension for VS Code
* Install [Remote WSL](https://marketplace.visualstudio.com/items?itemName=golang.go) extension for VS Code if you are using Windows  
* Install [WSL](https://docs.microsoft.com/en-us/windows/wsl/install) if you are using Windows
    
## Get Started
* Open a shell terminal (WLS terminal in Windows)

* Make a new directory as your Portainer workspace  
  `mkdir workspace; cd workspace`

* Download git repo of Portainer EE (Optional)  
  `git clone https://github.com/portainer/portainer-ee.git`

* Download git repo of Portainer, Agent and DevKit
````
  export PORTAINER_WORKSAPCE=/home/simon/workspace && \
  docker run --rm \
    --name portainer-devkit-init \
    -e USER_UID_GID=`id -u`:`id -g` \
    -p 3000:3000 \
    -v ${PORTAINER_WORKSAPCE:-$PWD}:/home/workspace \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/lib/docker/volumes:/var/lib/docker/volumes \
    mcpacino/portainer-devkit:dev
````
![01-install](/data/01-install.png)

* Start VS Code and create a project for Portainer  
  * For Windows, start VS Code by running  
  `cd portainer; vscode .`  
  `cd agent; vscode .`

![02-vscode-open-portainer-folder](/data/02-vscode-open-portainer-folder.png)

* Ensure go extention has been installed  

![03-vscode-go-extension](/data/03-vscode-go-extension.png)

* Select a debug configure(i.e. "Run in Docker") and click run button  

![04-click-run-in-docker](/data/04-click-run-in-docker.png)

* Click the "https://localhost:9000" link to open Portainer after the building done  

![05-click-9000-url](/data/05-click-9000-url.png)

* Congratulation. The Portainer in up.  

![06-portainer-is-running](/data/06-portainer-is-running.png)


## Run Edge Agent in K8s and Add It to Portainer
* Create another project for agent  

![10-vscode-open-agent-folder](/data/10-vscode-open-agent-folder.png)

* Create an environment as the below image  

![11-create-edge-k8s-environment](/data/11-create-edge-k8s-environment.png)

* Copy the token  

![12-click-copy-token](/data/12-click-copy-token.png)

* Paste the token to the "CE_K8S_EDGE_KEY" field in the tasks.json file  

![13-past-token-to-tasks](/data/13-past-token-to-tasks.png)

* Select the "CE-Edge-K8s" debug configure and click run button  

![14-click-ce-edge-k8s](/data/14-click-ce-edge-k8s.png)

* Wait for a while until the building done  

![15-wait-for-started-agent](/data/15-wait-for-started-agent.png)

* Then the edge-k8s environment should be heatbeat   

![16-edge-k8s-is-up](/data/16-edge-k8s-is-up.png)


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
* What do folders `data-ce` and `data-ee` do 
* How to clean all environments
* How to access portainer.db

