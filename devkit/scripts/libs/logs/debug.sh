_do_debug() {
  [[ "${DEVKIT_DEBUG}" == "true" ]] && echo "$E_MSG $E_BUG $(date "+%X") $*"
}

debug() {
  #local file="$(basename ${BASH_SOURCE[1]})"
  local func="${FUNCNAME[1]}"
  local msg="[${func}] $*"
  _do_debug $msg
}

debug_var() {
  local func="${FUNCNAME[1]}"

  local var_name=$1
  eval local var_value=\$${var_name}

  local msg="[${func}] ${var_name}=${var_value}"
  _do_debug "${msg}"
}