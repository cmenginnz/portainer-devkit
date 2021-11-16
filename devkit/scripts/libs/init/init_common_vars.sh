#!/usr/bin/env bash

_init_dev_mod() {
  if [ -z "${DEV_MODE}" ]; then
    DEV_MODE="false"
    local dev_content="ref: refs/heads/dev"
    local git_head_file="${WORKSPACE_PATH}/portainer-devkit/.git/HEAD"

    if [ -f "${git_head_file}" ] && [ "$(cat ${git_head_file})" == "${dev_content}" ]; then
      DEV_MODE="true"
    fi
  fi

  debug_var "DEV_MODE"
}

_init_image_name() {
  if [ "${DEV_MODE}" == "true" ]; then
    IMAGE_NAME_AGENT="${IMAGE_NAME_AGENT}:dev"
    IMAGE_NAME_WORKSPACE="${IMAGE_NAME_WORKSPACE}:dev"

    debug_var "IMAGE_NAME_AGENT"
    debug_var "IMAGE_NAME_WORKSPACE"
  fi
}

_init_var_project_root_path() {
  if [[ $CURRENT_FILE_PATH == *.vscode* ]]; then
    # /home/workspace/portainer/.vscode/devkit/scripts/devkit.sh
    PROJECT_ROOT_PATH=$(dirname $(dirname $(dirname "$CURRENT_FILE_PATH")))
  else
    # /home/workspace/portainer-devkit/devkit/scripts/devkit.sh
    PROJECT_ROOT_PATH=$(dirname $(dirname "$CURRENT_FILE_PATH"))
  fi
  debug_var "PROJECT_ROOT_PATH"
}

_init_var_workspace_path() {
  WORKSPACE_PATH=$(dirname "$PROJECT_ROOT_PATH")
  debug_var "WORKSPACE_PATH"
}

_init_var_mute() {
  [[ "${DEVKIT_DEBUG}" == "true" ]] && MUTE="/dev/stdout" || MUTE="${STDOUT}"
  debug_var "MUTE"
}

_init_var_targets() {
  eval TARGET_IP=\$TARGET_IP_${TARGET^^}
  debug_var "TARGET_IP"

  eval TARGET_NAME=\$TARGET_NAME_${TARGET^^}
  debug_var "TARGET_NAME"
}

init_common_vars() {
  # PROJECT_ROOT_PATH
  _init_var_project_root_path

  # WORKSPACE_PATH
  _init_var_workspace_path

  # MUTE
  _init_var_mute

  # DEV_MODE
  _init_dev_mod

  # IMAGE_NAME_AGENT
  # IMAGE_NAME_WORKSPACE
  _init_image_name

  # TARGET_IP
  # TARGET_NAME
  _init_var_targets
}
