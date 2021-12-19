#!/usr/bin/env bash






_do_ssh() {
  sshpass -p "$SSH_PASSWORD" ssh "$SSH_USER_REAL"@"$TARGET_IP" true >>"${STDOUT}" 2>&1
}

wait_sshd() {
  local MSG0="Check SSH Server"

  msg && msg_ing "${MSG0}"
  until _do_ssh; do
    sleep 5;
    msg_ing "${MSG0}"
  done
  msg_ok "${MSG0}"
}


kill_dlv() {
  (killall dlv >/dev/null 2>&1 && sleep 1) || true
}
