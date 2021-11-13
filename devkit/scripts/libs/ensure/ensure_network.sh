#!/usr/bin/env bash

inspect_network() {
  docker network inspect $NETWORK_NAME >>$STDOUT 2>&1
}

check_network() {
  MSG0="Find Network"
  MSG1=$(msg_ing)
  MSG2=$(msg_ok)
  MSG3=$(msg_ok)

  echo && echo "$MSG1" &&
  (inspect_network && echo "$MSG2") ||
  (echo "$MSG3" && false)
}

do_create_network() {
  docker network create --driver=bridge --subnet=$SUBNET --gateway=$GATEWAY $NETWORK_NAME >>$STDOUT
}

create_network() {
  MSG0="Creat Network"
  MSG1=$(msg_ing)
  MSG2=$(msg_ok)
  MSG3=$(msg_fail)

  echo "$MSG1" &&
  (do_create_network && echo "$MSG2") ||
  (echo "$MSG3" && false)
}

ensure_network() {
  check_network || create_network
}