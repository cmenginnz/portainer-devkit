#!/usr/bin/env bash


# CLI Usage
#            COMMAND  SUB_CMD        PROGRAM                       TARGET
# devkit.sh  run                     portainer|agent|edge-agent    docker|swarm|k8s|workspace             [EDGE_KEY]

# devkit.sh  dlv      exec|kill      portainer|agent|edge-agent                                           ENV_VAR_LIST
# env: DLV_PORT DATA_PATH EDGE_KEY DEVKIT_DEBUG

# devkit.sh  init

# devkit.sh  ensure                                                docker|swarm|k8s|workspace|network

# devkit.sh  clean                                                 targets|all




#COMMAND=$1
#PROGRAM=$2
#TARGET=$3
#EDGE_KEY=$4
#
#ARGS="$@"
#
#echo "🏁️ $COMMAND $PROGRAM in $TARGET..." && echo

# init is shared between several files in this project. Sync it all the time.
_init() {
  CURRENT_FILE_PATH=$(dirname $0)   # /home/workspace/portainer-devkit/devkit/scripts

  source "${CURRENT_FILE_PATH}/libs/consts.sh"
  source "${CURRENT_FILE_PATH}/libs/helpers.sh"
  source "${CURRENT_FILE_PATH}/libs/ensure/ensure_network.sh"
  source "${CURRENT_FILE_PATH}/libs/ensure/ensure_workspace.sh"
  source "${CURRENT_FILE_PATH}/libs/ensure/ensure_k8s.sh"
  source "${CURRENT_FILE_PATH}/libs/ensure/ensure_webpack.sh"
  source "${CURRENT_FILE_PATH}/libs/rpc/rpc.sh"
  source "${CURRENT_FILE_PATH}/libs/rpc/rpc_dlv.sh"
  source "${CURRENT_FILE_PATH}/libs/cmd/cmd_run.sh"
  source "${CURRENT_FILE_PATH}/libs/cmd/cmd_dlv.sh"
  source "${CURRENT_FILE_PATH}/libs/run/run_portainer.sh"
  source "${CURRENT_FILE_PATH}/libs/build/build_portainer.sh"
  source "${CURRENT_FILE_PATH}/libs/rsync/rsync_portainer.sh"
  source "${CURRENT_FILE_PATH}/libs/dlv/dlv_portainer.sh"
  source "${CURRENT_FILE_PATH}/libs/init/init_args.sh"

  init_args "$@"
}
_init "$@"

_init_global_variables() {
  debug "[devkit.sh] args='$ARGS'"

  debug "[devkit.sh] [init()] COMMAND=$COMMAND"
  debug "[devkit.sh] [init()] PROGRAM=$PROGRAM"
  debug "[devkit.sh] [init()] TARGET=$TARGET"

  debug "[devkit.sh] [init()] I_AM_IN=$I_AM_IN"

  debug "[devkit.sh] [init()] CURRENT_FILE_PATH=$CURRENT_FILE_PATH"


  TARGET_IP=$(calc_target_ip "$TARGET")
  debug "[devkit.sh] [init()] TARGET_IP=$TARGET_IP"

  if [[ $CURRENT_FILE_PATH == *.vscode* ]]; then
    PROJECT_ROOT_PATH=$(dirname $(dirname $(dirname "$CURRENT_FILE_PATH")))
  else
    PROJECT_ROOT_PATH=$(dirname $(dirname "$CURRENT_FILE_PATH"))
  fi
  debug "[devkit.sh] [init()] PROJECT_ROOT_PATH=$PROJECT_ROOT_PATH"

  WORKSPACE_PATH=$(dirname "$PROJECT_ROOT_PATH")
  debug "[devkit.sh] [init()] WORKSPACE_PATH=$WORKSPACE_PATH"

  [[ "$PROJECT_ROOT_PATH" == *portainer-ee ]] && PROJECT_VER=ee || PROJECT_VER=ce
  debug "[devkit.sh] [init()] PROJECT_VER=$PROJECT_VER"

  #[[ $PROJECT_VER == "ce" ]] && PROJECT_ROOT_PATH="$HOME/portainer" || PROJECT_ROOT_PATH="$HOME/portainer-ee"
  [[ $PROJECT_VER == "ce" ]] && DATA_PATH="$HOME/data-ce" || DATA_PATH="$HOME/data-ee"
  debug "[devkit.sh] [init()] DATA_PATH=$DATA_PATH"

}
_init_global_variables

runXX() {
  case $PROGRAM in
  portainer)
    run_portainer $PROJECT_VER "$TARGET"
    ;;
  agent)
    run_agent "$TARGET" "$PROGRAM"
    ;;
  edge-agent)
    run_agent "$TARGET" "$PROGRAM" "$EDGE_KEY"
    ;;
  *)
    echo "❌ Unknown Program $PROGRAM"
    exit 2
    ;;
  esac
}

_clean() {
  docker stop "$TARGET_K8S_CONTAINER_NAME" >>"$STDOUT" 2>&1  &&  docker rm "$TARGET_K8S_CONTAINER_NAME" >>"$STDOUT" 2>&1
  docker stop "$TARGET_SWARM" >>"$STDOUT" 2>&1
  docker stop "$TARGET_DOCKER_NAME" >>"$STDOUT" 2>&1
  docker stop "$DEVKIT_NAME" >>"$STDOUT" 2>&1
  echo "Removed all targets"
}

_ensure() {
  if [[ $PROGRAM == "network" ]]; then
    ensure_network
  elif [[ "$PROGRAM" == "devkit" ]]; then
    ensure_devkit
  fi
}

main() {
  case $COMMAND in
  run)
    cmd_run
    ;;
  dlv)
    cmd_dlv
    ;;
  ensure)
    _ensure
    ;;
  clean)
    _clean
    ;;
  *)
    echo "❌ Unknown command"
    exit 1
    ;;
  esac
}

main