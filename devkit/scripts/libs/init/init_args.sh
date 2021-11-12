#!/usr/bin/env bash

init_args() {
  debug "[init_args.sh] [init_args()] args=$*"

  ARGS="$@"
  COMMAND="$1"

  if [ $COMMAND == "run" ]; then
    PROGRAM=$2
    TARGET=$3
    EDGE_KEY=$4
  fi

  if [ $COMMAND == "dlv" ]; then
    SUB_CMD=$2
    PROGRAM=$3
    ENV_VAR_LIST=$4

    DLV_PORT=23451

    _export_env_var_list
  fi

  if [ $COMMAND == "ensure" ]; then
    PROGRAM=$2
  fi
}

_export_env_var_list() {
  export "${ENV_VAR_LIST/:/' '}"
}
