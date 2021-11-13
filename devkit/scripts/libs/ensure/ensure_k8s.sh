#!/usr/bin/env bash

_k8s_exist() {
  docker container inspect "$TARGET_NAME_K8S_CONTAINER" >/dev/null 2>&1
}

_do_start_k8s() {
  cat <<EOF | KIND_EXPERIMENTAL_DOCKER_NETWORK="$NETWORK_NAME" kind create cluster --name "$TARGET_NAME_K8S" --wait 1m --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: $AGENT_DLV_PORT_K8S
    hostPort: $AGENT_DLV_PORT_K8S
  - containerPort: $PORTAINER_DLV_PORT_K8S
    hostPort: $PORTAINER_DLV_PORT_K8S
  - containerPort: 9000
    hostPort: $PORTAINER_PORT_HTTP_K8S
  - containerPort: 9443
    hostPort: $PORTAINER_PORT_HTTPS_K8S
EOF
}

_fix_kubeconfig() {
  sed -i s/127.0.0.1:.*/"$TARGET_IP":6443/g ~/.kube/config
}

ensure_k8s() {
  MSG1="⭐️ Finding K8s..."
  MSG2="✅ Found K8s"
  MSG3="✅ Not found K8s"
  MSG4="⭐️ Starting K8s..."
  MSG5="✅ Created K8s"
  MSG6="❌ Failed to start K8s"

  (echo && echo "$MSG1" && _k8s_exist && echo "$MSG2") ||
  (echo "$MSG3" && echo "$MSG4" && _do_start_k8s && _fix_kubeconfig && echo "$MSG5") ||
  (echo "$MSG6" && false)
}
