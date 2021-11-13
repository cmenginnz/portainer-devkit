#!/usr/bin/env bash

_do_rpc_dlv() {
  TMUX_NAME=tmux_test

  if [ "$TARGET" == "k8s" ]; then
    POD=$(kubectl get pod -l app=portainer-agent -n portainer -o jsonpath="{.items[0].metadata.name}")
    RPC_CMDER=" kubectl exec -it -n portainer $POD -- "
  else
    RPC_CMDER=" sshpass -p $SSH_PASSWORD ssh root@$TARGET_IP "
  fi

  ENV_VAR_LIST="DLV_PORT=$DLV_PORT:DATA_PATH=$DATA_PATH:EDGE_KEY=$EDGE_KEY:DEVKIT_DEBUG=$DEVKIT_DEBUG:"
  RPC_CMDEE=" /app/scripts/devkit.sh dlv exec $PROJECT $ENV_VAR_LIST "
  FULL_CMD="tmux new -d -s $TMUX_NAME $RPC_CMDER $RPC_CMDEE"

  debug "FULL_CMD=$FULL_CMD"

  eval $FULL_CMD
}

rpc_dlv() {
  MSG1="$E_START️ RPC DLVing Portainer..."
  MSG2="$E_OK RPC DLVed Portainer"
  MSG3="$E_FAIL Failed to RPC DLV Portainer"

  echo && echo "$MSG1" &&
  (_do_rpc_dlv && echo "$MSG2") ||
  (echo "$MSG3" && false)
}

#  # docker agent
#  sshpass -p "root" ssh root@"$TARGET_IP" /app/start-agent-dlv.sh "$TARGET_IP" "$DLV_PORT" "$TARGET" "$AGENT_TYPE" "$EDGE_KEY"
#
#  # swarm agent
#  sshpass -p "root" ssh root@"$TARGET_IP" /app/start-agent-dlv.sh "$TARGET_IP" "$DLV_PORT" "$TARGET" "$AGENT_TYPE" "$EDGE_KEY"
#
#  # k8s agent
#  POD=$(kubectl get pod -l app=portainer-agent -n portainer -o jsonpath="{.items[0].metadata.name}")
#  kubectl exec -it -n portainer "$POD" -- /app/start-agent-dlv.sh "$TARGET_IP" "$AGENT_DLV_PORT_K8S" "$TARGET" "$AGENT_TYPE" "$EDGE_KEY"
#
#  # k8s portainer
#  kubectl exec -it -n portainer "$POD" -- /app/start-portainer-dlv.sh "$DLV_PORT" "$DATA_PATH"


#  # non k8s
#  ssh -p "$SSH_PASSWORD" ssh "root@$TARGET_IP" \
#    /app/scripts/devkit.sh dlv exec "$PROJECT"
#
#  # k8s
#  POD=$(kubectl get pod -l app=portainer-agent -n portainer -o jsonpath="{.items[0].metadata.name}")
#  kubectl exec -it -n portainer "$POD" -- \
#    /app/scripts/devkit.sh dlv exec "$PROJECT"