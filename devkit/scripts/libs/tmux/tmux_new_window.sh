#!/usr/bin/env bash

# session    window
# ----------------------------
# misc       vscode
# ee/ce      webpack/portainer
# agent      k8s/swarm/docker 

_tmux_has_session() {
  local session_name="$1"
  tmux has-session -t "${session_name}" 2>$STDOUT 1>&2
}

_tmux_switch_client() {
  local session_name="$1"
  local window_name="$2"
  [[ -z "$window_name" ]] && tmux switch-client -t $session_name || tmux switch-client -t $session_name:$window_name
  true  
}

_tmux_init_server() {
  tmux start \; set-option -g -s exit-empty off \; set-option -g remain-on-exit on
}

tmux_new_window() {
  local session_name="$1"
  local window_name="$2"
  local cmd="$3"

  _tmux_init_server

  if _tmux_has_session "${session_name}"; then
    tmux new-window -d -t "$session_name" -n "$window_name" "$cmd"
  else
    tmux new-session -d -s "$session_name" -n "$window_name" "$cmd"
  fi

  _tmux_switch_client "$session_name" "$window_name"

  MSG0="Check logs: tmux attach -t $session_name:$window_name"
  MSG1=$(msg_info)
  echo "$MSG1"
}
