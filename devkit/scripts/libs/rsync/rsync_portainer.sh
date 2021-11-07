#!/usr/bin/env bash

rsync_portainer() {
  sshpass -p "$SSH_PASSWORD" \
    rsync \
      "$PROJECT_ROOT_PATH/dist/*" \
      "/home/workspace/portainer-devkit/devkit/scripts" \
      "/home/workspace/go/bin/dlv" \
      "root@$TARGET_IP:/app"
}

