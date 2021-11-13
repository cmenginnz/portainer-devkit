#!/usr/bin/env bash

_deploy_agent_pod() {
  kubectl apply -f "${CURRENT_FILE_PATH}/libs/portainer-k8s-agent-builder.yaml"
}

ensure_k8s_agent() {
  MSG0="Create K8s Agent Pod"
  MSG1=$(msg_ing)
  MSG2=$(msg_ok)
  MSG3=$(msg_fail)


  (echo && echo "$MSG1" && _deploy_agent_pod && wait_for_sshd_up && echo "$MSG2") ||
  (echo "$MSG3" && false)
}