#!/usr/bin/env bash

_pre_rsync_project() {
  rpc_dlv_kill

  sshpass -p "$SSH_PASSWORD" \
    ssh "$SSH_USER_REAL@${TARGET_IP}" mkdir -p "${DLV_WORK_DIR}"
}

_rsync_shared_files() {
  sshpass -p "$SSH_PASSWORD" \
    rsync -r \
      "$USER_HOME/app/" \
      "$USER_HOME/go/bin/dlv" \
      "${WORKSPACE_PATH}/portainer-devkit/devkit/scripts" \
      "$SSH_USER_REAL@${TARGET_IP}:${DLV_WORK_DIR}"
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
      "$SSH_USER_REAL@${TARGET_IP}:${DLV_WORK_DIR}"
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
}

rsync_project() {
  local MSG0="Copy ${PROJECT^}"

  msg && msg_ing "${MSG0}" &&
  (_pre_rsync_project && _do_rsync_project && msg_ok "${MSG0}") ||
  (msg_fail "${MSG0}" && false)
}