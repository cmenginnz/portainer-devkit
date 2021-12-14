#!/usr/bin/env bash

_ls_docker_sock() {
  docker exec "$TARGET_NAME" ls -l /var/run/docker.sock >>$STDOUT 2>&1
}

wait_for_target_up() {
  MSG0="Wait for ${TARGET^}"
  local MSG1=$(msg_ing)
  local MSG2=$(msg_ok)

  until _ls_docker_sock; do
    echo "${MSG1}"
    sleep 3;
  done
  echo "${MSG2}"
}
