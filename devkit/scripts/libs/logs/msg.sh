msg() {
  #echo "$E_MSG️ $MSG0 $1"
  echo "$1" | tee -a "${STDOUT}"
}

msg_ing() {
  msg "$E_ING $1"
}

msg_ok() {
  msg "$E_OK $1"
}
 
msg_warn() {
  msg "$E_WARN $1"
}

msg_fail() {
  msg "$E_FAIL $1"
}

msg_info() {
  msg "$E_INFO $1"
}