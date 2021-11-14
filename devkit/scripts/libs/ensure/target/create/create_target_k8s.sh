#!/usr/bin/env bash

_do_create_target_k8s() {
  cat <<EOF | KIND_EXPERIMENTAL_DOCKER_NETWORK="$NETWORK_NAME" kind create cluster --name "$TARGET_NAME_K8S_KIND" --wait 1m --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: $DLV_PORT_PORTAINER_K8S
    hostPort: $DLV_PORT_PORTAINER_K8S
  - containerPort: $DLV_PORT_AGENT_K8S
    hostPort: $DLV_PORT_AGENT_K8S
  - containerPort: 9000
    hostPort: $PORTAINER_PORT_HTTP_K8S
  - containerPort: 9443
    hostPort: $PORTAINER_PORT_HTTPS_K8S
EOF
}

_fix_kubeconfig() {
  sed -i s/127.0.0.1:.*/"$TARGET_IP":6443/g ~/.kube/config
}

create_target_k8s() {
  _do_create_target_k8s && _fix_kubeconfig
}