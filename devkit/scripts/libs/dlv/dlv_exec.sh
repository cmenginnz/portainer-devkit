#!/usr/bin/env bash

_make_data_dir() {
  [[ $PROJECT == "portainer" ]] && mkdir -p $DATA_PATH
}

_dlv_exec_cmder() {
  DLV_EXEC_CMDER="${DLV_WORK_DIR}/dlv --listen=0.0.0.0:"$DLV_PORT" --headless=true --api-version=2 --check-go-version=false --only-same-user=false exec"
}

_dlv_exec_cmdee() {
  [[ $PROJECT == "portainer" ]] &&
  DLV_EXEC_CMDEE="${DLV_WORK_DIR}/portainer -- --data "$DATA_PATH" --assets ${DLV_WORK_DIR}" ||
  DLV_EXEC_CMDEE="${DLV_WORK_DIR}/agent"
}

_do_dlv_exec() {
  debug_var "DLV_PORT"
  debug_var "DATA_PATH"

  _make_data_dir
  _dlv_exec_cmder
  _dlv_exec_cmdee

  DLV_EXEC_FULL_CMD="$DLV_EXEC_CMDER $DLV_EXEC_CMDEE"

  debug_var "DLV_EXEC_FULL_CMD"

  eval $DLV_EXEC_FULL_CMD
}

dlv_exec() {
  MSG0="DLV Exec ${PROJECT^}"
  MSG1=$(msg_ing)
  MSG2=$(msg_ok)
  MSG3=$(msg_fail)

  MSG0="Press 'ctrl+b x' to Quit Terminal"
  MSG4=$(msg_ing)

  MSG0=$DLV_EXEC_FULL_CMD
  MSG5=$(msg_ing)

  echo && echo "$MSG1" && echo "$MSG5"
  (_do_dlv_exec && echo && echo "$MSG2" && echo "${MSG4}") ||
  (echo "$MSG3" && false)
}