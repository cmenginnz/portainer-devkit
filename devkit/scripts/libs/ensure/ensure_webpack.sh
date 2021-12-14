#!/usr/bin/env bash

_check_webpack() {
  tmux_kill_dead_window ee webpack
  tmux_has_window ee webpack
  #tmux has-session -t "${tmux_name}" 2>$STDOUT 1>&2
}

_do_start_webpack() {
  # cd "$PROJECT_ROOT_PATH" && yarn install && tmux new -s "${tmux_name}" -d yarn start:client
  #tmux set-option -w remain-on-exit
  #tmux set set-remain-on-exit on
  # tmux start \; set-option -g -s exit-empty off \; set-option -g remain-on-exit on
  # tmux set-option -g remain-on-exit on
  # tmux list-windows -f "#{window_name}==w2" -F "#{window_name} #{pane_dead}"
  # tmux list-window -t s1 -F "#{window_name}" -f "#{pane_dead}"
  # tmux switch-client -t s1
  cd "$PROJECT_ROOT_PATH" && tmux_new_window $TMUX_SESSION_NAME webpack "yarn && yarn start:client"
  #cd "$PROJECT_ROOT_PATH" && tmux new -s "${tmux_name}" -d "(yarnx && yarn start:client) || sleep 3"
  #sleep 1
  #tmux set-option -w remain-on-exit
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

  tmux_name="${TMUX_NAME_WEBPACK}-${PROJECT_VER}"

  (echo "$MSG1" && _check_webpack && echo "$MSG2") ||
  (echo $MSG3 && echo && echo "$MSG4" && _do_start_webpack && echo "$MSG5") ||
  (echo "$MSG6" && false)
}