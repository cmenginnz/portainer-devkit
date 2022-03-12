init_env_var() {
  mkdir -p /root/.ssh
  echo "# portainer-devkit envs" >> /root/.ssh/environment;
  env | grep NOMAD >> /root/.ssh/environment;
  env | grep KUBERNETES >> /root/.ssh/environment;
}
