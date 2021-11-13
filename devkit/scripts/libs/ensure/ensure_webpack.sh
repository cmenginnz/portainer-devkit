#!/usr/bin/env bash

_check_webpack() {
  tmux ls 2>/dev/null | grep "$TMUX_NAME_WEBPACK" >/dev/null
}

_do_start_webpack() {
  cd "$PROJECT_ROOT_PATH" && yarn install && tmux new -s "$TMUX_NAME_WEBPACK" -d yarn start:client
}

ensure_webpack() {
  MSG1="$E_START️ Finding Webpack Dev Watch..."
  MSG2="$E_OK Found Webpack Dev Watch"
  MSG3="$E_START️ Starting Webpack Dev Watch..."
  MSG4="$E_OK Started Webpack Dev Watch"
  MSG5="$E_FAIL Failed to Start Webpack Dev Watch"

  (echo "$MSG1" && _check_webpack && echo "$MSG2") ||
  (echo "$MSG3" && _do_start_webpack && echo "$MSG4") ||
  (echo "$MSG5" && false)
}