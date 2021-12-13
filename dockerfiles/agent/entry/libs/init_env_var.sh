init_env_var() {
  mkdir -p /root/.ssh
  # echo "" > /root/.ssh/environment;
  env | grep KUBERNETES >> /root/.ssh/environment;
}