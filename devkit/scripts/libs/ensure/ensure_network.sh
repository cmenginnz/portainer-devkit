#!/usr/bin/env bash

inspect_network() {
  docker network inspect $NETWORK_NAME >>"${STDOUT}" 2>&1
}

check_network() {
  local MSG0="Find Network"

  msg && msg_ing "${MSG0}" &&
  (inspect_network && msg_ok "${MSG0}") ||
  (msg_warn "${MSG0}" && false)
}

do_create_network() {
  docker network create --driver=bridge --subnet=$SUBNET --gateway=$GATEWAY $NETWORK_NAME >>"${STDOUT}"
}

create_network() {
  local MSG0="Creat Network"

  msg_ing "${MSG0}" &&
  (do_create_network && msg_ok "${MSG0}") ||
  (msg_fail "${MSG0}" && false)
}

ensure_network() {
  check_network || create_network
}