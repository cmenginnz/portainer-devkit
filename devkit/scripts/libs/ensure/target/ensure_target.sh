#!/usr/bin/env bash

source "${CURRENT_FILE_PATH}/libs/ensure/target/create/create_target_workspace.sh"
source "${CURRENT_FILE_PATH}/libs/ensure/target/create/create_target_docker.sh"
source "${CURRENT_FILE_PATH}/libs/ensure/target/create/create_target_swarm.sh"
source "${CURRENT_FILE_PATH}/libs/ensure/target/create/create_target_k8s.sh"
source "${CURRENT_FILE_PATH}/libs/ensure/target/create/create_target_nomad.sh"
source "${CURRENT_FILE_PATH}/libs/ensure/target/create/wait_for_target_up.sh"

_target_exist() {
  docker container inspect "$TARGET_NAME" >/dev/null 2>&1
}

_create_target() {
  if [[ $TARGET == "workspace" ]]; then
    create_target_workspace
  elif [[ $TARGET == "docker" ]]; then
     create_target_docker
  elif [[ $TARGET == "swarm" ]]; then
     create_target_swarm
  elif [[ $TARGET == "k8s" ]]; then
     create_target_k8s
  elif [[ $TARGET == "nomad" ]]; then
     create_target_nomad
  fi
}

ensure_target() {
  local MSG0="Find ${TARGET^}"
  local MSG1="Start ${TARGET^}"

  (msg && msg_ing "${MSG0}" && _target_exist && msg_ok "${MSG0}") ||
  (msg_warn "${MSG0}" && msg && msg_ing "${MSG1}" && _create_target && msg_ok "${MSG1}") ||
  (msg_fail "${MSG1}" && false)
}
