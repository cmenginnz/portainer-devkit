#!/usr/bin/env bash

init_cmd_run_vars() {
  [[ $PROJECT == "portainer" ]] && P="PORTAINER" || P="AGENT"
  eval DLV_PORT=\$DLV_PORT_${P}_${TARGET^^}
  debug_var "DLV_PORT"


  if [ "${PROJECT}" == "portainer" ]; then
    [[ "$PROJECT_ROOT_PATH" == *portainer-ee ]] && PROJECT_VER=ee || PROJECT_VER=ce
    local project_ver_dash="-"
  fi
  debug_var "PROJECT_VER"


  [[ $PROJECT_VER == "ce" ]] && DATA_PATH="${VSCODE_HOME}/data-ce" || DATA_PATH="${VSCODE_HOME}/data-ee"
  debug_var "DATA_PATH"

  DLV_WORK_DIR="/home/workspace/app-${PROJECT}${project_ver_dash}${PROJECT_VER}"
  debug_var "DLV_WORK_DIR"

  [[ $TARGET = "workspace" ]] && SSH_USER_REAL="$SSH_USER" || SSH_USER_REAL="root"
  debug_var "SSH_USER_REAL"
}
