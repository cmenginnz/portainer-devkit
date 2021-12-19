#!/usr/bin/env bash

_ls_docker_sock() {
  docker exec "$TARGET_NAME" ls -l /var/run/docker.sock >>"${STDOUT}" 2>&1
}

wait_for_target_up() {
  local MSG0="Wait for ${TARGET^}"

  until _ls_docker_sock; do
    msg_ing "${MSG0}"
    sleep 3;
  done
  msg_ok "${MSG0}"
}
