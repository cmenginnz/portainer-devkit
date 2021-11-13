STDOUT="/tmp/portainer-dev-kit.log"


I_AM_IN_WORKSPACE="PORTAINER_WORKSPACE"
I_AM_IN_TARGET="PORTAINER_TARGET"

DEVKIT_SH_PATH="/home/workspace/portainer-devkit/devkit/scripts/devkit.sh"

TMUX_SES_NAME_WEBPACK="tmux-webpack-dev-watch"

NETWORK_NAME="portainer-devkit"
SUBNET="192.168.100.0/24"
GATEWAY="192.168.100.100"


WORKSPACE_NAME="portainer-workspace"


TARGET_K8S_IP="192.168.100.1"  # hard code in yaml file
TARGET_SWARM_IP="192.168.100.2"
TARGET_DOCKER_IP="192.168.100.3"
TARGET_WORKSPACE_IP="192.168.100.10"


TARGET_K8S_NAME="portainer-k8s"
TARGET_K8S_CONTAINER_NAME="portainer-k8s-control-plane"
TARGET_SWARM_NAME="portainer-swarm"
TARGET_DOCKER_NAME="portainer-docker"
TARGET_WORKSPACE_NAME="portainer-workspace"


PORTAINER_HTTP_PORT_IN_DEVKT=9000
PORTAINER_HTTPS_PORT_IN_DEVKT=9443

PORTAINER_HTTP_PORT_IN_K8S=19000
PORTAINER_HTTPS_PORT_IN_K8S=19443

# dlv ports are hard coded in launch.json and some yaml file
DLV_PORT_PORTAINER_IN_WORKSPACE=23451
DLV_PORT_PORTAINER_IN_K8S=23452
DLV_PORT_AGENT_IN_K8S=23461
DLV_PORT_AGENT_IN_SWARM=23462
DLV_PORT_AGENT_IN_DOCKER=23463


E_START="⭐ "
E_CHECK="✅"
E_CROSS="❌"
E_FLAG="🏁️"
E_BUG="🐞"
E_ING="⏳"

# portainer-agent
# portainer_edge_agent
# ssh password
SSH_PASSWORD="root"