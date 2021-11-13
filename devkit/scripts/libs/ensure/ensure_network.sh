#!/usr/bin/env bash

inspect_network() {
  docker network inspect $NETWORK_NAME >>$STDOUT 2>&1
}

check_network() {
  MSG1="$E_START️ Checking Network..."
  MSG2="$E_OK Found Network"
  MSG3="$E_OK Not Found Network"

  echo && echo "$MSG1" &&
  (inspect_network && echo "$MSG2") ||
  (echo "$MSG3" && false)
}

do_create_network() {
  docker network create --driver=bridge --subnet=$SUBNET --gateway=$GATEWAY $NETWORK_NAME >>$STDOUT
}

create_network() {
  MSG1="$E_START️ Creating Network..."
  MSG2="$E_OK Created Network"
  MSG3="$E_FAIL Failed to Create Network"

  echo "$MSG1" &&
  (do_create_network && echo "$MSG2") ||
  (echo "$MSG3" && false)
}

ensure_network() {
  check_network || create_network
}