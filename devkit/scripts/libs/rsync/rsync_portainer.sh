#!/usr/bin/env bash

_pre_rsync_portainer() {
  kill_dlv
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
  MSG1="⭐️ Copying Portainer..."
  MSG2="✅ Copied Portainer"
  MSG3="❌ Failed to Copy Portainer"

  echo && echo "$MSG1" &&
  (_pre_rsync_portainer && _do_rsync_portainer && echo "$MSG2") ||
  (echo "$MSG3" && false)
}