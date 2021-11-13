#!/usr/bin/env bash

init_args() {
  ARGS="$@"
  COMMAND="$1"

  if [ $COMMAND == "run" ]; then
    PROJECT=$2
    TARGET=$3
    EDGE_KEY=$4

    [[ $PROJECT == "edge" && $EDGE_KEY == "" ]] && echo "EDGE_KEY is not set in tasks.json" && exit 1
  fi

  if [ $COMMAND == "dlv" ]; then
    SUB_CMD=$2
    PROJECT=$3
    ENV_VAR_LIST=$4

    _export_env_var_list
  fi

  if [ $COMMAND == "ensure" ]; then
    PROJECT=$2
  fi

  debug "[devkit.sh] [init_args()] args='$ARGS'"
  debug "[devkit.sh] [init_args()] I_AM_IN=$I_AM_IN"
  debug "[devkit.sh] [init_args()] CURRENT_FILE_PATH=$CURRENT_FILE_PATH"
  debug "[devkit.sh] [init_args()] COMMAND=$COMMAND"
  debug "[devkit.sh] [init_args()] PROJECT=$PROJECT"
  debug "[devkit.sh] [init_args()] TARGET=$TARGET"
  debug "[devkit.sh] [init_args()] EDGE_KEY=$EDGE_KEY"
}

_export_env_var_list() {
  export ${ENV_VAR_LIST//:/' '}
}
