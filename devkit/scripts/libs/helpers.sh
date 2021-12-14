#!/usr/bin/env bash






_do_ssh() {
  sshpass -p "$SSH_PASSWORD" ssh "$SSH_USER_REAL"@"$TARGET_IP" true >>$STDOUT 2>&1
}

wait_sshd() {
  MSG0="Check SSH Server"
  MSG1=$(msg_ing)
  MSG2=$(msg_ok)

  echo && echo $MSG1
  until _do_ssh; do
    sleep 5;
    echo $MSG1
  done
  echo $MSG2
}


kill_dlv() {
  (killall dlv >/dev/null 2>&1 && sleep 1) || true
}
