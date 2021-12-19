#!/usr/bin/env bash

_do_build_portainer() {
  DIST="$PROJECT_ROOT_PATH/dist"
  BINARY_NAME="$DIST/portainer"

  mkdir -p "$DIST" &&
  cd "$PROJECT_ROOT_PATH/api/" &&
  go get -t -d -v ./... &&
  cd - >>"${STDOUT}" &&
  cd "$PROJECT_ROOT_PATH/api//cmd/portainer" &&
  go build --installsuffix cgo --ldflags="" -gcflags="all=-N -l" -o "$BINARY_NAME"  &&
  cd - >>"${STDOUT}"
}

_do_build_agent() {
  DIST="$PROJECT_ROOT_PATH/dist"
  BUILD_DIR="$PROJECT_ROOT_PATH/cmd/agent"
  BINARY_NAME="$DIST/agent"

  mkdir -p "$DIST" &&
  cd "$BUILD_DIR" &&
  go build --installsuffix cgo --ldflags="" -gcflags="all=-N -l" -o "$BINARY_NAME"  &&
  cd - >>"${STDOUT}"
}

_do_build_project() {
  if [[ $PROJECT == "portainer" ]]; then
    _do_build_portainer
  else
    _do_build_agent
  fi
}

build_project() {
  local MSG0="Build ${PROJECT^}"

  msg && msg_ing "${MSG0}" &&
  (_do_build_project && msg_ok "${MSG0}") ||
  (msg_fail "${MSG0}" && false)
}
