#!/usr/bin/env bash

rpc() {
  RPC_TARGET=$1   # workspace

    if [[ $RPC_TARGET == "workspace" ]]; then
      echo docker exec -it \
        -e DEVKIT_DEBUG="$DEVKIT_DEBUG" \
        "$TARGET_WORKSPACE_NAME" \
        "$DEVKIT_SH_PATH" \
        "$ARGS"
    else
      # I am in HOST
      echo
    fi

}
