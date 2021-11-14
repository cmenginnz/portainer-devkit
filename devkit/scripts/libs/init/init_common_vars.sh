#!/usr/bin/env bash

_init_dev_mod() {
  DEV_MODE=1
  local dev_content="ref: refs/heads/dev"
  local git_head_file="${WORKSPACE_PATH}/portainer-devkit/.git/HEAD"

  if [ -f "${git_head_file}" ] && [ "$(cat ${git_head_file})" == "${dev_content}" ]; then
    DEV_MODE=0
  fi

  debug_var "DEV_MODE"
}

_init_image_name() {
  if [ $DEV_MODE ]; then
    IMAGE_NAME_AGENT="${IMAGE_NAME_AGENT}:dev"
    IMAGE_NAME_WORKSPACE="${IMAGE_NAME_WORKSPACE}:dev"

    debug_var "IMAGE_NAME_AGENT"
    debug_var "IMAGE_NAME_WORKSPACE"
  fi
}

init_common_vars() {
  if [[ $CURRENT_FILE_PATH == *.vscode* ]]; then
    PROJECT_ROOT_PATH=$(dirname $(dirname $(dirname "$CURRENT_FILE_PATH")))
  else
    PROJECT_ROOT_PATH=$(dirname $(dirname "$CURRENT_FILE_PATH"))
  fi
  debug_var "PROJECT_ROOT_PATH"

  WORKSPACE_PATH=$(dirname "$PROJECT_ROOT_PATH")
  debug_var "WORKSPACE_PATH"

  [[ "${DEVKIT_DEBUG}" == "true" ]] && MUTE="/dev/stdout" || MUTE="${STDOUT}"
  debug_var "MUTE"

  _init_dev_mod
  _init_image_name
}
