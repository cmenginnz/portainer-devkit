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