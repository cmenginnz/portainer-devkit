# the window must in curren session
tmux_kill_window() {
  local session_name="$1"
  local window_name="$2"  
  tmux kill-window -t "$session_name:$window_name"
}
