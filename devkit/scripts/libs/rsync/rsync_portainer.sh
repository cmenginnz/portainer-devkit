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
  _pre_rsync_portainer && _do_rsync_portainer
}