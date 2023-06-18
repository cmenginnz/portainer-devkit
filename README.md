# Portainer DevKit For MacOS

## 1. Install minikube
```
brew install minikube
```

## 2. Build agent image
```
cd dockerfiles/agent
./build
./push latest
```

## 3. Agent for docker
### Start/Stop Agent
```
cd devkit/docker
./go
./stop
```

### SSH into agent
```
ssh -p 29022 root@localhost
```
password: portainer


## 4. K8s
### Start/Stop Agent for K8s
```
cd devkit/k8s
./go
./stop
```

### SSH into agent
```
ssh -p 30022 root@localhost
```
password: portainer


## 5. Create Run/Debug Configurations
```
1. Run on: 
create a target of SSH type

2. Run kind: 
Direcotry

3. Directory: 
/Users/cmeng/Work/devkit/agent/cmd/agent

4. Working directory: 
/Users/cmeng/Work/devkit/agent/dist

5. Environment:
AGENT_CLUSTER_ADDR=portainer-agent-headless;
ASSETS_PATH=/app;
DATA_PATH=/data;
EDGE=1;
EDGE_ASYNC=0;
EDGE_ID=k8s-AEEC;
EDGE_INSECURE_POLL=1;
EDGE_KEY=aHR0cDovL2hvc3QuZG9ja2VyLmludGVybmFsOjkwMDB8aG9zdC5kb2NrZXIuaW50ZXJuYWw6ODAwMHw4YTo0NDpiNzphNTowNTo5OToyMDozMjpmYTo3YjozMjozYjphNjo3NDo2NjoyNnww;
LOG_LEVEL=DEBUG;
PORTAINER_TAGS=1

raw EDGE_KEY:
http://host.docker.internal:9000|host.docker.internal:8000|8a:44:b7:a5:05:99:20:32:fa:7b:32:3b:a6:74:66:26|0

6. Go tool arguments: 
-o /Users/cmeng/Work/devkit/agent/dist/agent
```