#!/usr/bin/env bash

_do_build_project() {
  DIST="$PROJECT_ROOT_PATH/dist"
  [[ $PROJECT == "portainer" ]] && BUILD_DIR="$PROJECT_ROOT_PATH/api/cmd/portainer" || BUILD_DIR="$PROJECT_ROOT_PATH/cmd/agent"
  [[ $PROJECT == "portainer" ]] && BINARY_NAME="$DIST/portainer" || BINARY_NAME="$DIST/agent"

  mkdir -p "$DIST" &&
  cd "$BUILD_DIR" &&
  go build --installsuffix cgo --ldflags="" -gcflags="all=-N -l" -o "$BINARY_NAME"  &&
  cd - >>"$STDOUT"
}

build_project() {
  MSG0="Built ${PROJECT^}"
  MSG1=$(msg_ing)
  MSG2=$(msg_ok)
  MSG3=$(msg_fail)

  echo && echo "$MSG1" &&
  (_do_build_project && echo "$MSG2") ||
  (echo "$MSG3" && false)
}
