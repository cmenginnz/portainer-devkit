init_root_pw() {
    echo "root:${SSH_PASSWORD:-portainer}" | chpasswd
}