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
