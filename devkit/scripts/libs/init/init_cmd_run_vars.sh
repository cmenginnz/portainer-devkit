#!/usr/bin/env bash

init_cmd_run_vars() {
  eval TARGET_IP=\$TARGET_IP_${TARGET^^}
  eval TARGET_NAME=\$TARGET_NAME_${TARGET^^}
  debug "TARGET_IP=$TARGET_IP"
  debug "TARGET_NAME=$TARGET_NAME"

  [[ $PROJECT == "portainer" ]] && P="PORTAINER" || P="AGENT"
  eval DLV_PORT=\$DLV_PORT_${P}_${TARGET^^}
  debug "DLV_PORT=$DLV_PORT"

  [[ "$PROJECT_ROOT_PATH" == *portainer-ee ]] && PROJECT_VER=ee || PROJECT_VER=ce
  debug "PROJECT_VER=$PROJECT_VER"

  [[ $PROJECT_VER == "ce" ]] && DATA_PATH="$HOME/data-ce" || DATA_PATH="$HOME/data-ee"
  debug "DATA_PATH=$DATA_PATH"
}
