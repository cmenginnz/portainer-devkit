#!/usr/bin/env bash

init_common_vars() {
  if [[ $CURRENT_FILE_PATH == *.vscode* ]]; then
    PROJECT_ROOT_PATH=$(dirname $(dirname $(dirname "$CURRENT_FILE_PATH")))
  else
    PROJECT_ROOT_PATH=$(dirname $(dirname "$CURRENT_FILE_PATH"))
  fi
  debug "[devkit.sh] [init_common_vars()] PROJECT_ROOT_PATH=$PROJECT_ROOT_PATH"
}
