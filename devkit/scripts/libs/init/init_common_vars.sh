#!/usr/bin/env bash

_init_common_var_dev_mod() {
  DEV_MODE=1
  local dev_content="ref: refs/heads/dev"
  local git_head_file="${WORKSPACE_PATH}/portainer-devkit/.git/HEAD"

  if [ -f "${git_head_file}" ] && [ "$(cat ${git_head_file})" == "${dev_content}" ]; then
    DEV_MODE=0
  fi

  debug "DEV_MODE=${DEV_MODE}"
}

init_common_vars() {
  if [[ $CURRENT_FILE_PATH == *.vscode* ]]; then
    PROJECT_ROOT_PATH=$(dirname $(dirname $(dirname "$CURRENT_FILE_PATH")))
  else
    PROJECT_ROOT_PATH=$(dirname $(dirname "$CURRENT_FILE_PATH"))
  fi
  debug "PROJECT_ROOT_PATH=$PROJECT_ROOT_PATH"

  WORKSPACE_PATH=$(dirname "$PROJECT_ROOT_PATH")
  debug "WORKSPACE_PATH=$WORKSPACE_PATH"

  _init_common_var_dev_mod
}
