#!/usr/bin/env bash

source "${CURRENT_FILE_PATH}/libs/ensure/target/create/create_target_workspace.sh"
source "${CURRENT_FILE_PATH}/libs/ensure/target/create/create_target_docker.sh"
source "${CURRENT_FILE_PATH}/libs/ensure/target/create/create_target_swarm.sh"
source "${CURRENT_FILE_PATH}/libs/ensure/target/create/create_target_k8s.sh"
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
  fi
}

ensure_target() {
  MSG0="Find ${TARGET^}"
  MSG1=$(msg_ing)
  MSG2=$(msg_ok)
  MSG3=$(msg_warn)

  MSG0="Start ${TARGET^}"
  MSG4=$(msg_ing)
  MSG5=$(msg_ok)
  MSG6=$(msg_fail)

  (echo && echo "$MSG1" && _target_exist && echo "$MSG2") ||
  (echo "$MSG3" && echo && echo "$MSG4" && _create_target && echo "$MSG5") ||
  (echo "$MSG6" && false)
}
