_do_msg() {
  #echo "$E_MSG️ $MSG0 $1"
  echo "$1 $MSG0"
}

msg_ing() {
  _do_msg "$E_ING"
}

msg_ok() {
  _do_msg "$E_OK"
}

msg_warn() {
  _do_msg "$E_WARN"
}

msg_fail() {
  _do_msg "$E_FAIL"
}

msg_info() {
  _do_msg "$E_INFO"
}