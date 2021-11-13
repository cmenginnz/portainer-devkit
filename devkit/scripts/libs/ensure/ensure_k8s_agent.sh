#!/usr/bin/env bash

_deploy_agent_pod() {
  kubectl apply -f "${CURRENT_FILE_PATH}/libs/portainer-k8s-agent-builder.yaml"
}

ensure_k8s_agent() {
  MSG1="$E_START️ Deploying Agent Pod..."
  MSG2="$E_OK Created Agent Pod"
  MSG3="$E_FAIL Failed to Deploy Agent Pod"


  (echo && echo "$MSG1" && _deploy_agent_pod && wait_for_sshd_up && echo "$MSG2") ||
  (echo "$MSG3" && false)
}