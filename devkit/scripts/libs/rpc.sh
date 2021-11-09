#!/usr/bin/env bash

rpc() {
  RPC_TARGET=$1   # devkit

    if [[ $RPC_TARGET == "devkit" ]]; then
      echo docker exec -it \
        -e DEVKIT_DEBUG="$DEVKIT_DEBUG" \
        "$DEVKIT_NAME" \
        "$DEVKIT_SH_PATH" \
        "$ARGS"
    else
      # I am in HOST
      echo
    fi

}

rpc_dlv() {
#  # docker agent
#  sshpass -p "root" ssh root@"$TARGET_IP" /app/start-agent-dlv.sh "$TARGET_IP" "$DLV_PORT" "$TARGET" "$AGENT_TYPE" "$EDGE_KEY"
#
#  # swarm agent
#  sshpass -p "root" ssh root@"$TARGET_IP" /app/start-agent-dlv.sh "$TARGET_IP" "$DLV_PORT" "$TARGET" "$AGENT_TYPE" "$EDGE_KEY"
#
#  # k8s agent
#  POD=$(kubectl get pod -l app=portainer-agent -n portainer -o jsonpath="{.items[0].metadata.name}")
#  kubectl exec -it -n portainer "$POD" -- /app/start-agent-dlv.sh "$TARGET_IP" "$AGENT_DLV_PORT_IN_K8S" "$TARGET" "$AGENT_TYPE" "$EDGE_KEY"
#
#  # k8s portainer
#  kubectl exec -it -n portainer "$POD" -- /app/start-portainer-dlv.sh "$DLV_PORT" "$DATA_PATH"


#  # non k8s
#  ssh -p "$SSH_PASSWORD" ssh "root@$TARGET_IP" \
#    /app/scripts/devkit.sh dlv exec "$PROGRAM"
#
#  # k8s
#  POD=$(kubectl get pod -l app=portainer-agent -n portainer -o jsonpath="{.items[0].metadata.name}")
#  kubectl exec -it -n portainer "$POD" -- \
#    /app/scripts/devkit.sh dlv exec "$PROGRAM"

  echo "rpc_dlv()"

  TMUX_NAME=tmux_test

  if [ "$TARGET" == "k8s" ]; then
    POD=$(kubectl get pod -l app=portainer-agent -n portainer -o jsonpath="{.items[0].metadata.name}")
    RPC_CMDER=" kubectl exec -it -n portainer $POD -- "
  else
    RPC_CMDER=" ssh -p $SSH_PASSWORD ssh root@$TARGET_IP "
  fi

  ENV_VAR_LIST="DLV_PORT=$DLV_PORT;DATA_PATH=$DATA_PATH;EDGE_KEY=$EDGE_KEY;DEVKIT_DEBUG=$DEVKIT_DEBUG;"
  RPC_CMDEE=" /app/scripts/devkit.sh dlv --wd /app exec $PROGRAM $ENV_VAR_LIST "

  debug "TMUX_NAME=$TMUX_NAME"
  debug "RPC_CMDER=$RPC_CMDER"
  debug "RPC_CMDEE=$RPC_CMDEE"

  tmux new -d -s $TMUX_NAME $RPC_CMDER $RPC_CMDEE
}