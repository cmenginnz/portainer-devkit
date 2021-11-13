#!/usr/bin/env bash

_do_build_portainer() {
  mkdir -p "$PROJECT_ROOT_PATH/dist"
  cd "$PROJECT_ROOT_PATH/api/cmd/portainer"
  go build --installsuffix cgo --ldflags="" -gcflags="all=-N -l" -o "${PROJECT_ROOT_PATH}/dist/portainer" && cd - >/dev/null
}

build_portainer() {
  MSG1="$E_START️ Building Portainer..."
  MSG2="$E_OK Built Portainer"
  MSG3="$E_FAIL Build Portainer"

  echo && echo "$MSG1" &&
  (_do_build_portainer && echo "$MSG2") ||
  (echo "$MSG3" && false)
}

