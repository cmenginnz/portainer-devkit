#!/usr/bin/env bash

_pre_rsync_project() {
  rpc_dlv_kill
}

_do_rsync_project() {
  sshpass -p "$SSH_PASSWORD" \
    rsync -r \
      "$PROJECT_ROOT_PATH/dist/" \
      "/home/workspace/portainer-devkit/devkit/scripts" \
      "/home/workspace/go/bin/dlv" \
      "root@$TARGET_IP:/app"
}

rsync_project() {
  MSG0="Copy ${PROJECT^}"
  MSG1=$(msg_ing)
  MSG2=$(msg_ok)
  MSG3=$(msg_fail)

  echo && echo "$MSG1" &&
  (_pre_rsync_project && _do_rsync_project && echo "$MSG2") ||
  (echo "$MSG3" && false)
}