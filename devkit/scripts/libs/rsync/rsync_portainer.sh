#!/usr/bin/env bash

_pre_rsync_portainer() {
  rpc_kill_dlv
}

_do_rsync_portainer() {
  sshpass -p "$SSH_PASSWORD" \
    rsync -r \
      "$PROJECT_ROOT_PATH/dist/" \
      "/home/workspace/portainer-devkit/devkit/scripts" \
      "/home/workspace/go/bin/dlv" \
      "root@$TARGET_IP:/app"
}

rsync_portainer() {
  MSG1="$E_START️ Copying Portainer..."
  MSG2="$E_OK Copied Portainer"
  MSG3="$E_FAIL Failed to Copy Portainer"

  echo && echo "$MSG1" &&
  (_pre_rsync_portainer && _do_rsync_portainer && echo "$MSG2") ||
  (echo "$MSG3" && false)
}