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
