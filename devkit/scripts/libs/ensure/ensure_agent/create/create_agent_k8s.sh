#!/usr/bin/env bash

_do_create_agent_k8s() {
  kubectl apply -f "${CURRENT_FILE_PATH}/libs/portainer-k8s-agent-builder.yaml"
}

create_agent_k8s() {
  _do_create_agent_k8s
}