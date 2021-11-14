#!/usr/bin/env bash

init_cmd_run_vars() {
  eval TARGET_IP=\$TARGET_IP_${TARGET^^}
  debug_var "TARGET_IP"

  eval TARGET_NAME=\$TARGET_NAME_${TARGET^^}
  debug_var "TARGET_NAME"

  [[ $PROJECT == "portainer" ]] && P="PORTAINER" || P="AGENT"
  eval DLV_PORT=\$DLV_PORT_${P}_${TARGET^^}
  debug_var "DLV_PORT"


  if [ "${PROJECT}" == "portainer" ]; then
    [[ "$PROJECT_ROOT_PATH" == *portainer-ee ]] && PROJECT_VER=ee || PROJECT_VER=ce
  fi
  debug_var "PROJECT_VER"


  [[ $PROJECT_VER == "ce" ]] && DATA_PATH="${VSCODE_HOME}/data-ce" || DATA_PATH="${VSCODE_HOME}/data-ee"
  debug_var "DATA_PATH"
}
