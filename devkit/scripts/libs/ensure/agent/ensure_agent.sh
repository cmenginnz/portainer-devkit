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

  MSG0="Find ${TARGET^} Agent"
  MSG1=$(msg_ing)
  MSG2=$(msg_ok)
  MSG3=$(msg_warn)

  MSG0="Start ${TARGET^} Agent"
  MSG4=$(msg_ing)
  MSG5=$(msg_ok)
  MSG6=$(msg_fail)

  (echo && echo "$MSG1" && _exist_agent && echo "$MSG2") ||
  (echo "$MSG3" && echo && echo "$MSG4" && _create_agent && echo "$MSG5") ||
  (echo "$MSG6" && false)
}
