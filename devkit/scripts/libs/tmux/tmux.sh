#!/usr/bin/env bash

tmux_has_session() {
  local session_name="$1"
  tmux has-session -t "${session_name}" 2>$STDOUT 1>&2
}

tmux_has_window() {
  local session_name="$1"
  local window_name="$2"
  tmux list-window -t "$session_name" -F "#{window_name}" | grep "$window_name"
}

tmux_has_dead_window() {
  local session_name="$1"
  local window_name="$2"
  #tmux list-windows -t "${session_name}" -F "#{window_name}" -f "#{pane_dead}" 2>$STDOUT | grep "${window_name}" 2>$STDOUT 1>&2
  tmux -V
  tmux list-windows -t "${session_name}" -F "#{window_name}" -f "#{pane_dead}" | grep "${window_name}" 
}

tmux_switch_client() {
  local session_name="$1"
  tmux switch-client -t $session_name
}

# the window must in curren session
tmux_kill_window() {
  local window_name="$1"
  tmux kill-window -t $window_name
}

tmux_kill_dead_window() {
  local session_name="$1"
  local window_name="$2"  

  tmux_has_dead_window $session_name $window_name && 
  tmux_switch_client $session_name && 
  tmux_kill_window $window_name
}

tmux_new_window() {
  local session_name="$1"
  local window_name="$2"
  local cmd="$3"

  echo "debug tmux new window"
  tmux new-window -t "$session_name" -n "$window_name" "$cmd"


  # tmux_has_dead_window $session_name $window_name && 
  # tmux_switch_client $session_name && 
  # tmux_kill_window $window_name
}

tmux_init_server() {
  tmux start \; set-option -g -s exit-empty off \; set-option -g remain-on-exit on
}


# misc vscode
# ee/ce webpack portainer
# agent k8s swarm docker 
