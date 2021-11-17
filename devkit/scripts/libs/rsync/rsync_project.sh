#!/usr/bin/env bash

_pre_rsync_project() {
  rpc_dlv_kill
}

_rsync_shared_files() {
  sshpass -p "$SSH_PASSWORD" \
    rsync -r \
      "/app/" \
      "/go/bin/dlv" \
      "${WORKSPACE_PATH}/portainer-devkit/devkit/scripts" \
      "root@${TARGET_IP}:${DLV_WORK_DIR}"
}

_rsync_dist_files_local() {
  ln -sf \
    "${PROJECT_ROOT_PATH}/dist/public" \
    "${PROJECT_ROOT_PATH}/dist/portainer" \
    "${DLV_WORK_DIR}"
}

_rsync_dist_files_remote() {
  sshpass -p "$SSH_PASSWORD" \
    rsync -r \
      "$PROJECT_ROOT_PATH/dist/" \
      "root@${TARGET_IP}:${DLV_WORK_DIR}"
}

_rsync_dist_files() {
  if [ "${PROJECT}" == "portainer" ] && [ "${TARGET}" == "workspace" ]; then
    _rsync_dist_files_local
  else
    _rsync_dist_files_remote
  fi
}

_do_rsync_project() {
  _rsync_shared_files && _rsync_dist_files
#  sshpass -p "$SSH_PASSWORD" \
#    rsync -r \
#      "$PROJECT_ROOT_PATH/dist/" \
#      "${WORKSPACE_PATH}/portainer-devkit/devkit/scripts" \
#      "${WORKSPACE_PATH}/go/bin/dlv" \
#      "root@$TARGET_IP:/app"
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