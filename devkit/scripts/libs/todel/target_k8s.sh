#!/usr/bin/env bash

k8s_exist() {
  docker container inspect "$TARGET_K8S_CONTAINER_NAME" >/dev/null 2>&1
}

start_k8s() {
  cat <<EOF | KIND_EXPERIMENTAL_DOCKER_NETWORK="$NETWORK_NAME" kind create cluster --name "$TARGET_K8S_NAME" --wait 1m --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: $AGENT_DLV_PORT_IN_K8S
    hostPort: $AGENT_DLV_PORT_IN_K8S
  - containerPort: $PORTAINER_DLV_PORT_IN_K8S
    hostPort: $PORTAINER_DLV_PORT_IN_K8S
  - containerPort: 9000
    hostPort: $PORTAINER_HTTP_PORT_IN_K8S
  - containerPort: 9443
    hostPort: $PORTAINER_HTTPS_PORT_IN_K8S
EOF
}

fix_kubeconfig() {
  sed -i s/127.0.0.1:.*/${TARGET_IP}:6443/g ~/.kube/config
}

ensure_kind_k8s() {
  MSG1="⭐️ Finding K8s..."
  MSG2="✅ Found K8s"
  MSG3="✅ Not found K8s"
  MSG4="⭐️ Starting K8s..."
  MSG5="✅ Created K8s"
  MSG6="❌ Failed to start K8s"

  (echo && echo "$MSG1" && k8s_exist && echo "$MSG2") ||
  (echo "$MSG3" && echo "$MSG4" && start_k8s && fix_kubeconfig && echo "$MSG5") ||
  (echo "$MSG6" && false)
}

deploy_agent_pod() {
  kubectl apply -f /scripts/libs/portainer-k8s-agent-builder.yaml
}

ensure_agent_pod() {
  TARGET_IP=$1

  MSG1="⭐️ Deploying Agent Pod..."
  MSG2="✅ Created Agent Pod"
  MSG3="❌ Failed to Deploy Agent Pod"

  (echo && echo "$MSG1" && deploy_agent_pod && wait_for_sshd_up "$TARGET_IP" && echo "$MSG2") ||
  (echo "$MSG3" && false)
}

start_agent_in_k8s_target() {
  scp_agent_to_target "$TARGET_IP"

  POD=$(kubectl get pod -l app=portainer-agent -n portainer -o jsonpath="{.items[0].metadata.name}")
  kubectl exec -it -n portainer "$POD" -- /app/start-agent-dlv.sh "$TARGET_IP" "$AGENT_DLV_PORT_IN_K8S" "$TARGET" "$AGENT_TYPE" "$EDGE_KEY"
}

ask_k8s_start_portainer() {
  local DLV_PORT=$1
  local DATA_PATH=$2      # /data-ce | /data-ee

  debug "[ask_k8s_start_portainer()] DLV_PORT='$DLV_PORT' DATA_PATH='$DATA_PATH'"

  POD=$(kubectl get pod -l app=portainer-agent -n portainer -o jsonpath="{.items[0].metadata.name}") &&
  (tmux kill-session -t backend-k8s || true) && sleep 1 &&
  tmux new -d -s backend-k8s \
    kubectl exec -it -n portainer "$POD" -- /app/start-portainer-dlv.sh "$DLV_PORT" "$DATA_PATH"
}


ensure_target_k8s() {
  TARGET_IP=$1
  DLV_PORT=$2       # ignored
  TARGET=$3         # k8s (ignored)
  AGENT_TYPE=$4     # agent|edge-agent
  EDGE_KEY=$5       # optional

  debug "[target_k8s.sh] [ensure_target_k8s()] args='$*'"

  ensure_kind_k8s &&
  ensure_agent_pod "$TARGET_IP" &&
  start_agent_in_k8s_target
}
