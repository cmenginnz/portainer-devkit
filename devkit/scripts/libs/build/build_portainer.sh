#!/usr/bin/env bash

_do_build_portainer() {
  mkdir -p "$PROJECT_ROOT_PATH/dist"
  cd "$PROJECT_ROOT_PATH/api/cmd/portainer"
  go build --installsuffix cgo --ldflags="" -gcflags="all=-N -l" -o "${PROJECT_ROOT_PATH}/dist/portainer" && cd - >/dev/null
}

build_portainer() {
  MSG0="Built Portainer"
  MSG1=$(msg_ing)
  MSG2=$(msg_ok)
  MSG3=$(msg_fail)

  echo && echo "$MSG1" &&
  (_do_build_portainer && echo "$MSG2") ||
  (echo "$MSG3" && false)
}

