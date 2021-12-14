#!/usr/bin/env bash

# CLI Usage
# devkit.sh  run     PROJECT      TARGET    [EDGE_KEY]       # PROJECT=portainer|agent|edge   TARGET=docker|swarm|k8s|workspace
# devkit.sh  dlv     exec|kill    PROJECT   ENV_VAR_LIST     # PROJECT=portainer|agent|edge   ENV_VAR_LIST=DLV_PORT:DATA_PATH:EDGE_KEY:DEVKIT_DEBUG
# devkit.sh  init                                            #
# devkit.sh  ensure  TARGET                                  # TARGET=docker|swarm|k8s|workspace|network
# devkit.sh  clean   targets|all                             #


#echo "🏁️ $COMMAND $PROJECT in $TARGET..." && echo

_init() {
  CURRENT_FILE_PATH=$(dirname $0)
  [[ $CURRENT_FILE_PATH != /* ]]  && CURRENT_FILE_PATH="$PWD/$CURRENT_FILE_PATH"

  source "${CURRENT_FILE_PATH}/libs/consts.sh"
  source "${CURRENT_FILE_PATH}/libs/helpers.sh"

  source "${CURRENT_FILE_PATH}/libs/ensure/ensure_network.sh"
  source "${CURRENT_FILE_PATH}/libs/ensure/ensure_webpack.sh"
  source "${CURRENT_FILE_PATH}/libs/ensure/target/ensure_target.sh"
  source "${CURRENT_FILE_PATH}/libs/ensure/agent/ensure_agent.sh"

  source "${CURRENT_FILE_PATH}/libs/rpc/rpc_dlv_exec.sh"
  source "${CURRENT_FILE_PATH}/libs/rpc/rpc_dlv_kill.sh"

  source "${CURRENT_FILE_PATH}/libs/cmd/cmd_run.sh"
  source "${CURRENT_FILE_PATH}/libs/cmd/cmd_dlv.sh"

  source "${CURRENT_FILE_PATH}/libs/run/run_portainer.sh"
  source "${CURRENT_FILE_PATH}/libs/run/run_agent.sh"

  source "${CURRENT_FILE_PATH}/libs/build/build_project.sh"

  source "${CURRENT_FILE_PATH}/libs/rsync/rsync_project.sh"

  source "${CURRENT_FILE_PATH}/libs/dlv/dlv_exec.sh"

  source "${CURRENT_FILE_PATH}/libs/logs/debug.sh"
  source "${CURRENT_FILE_PATH}/libs/logs/msg.sh"

  source "${CURRENT_FILE_PATH}/libs/tmux/tmux_has_window.sh"
  source "${CURRENT_FILE_PATH}/libs/tmux/tmux_kill_dead_window.sh"
  source "${CURRENT_FILE_PATH}/libs/tmux/tmux_kill_window.sh"
  source "${CURRENT_FILE_PATH}/libs/tmux/tmux_new_window.sh"

  source "${CURRENT_FILE_PATH}/libs/init/init_args.sh"
  source "${CURRENT_FILE_PATH}/libs/init/init_common_vars.sh"
  source "${CURRENT_FILE_PATH}/libs/init/init_cmd_run_vars.sh"

  init_args "$@"
  init_common_vars
}
_init "$@"

_clean() {
  {
    docker stop "${TARGET_NAME_K8S}" >>"$STDOUT"  &&  docker rm "$TARGET_NAME_K8S";
    docker stop "${TARGET_NAME_SWARM}" >>"$STDOUT";
    docker stop "${TARGET_NAME_DOCKER}" >>"$STDOUT";
    docker stop "${TARGET_NAME_WORKSPACE}" >>"$STDOUT";
  }  #>>"$STDOUT" 2>&1;
  echo "Removed all targets"
}

_ensure() {
  if [[ "${TARGET}" == "network" ]]; then
    ensure_network
  else
    ensure_target
  fi
}

main() {
  case $COMMAND in
  run)
    init_cmd_run_vars
    [[ "$DEBKIT_DEBUG"=="true" ]] && echo
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