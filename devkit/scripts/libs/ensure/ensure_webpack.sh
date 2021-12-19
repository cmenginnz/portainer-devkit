#!/usr/bin/env bash

_check_webpack() {
  tmux_kill_dead_window $TMUX_SESSION_NAME webpack
  tmux_has_window $TMUX_SESSION_NAME webpack
}

_do_start_webpack() {
  cd "$PROJECT_ROOT_PATH" && tmux_new_window $TMUX_SESSION_NAME webpack "yarn && yarn start:client"
}

ensure_webpack() {
  local MSG0="Find Webpack"
  local MSG1="Start Webpack"

  tmux_name="${TMUX_NAME_WEBPACK}-${PROJECT_VER}"

  (msg_ing "${MSG0}" && _check_webpack && msg_ok "${MSG0}") ||
  (msg_warn "${MSG0}" && msg && msg_ing "${MSG1}" && _do_start_webpack && msg_ok "${MSG1}") ||
  (msg_fail "${MSG1}" && false)
}