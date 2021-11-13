#!/usr/bin/env bash

_check_webpack() {
  tmux ls 2>/dev/null | grep "$TMUX_NAME_WEBPACK" >/dev/null
}

_do_start_webpack() {
  cd "$PROJECT_ROOT_PATH" && yarn install && tmux new -s "$TMUX_NAME_WEBPACK" -d yarn start:client
}

ensure_webpack() {
  MSG0="Find Webpack"
  MSG1=$(msg_ing)
  MSG2=$(msg_ok)
  MSG3=$(msg_warn)

  MSG0="Start Webpack"
  MSG4=$(msg_ing)
  MSG5=$(msg_ok)
  MSG6=$(msg_fail)

  (echo "$MSG1" && _check_webpack && echo "$MSG2") ||
  (echo $MSG3 && echo && echo "$MSG4" && _do_start_webpack && echo "$MSG5") ||
  (echo "$MSG6" && false)
}