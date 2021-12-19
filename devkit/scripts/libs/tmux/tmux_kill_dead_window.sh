_tmux_has_dead_window() {
  local session_name="$1"
  local window_name="$2"
  #tmux list-windows -t "${session_name}" -F "#{window_name}" -f "#{pane_dead}" 2>>"${STDOUT}" | grep "${window_name}" 2>>"${STDOUT}" 1>&2
  tmux list-windows -t "${session_name}" -F "#{window_name}" -f "#{pane_dead}" | grep "${window_name}" 
}

tmux_kill_dead_window() {
  local session_name="$1"
  local window_name="$2"  

  _tmux_has_dead_window $session_name $window_name && 
  tmux_kill_window $session_name $window_name
}