tmux_has_window() {
  local session_name="$1"
  local window_name="$2"
  tmux list-window -t "$session_name" -F "#{window_name}" | grep "$window_name"
}