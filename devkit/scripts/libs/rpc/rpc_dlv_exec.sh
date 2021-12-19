#!/usr/bin/env bash

_rpc_dlv_exec_cmder() {
  if [ "$TARGET" == "k8s" ]; then
    POD=$(kubectl get pod -l app=portainer-agent -n portainer -o jsonpath="{.items[0].metadata.name}")
    RPC_DLV_CMDER="kubectl exec -it -n portainer $POD --"
  else
    RPC_DLV_CMDER="sshpass -p $SSH_PASSWORD ssh $SSH_USER_REAL@$TARGET_IP"
  fi
}

_list_append() {
  [[ -z "${ENV_VAR_LIST}" ]] && ENV_VAR_LIST="$1" || ENV_VAR_LIST="$ENV_VAR_LIST:$1"
}

_list_add_var() {
  local var_name=$1
  eval local var_value=\$${var_name}
  _list_append "${var_name}=${var_value}"
}

_make_env_var_list() {
  _list_add_var "DLV_PORT"
  _list_add_var "DEVKIT_DEBUG"
  _list_add_var "DLV_WORK_DIR"

  [[ $TARGET == "k8s" ]] && _list_append "AGENT_CLUSTER_ADDR=portainer-agent-headless"
  [[ $TARGET == "swarm" ]] && _list_append "AGENT_CLUSTER_ADDR=tasks.portainer_edge_agent"

  [[ $PROJECT == "portainer" ]] && _list_add_var "DATA_PATH"
  [[ $PROJECT == "edge" ]] && _list_append "EDGE=1:EDGE_INSECURE_POLL=1:EDGE_ID=devkit-edge-id:EDGE_KEY=$EDGE_KEY"
}

_rpc_dlv_exec_cmdee() {
  _make_env_var_list
  RPC_DLV_CMDEE="${DLV_WORK_DIR}/scripts/devkit.sh dlv exec $PROJECT $ENV_VAR_LIST"
}

_do_rpc_dlv_exec() {
  _rpc_dlv_exec_cmder
  _rpc_dlv_exec_cmdee

  RPC_DLV_FULL_CMD="$RPC_DLV_CMDER $RPC_DLV_CMDEE"

  msg_ing "${RPC_DLV_FULL_CMD}"

  tmux_kill_window "$TMUX_SESSION_NAME" "$TMUX_WINDOW_NAME"
  tmux_new_window "$TMUX_SESSION_NAME" "$TMUX_WINDOW_NAME" "$RPC_DLV_FULL_CMD"
}

rpc_dlv_exec() {
  local MSG0="RPC DLV Portainer"

  msg && msg_ing "${MSG0}" &&
  (_do_rpc_dlv_exec && msg_ok "${MSG0}") ||
  (msg_fail "${MSG0}" && false)
}