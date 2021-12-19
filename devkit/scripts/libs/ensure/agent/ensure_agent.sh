#!/usr/bin/env bash


source "${CURRENT_FILE_PATH}/libs/ensure/agent/create/create_agent_docker.sh"
source "${CURRENT_FILE_PATH}/libs/ensure/agent/create/create_agent_swarm.sh"
source "${CURRENT_FILE_PATH}/libs/ensure/agent/create/create_agent_k8s.sh"

source "${CURRENT_FILE_PATH}/libs/ensure/agent/exist/exist_agent_docker.sh"
source "${CURRENT_FILE_PATH}/libs/ensure/agent/exist/exist_agent_swarm.sh"
source "${CURRENT_FILE_PATH}/libs/ensure/agent/exist/exist_agent_k8s.sh"


_exist_agent() {
  if [[ $TARGET == "docker" ]]; then
     exist_agent_docker
  elif [[ $TARGET == "swarm" ]]; then
     exist_agent_swarm
  elif [[ $TARGET == "k8s" ]]; then
     exist_agent_k8s
  fi
}

_create_agent() {
  if [[ $TARGET == "docker" ]]; then
     create_agent_docker
  elif [[ $TARGET == "swarm" ]]; then
     create_agent_swarm
  elif [[ $TARGET == "k8s" ]]; then
     create_agent_k8s
  fi
}

ensure_agent() {
  [[ ${TARGET} == "workspace" ]] && return 0

  local MSG0="Find ${TARGET^} Agent"
  local MSG1="Start ${TARGET^} Agent"

  (msg && msg_ing "${MSG0}" && _exist_agent && msg_ok "${MSG0}") ||
  (msg_warn "${MSG0}" && msg && msg_ing "${MSG1}" && _create_agent && msg_ok "${MSG1}") ||
  (msg_fail "${MSG1}" && false)
}
