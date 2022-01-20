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
    TARGET=$2

    if [[ "${TARGET}" == "workspace" ]]; then
      PORTAINER_WORKSPACE="$3"
      [[ -z "${PORTAINER_WORKSPACE}" ]] && echo "workspace path PORTAINER_WORKSPACE is not specified" && exit 1
    fi

    if [[ "$3" == "agent" ]]; then
      SUB_TARGET="agent"
    fi
  fi

  debug "args='$ARGS'"
  debug_var "CURRENT_FILE_PATH"
  debug_var "COMMAND"
  debug_var "PROJECT"
  debug_var "TARGET"
  debug_var "EDGE_KEY"
}

_export_env_var_list() {
  export ${ENV_VAR_LIST//:/' '}

  [[ $PROJECT == "portainer" && $DATA_PATH == "" ]] && echo "DATA_PATH is not set" && exit 1
  [[ $PROJECT == "edge" && $EDGE_KEY == "" ]] && echo "EDGE_KEY is not set" && exit 1
}
