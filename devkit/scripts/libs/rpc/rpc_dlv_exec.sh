#!/usr/bin/env bash

_rpc_dlv_exec_kill_tmux() {
  tmux kill-session -t "${TMUX_NAME}" 2>>"${STDOUT}" 1>&2
}

_rpc_dlv_exec_tmux() {
  TMUX_NAME="tmux-$PROJECT-$TARGET"
  TMUX_CMD="tmux new -d -s $TMUX_NAME"
}

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
  _rpc_dlv_exec_tmux
  _rpc_dlv_exec_cmder
  _rpc_dlv_exec_cmdee

  _rpc_dlv_exec_kill_tmux

  RPC_DLV_FULL_CMD="$TMUX_CMD $RPC_DLV_CMDER $RPC_DLV_CMDEE"
  debug_var "RPC_DLV_FULL_CMD"

  eval "${RPC_DLV_FULL_CMD}"

  sleep 1
  tmux set-option -w remain-on-exit
}

rpc_dlv_exec() {
  MSG0="RPC DLV Portainer"
  MSG1=$(msg_ing)
  MSG2=$(msg_ok)
  MSG3=$(msg_fail)

  MSG0=$DLV_EXEC_FULL_CMD
  MSG4=$(msg_ing)

  echo && echo "$MSG1" && echo "$MSG4" &&
  (_do_rpc_dlv_exec && echo "$MSG2") ||
  (echo "$MSG3" && false)
}