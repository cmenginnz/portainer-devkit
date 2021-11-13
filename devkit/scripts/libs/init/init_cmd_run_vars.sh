#!/usr/bin/env bash

init_cmd_run_vars() {
  eval TARGET_IP=\$TARGET_${TARGET^^}_IP
  eval TARGET_NAME=\$TARGET_${TARGET^^}_NAME
  debug "[devkit.sh] [init_cmd_run_vars()] TARGET_IP=$TARGET_IP"
  debug "[devkit.sh] [init_cmd_run_vars()] TARGET_NAME=$TARGET_NAME"

  [[ $PROJECT == "portainer" ]] && P="PORTAINER" || P="AGENT"
  eval DLV_PORT=\$DLV_PORT_${P}_IN_${TARGET^^}
  debug "[devkit.sh] [init_cmd_run_vars()] DLV_PORT=$DLV_PORT"

  WORKSPACE_PATH=$(dirname "$PROJECT_ROOT_PATH")
  debug "[devkit.sh] [init_cmd_run_vars()] WORKSPACE_PATH=$WORKSPACE_PATH"

  [[ "$PROJECT_ROOT_PATH" == *portainer-ee ]] && PROJECT_VER=ee || PROJECT_VER=ce
  debug "[devkit.sh] [init_cmd_run_vars()] PROJECT_VER=$PROJECT_VER"

  [[ $PROJECT_VER == "ce" ]] && DATA_PATH="$HOME/data-ce" || DATA_PATH="$HOME/data-ee"
  debug "[devkit.sh] [init_cmd_run_vars()] DATA_PATH=$DATA_PATH"
}
